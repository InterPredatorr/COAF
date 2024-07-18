package app.coaf.org.api

import app.coaf.org.API_VERSION
import app.coaf.org.repository.Repository
import io.ktor.server.application.call
import io.ktor.server.response.respondText
import io.ktor.server.routing.Route
import io.ktor.server.routing.get

const val config = "/config"
const val REMOTE_CONFIG_ENDPOINT = "$API_VERSION$config"

fun Route.config(db: Repository) {
    get(config) {

        call.respondText(db.getRemoteConfigs().toString())
    }
}