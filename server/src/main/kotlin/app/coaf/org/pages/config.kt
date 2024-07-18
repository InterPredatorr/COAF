package app.coaf.org.pages

import app.coaf.org.api.config
import io.ktor.server.application.call
import io.ktor.server.response.respondText
import io.ktor.server.routing.Route
import io.ktor.server.routing.get

fun Route.config() {
    get(config) {
        call.respondText("Remote Config")
    }
}