package app.coaf.org.repository.user.extensions

import io.ktor.http.HttpStatusCode
import io.ktor.server.application.ApplicationCall
import io.ktor.server.response.respond
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.jsonArray
import kotlinx.serialization.json.jsonObject

suspend fun ApplicationCall.validateCertificates(json: JsonObject) {
    json["certificates"]?.jsonArray?.forEach { certificate ->
        val certificateObj = certificate.jsonObject
        if (setOf("providerName", "yearOfProvision", "name").containsAll(certificateObj.keys).not()) {
            this.respond(HttpStatusCode.BadRequest, "Invalid fields in 'certificates'.")
            return
        }
    }
}

