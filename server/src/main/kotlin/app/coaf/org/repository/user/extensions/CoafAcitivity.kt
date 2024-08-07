package app.coaf.org.repository.user.extensions

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.response.respond
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject



suspend fun ApplicationCall.validateActivities(json: JsonObject) {
    json["activities"]?.jsonArray?.forEach { activity ->
        val activityObj = activity.jsonObject
        if (setOf("id", "name", "startDate", "endDate").containsAll(activityObj.keys).not()) {
            this.respond(HttpStatusCode.BadRequest, "Invalid fields in 'activities'.")
            return
        }
    }
}

