package app.coaf.org.repository.user.extensions

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.response.respond
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject


suspend fun ApplicationCall.validatePrograms(json: JsonObject) {
    json["programs"]?.jsonArray?.forEach { program ->
        val programObj = program.jsonObject
        if (setOf("id", "name", "issueDate").containsAll(programObj.keys).not()) {
            this.respond(HttpStatusCode.BadRequest, "Invalid fields in 'programs'.")
            return
        }
    }
}


