package app.coaf.org.repository.user

import app.coaf.org.repository.user.extensions.validateActivities
import app.coaf.org.repository.user.extensions.validateCertificates
import app.coaf.org.repository.user.extensions.validateClubs
import app.coaf.org.repository.user.extensions.validateEducations
import app.coaf.org.repository.user.extensions.validateExperiences
import app.coaf.org.repository.user.extensions.validatePrograms
import domain.entity.Gender
import domain.entity.User
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.contentOrNull
import kotlinx.serialization.json.decodeFromJsonElement
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlin.reflect.KClass
import kotlin.reflect.full.memberProperties

interface UserRepository {
    suspend fun addUser(user: User): User?
    suspend fun updateUser(user: User): User
    suspend fun deleteUser(id: Int): Boolean
    suspend fun getUsers(): List<User>
    suspend fun searchUser(query: String): List<User>
    suspend fun getUser(id: Int): User?
}

suspend fun UserRepository.delete(call: ApplicationCall, repository: UserRepository) {
    val id = call.parameters["id"]
    if (id != null) {
        val intId = id.toInt()
        repository.deleteUser(intId)
        call.respond(HttpStatusCode.OK, "User deleted successfully")
    } else {
        call.respond(HttpStatusCode.BadRequest, "Invalid user ID")
    }
}

suspend fun UserRepository.get(call: ApplicationCall, repository: UserRepository) {
    val id = call.parameters["id"]
    if (id == null) {
        call.respond(HttpStatusCode.BadRequest, "id is not provided")
    }
    val user = repository.getUser(id!!.toInt())
    if (user != null) {
        call.respond(HttpStatusCode.OK, user)
    } else {
        call.respond(HttpStatusCode.NotFound, "Invalid user id")
    }
}


suspend fun UserRepository.post(call: ApplicationCall, repository: UserRepository) {
    val jsonPayload = call.receive<JsonObject>()

    val user = Json.decodeFromJsonElement<User>(jsonPayload)
    val requiredFields = setOf("name", "surname", "email", "gender")
    val missingFields = requiredFields - jsonPayload.keys
    if (missingFields.isNotEmpty()) {
        call.respond(HttpStatusCode.BadRequest, "Missing required fields: ${missingFields.joinToString()}")
    }

    if (!validateUser(repository,call, jsonPayload)) return

    repository.addUser(user)
    call.respond(HttpStatusCode.Created, "User created successfully")
}

suspend fun UserRepository.put(call: ApplicationCall, repository: UserRepository) {
    val id = call.parameters["id"] ?: return call.respond(HttpStatusCode.BadRequest, "Missing user id")
    val jsonPayload = call.receive<JsonObject>()

    if (!validateUser(repository,call, jsonPayload)) return

    val user = Json.decodeFromJsonElement<User>(jsonPayload)
    if (repository.getUser(id.toInt()) == null) {
        return call.respond(HttpStatusCode.NotFound, "User not found")
    } else {

        call.respond(HttpStatusCode.OK, repository.updateUser(user))
    }
}

fun UserRepository.getUserFieldKeys(): Set<String> {
    return getFieldKeys(User::class)
}

fun UserRepository.getFieldKeys(klass: KClass<*>): Set<String> {
    val keys = mutableSetOf<String>()

    for (property in klass.memberProperties) {
        val propertyName = property.name
        keys.add(propertyName)

        val propertyType = property.returnType.classifier as? KClass<*> ?: continue

        if (propertyType.isData) {
            keys.addAll(getFieldKeys(propertyType))
        } else if (property.returnType.isMarkedNullable) {
            val nullableType = property.returnType.arguments.firstOrNull()?.type?.classifier as? KClass<*>
            if (nullableType?.isData == true) {
                keys.addAll(getFieldKeys(nullableType))
            }
        }
    }
    return keys
}

suspend fun validateUser(repository: UserRepository, call: ApplicationCall, jsonPayload: JsonObject): Boolean {
    val validFields = repository.getUserFieldKeys().toSet()

    val invalidFields = jsonPayload.keys - validFields
    if (invalidFields.isNotEmpty()) {
        call.respond(HttpStatusCode.BadRequest, "Invalid fields: ${invalidFields.joinToString()}")
        return false
    }
    val genderField = jsonPayload["gender"]?.jsonPrimitive?.contentOrNull
    if (genderField != null && Gender.entries.toTypedArray()
            .none { it.name.equals(genderField, ignoreCase = true) }) {
        call.respond(HttpStatusCode.BadRequest, "Invalid value for 'gender'.")
        return false
    }
    validateNestedObjects(call, jsonPayload)
    validateLists(call, jsonPayload)
    return true
}

suspend fun validateNestedObjects(call: ApplicationCall, jsonPayload: JsonObject) {
    val addressFields = setOf("country", "region", "city")
    jsonPayload["placeOfBirth"]?.jsonObject?.let { placeOfBirth ->
        if ((placeOfBirth.keys - addressFields).isNotEmpty()) {
            call.respond(HttpStatusCode.BadRequest, "Invalid fields in 'placeOfBirth'.")
        }
    }
    jsonPayload["currentResidence"]?.jsonObject?.let { currentResidence ->
        if ((currentResidence.keys - addressFields).isNotEmpty()) {
            call.respond(HttpStatusCode.BadRequest, "Invalid fields in 'currentResidence'.")
        }
    }
}

suspend fun validateLists(call: ApplicationCall, jsonPayload: JsonObject) {
    call.validateEducations(jsonPayload)
    call.validateExperiences(jsonPayload)
    call.validateActivities(jsonPayload)
    call.validateCertificates(jsonPayload)
    call.validateClubs(jsonPayload)
    call.validatePrograms(jsonPayload)
}