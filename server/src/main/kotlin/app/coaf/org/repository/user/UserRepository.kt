package app.coaf.org.repository

import entity.Gender
import entity.User
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.contentOrNull
import kotlinx.serialization.json.decodeFromJsonElement
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import kotlin.reflect.KClass
import kotlin.reflect.full.memberProperties

interface UserRepository {
    suspend fun addUser(user: User):User?
    suspend fun updateUser(user: User):Boolean
    suspend fun deleteUser(email: String):Boolean
    suspend fun getUsers():List<User>
    suspend fun searchUser(query: String):List<User>
    suspend fun getUser(email: String):User?
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

suspend fun ApplicationCall.processUserRequest(repository: UserRepository, isUpdate: Boolean) {
    val jsonPayload = receive<JsonObject>()
    if (!validateUser(repository,this, jsonPayload, isUpdate)) {
        return
    }

    val user = Json.decodeFromJsonElement<User>(jsonPayload)

    if (isUpdate) {
        val userEmail = parameters["email"] ?: return respond(HttpStatusCode.BadRequest, "Missing user email")
        if (repository.getUser(userEmail) == null) {
            return respond(HttpStatusCode.NotFound, "User not found")
        }
        repository.updateUser(user)
        respond(HttpStatusCode.OK, "User updated successfully")
    } else {
        repository.addUser(user)
        respond(HttpStatusCode.Created, "User created successfully")
    }
}

suspend fun validateUser(repository: UserRepository, call: ApplicationCall, jsonPayload: JsonObject, isUpdate: Boolean): Boolean {
    val validFields = repository.getUserFieldKeys().toSet()

    val invalidFields = jsonPayload.keys - validFields
    if (invalidFields.isNotEmpty()) {
        call.respond(HttpStatusCode.BadRequest, "Invalid fields: ${invalidFields.joinToString()}")
        return false
    }

    if (isUpdate) {
        val genderField = jsonPayload["gender"]?.jsonPrimitive?.contentOrNull
        if (genderField != null && Gender.entries.toTypedArray()
                .none { it.name.equals(genderField, ignoreCase = true) }) {
            call.respond(HttpStatusCode.BadRequest, "Invalid value for 'gender'.")
            return false
        }
        validateNestedObjects(call, jsonPayload)
    } else {
        val requiredFields = setOf("name", "surname", "email")
        val missingFields = requiredFields - jsonPayload.keys
        if (missingFields.isNotEmpty()) {
            call.respond(HttpStatusCode.BadRequest, "Missing required fields: ${missingFields.joinToString()}")
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
    }
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

    jsonPayload["educations"]?.jsonArray?.forEach { education ->
        val educationObj = education.jsonObject
        if (educationObj.keys != setOf("id", "universityName", "faculty", "department", "startDate", "endDate")) {
            call.respond(HttpStatusCode.BadRequest, "Invalid fields in 'educations'.")
            return
        }
    }

    jsonPayload["workExperiences"]?.jsonArray?.forEach { workExperience ->
        val workExperienceObj = workExperience.jsonObject
        if (workExperienceObj.keys != setOf("id", "employee", "position", "employmentType", "startDate", "endDate")) {
            call.respond(HttpStatusCode.BadRequest, "Invalid fields in 'workExperiences'.")
            return
        }
    }

    jsonPayload["activities"]?.jsonArray?.forEach { activity ->
        val activityObj = activity.jsonObject
        if (activityObj.keys != setOf("id", "name", "startDate", "endDate")) {
            call.respond(HttpStatusCode.BadRequest, "Invalid fields in 'activities'.")
            return
        }
    }

    jsonPayload["certificates"]?.jsonArray?.forEach { certificate ->
        val certificateObj = certificate.jsonObject
        if (certificateObj.keys != setOf("providerName", "yearOfProvision", "name")) {
            call.respond(HttpStatusCode.BadRequest, "Invalid fields in 'certificates'.")
            return
        }
    }

    jsonPayload["skills"]?.jsonArray?.forEach { skill ->
        if (!skill.jsonPrimitive.contentOrNull.isNullOrEmpty()) {
            call.respond(HttpStatusCode.BadRequest, "Invalid value in 'skills'.")
            return
        }
    }

    jsonPayload["programs"]?.jsonArray?.forEach { program ->
        val programObj = program.jsonObject
        if (programObj.keys != setOf("id", "name", "issueDate")) {
            call.respond(HttpStatusCode.BadRequest, "Invalid fields in 'programs'.")
            return
        }
    }

    jsonPayload["clubs"]?.jsonArray?.forEach { club ->
        val clubObj = club.jsonObject
        if (clubObj.keys != setOf("id", "name", "position")) {
            call.respond(HttpStatusCode.BadRequest, "Invalid fields in 'clubs'.")
            return
        }
    }
}