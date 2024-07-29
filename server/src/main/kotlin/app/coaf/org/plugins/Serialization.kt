package app.coaf.org.plugins

import app.coaf.org.repository.UserRepository
import app.coaf.org.repository.processUserRequest
import io.ktor.http.HttpStatusCode
import io.ktor.serialization.kotlinx.json.json
import io.ktor.server.application.Application
import io.ktor.server.application.call
import io.ktor.server.application.install
import io.ktor.server.plugins.contentnegotiation.ContentNegotiation
import io.ktor.server.response.respond
import io.ktor.server.routing.delete
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import io.ktor.server.routing.put
import io.ktor.server.routing.routing


fun Application.configureSerialization(repository: UserRepository) {
    install(ContentNegotiation) {
        json()
    }
    routing {
        get("/user/{email}") {
            val email = call.parameters["email"]
            if (email == null) {
                call.respond(HttpStatusCode.BadRequest)
                return@get
            }
            val user = repository.getUser(email)
            if (user != null) {
                call.respond(HttpStatusCode.OK, user)
            } else {
                call.respond(HttpStatusCode.NotFound, "Invalid user ID")
            }
        }

        post("/users") {
            call.processUserRequest(repository, isUpdate = false)
        }

        put("/users/{email}") {
            call.processUserRequest(repository, isUpdate = true)
        }

        delete("/users/{email}") {
            val email = call.parameters["email"]
            if (email != null) {
                repository.deleteUser(email)
                call.respond(HttpStatusCode.OK, "User deleted successfully")
            } else {
                call.respond(HttpStatusCode.BadRequest, "Invalid user ID")
            }
        }
    }
}
