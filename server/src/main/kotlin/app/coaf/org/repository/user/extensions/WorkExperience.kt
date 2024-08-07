package app.coaf.org.repository.user.extensions

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.response.respond
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject


suspend fun ApplicationCall.validateExperiences(json: JsonObject) {
    json["workExperiences"]?.jsonArray?.forEach { workExperience ->
        val workExperienceObj = workExperience.jsonObject
        if (setOf("id", "employee", "position", "employmentType", "startDate", "endDate").containsAll(workExperienceObj.keys).not()) {
            this.respond(HttpStatusCode.BadRequest, "Invalid fields in 'workExperiences'.")
            return
        }
    }
}

