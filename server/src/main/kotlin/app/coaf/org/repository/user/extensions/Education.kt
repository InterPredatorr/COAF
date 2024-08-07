package app.coaf.org.repository.user.extensions

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.response.respond
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject

suspend fun ApplicationCall.validateEducations(json: JsonObject) {
    json["educations"]?.jsonArray?.forEach { education ->
        val educationObj = education.jsonObject
        if (setOf(
                "id",
                "universityName",
                "faculty",
                "department",
                "startDate",
                "endDate"
            ).containsAll(educationObj.keys).not()
        ) {
            this.respond(HttpStatusCode.BadRequest, "Invalid fields in 'educations'.")
            return
        }
    }
}