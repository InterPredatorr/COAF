package app.coaf.org.repository.user.extensions

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.response.respond
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject

suspend fun ApplicationCall.validateClubs(json: JsonObject) {
    json["clubs"]?.jsonArray?.forEach { club ->
        val clubObj = club.jsonObject
        if (setOf("id", "name", "position").containsAll(clubObj.keys).not()) {
            this.respond(HttpStatusCode.BadRequest, "Invalid fields in 'clubs'.")
            return
        }
    }
}

