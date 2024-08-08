package app.coaf.org

import app.coaf.org.plugins.configureDI
import app.coaf.org.plugins.configureDatabases
import app.coaf.org.plugins.configureRouting
import app.coaf.org.plugins.configureSerialization
import app.coaf.org.repository.PostgresUserRepository
import io.ktor.server.application.Application
import io.ktor.server.engine.embeddedServer
import io.ktor.server.netty.Netty

fun main(args: Array<String>) {
    io.ktor.server.netty.EngineMain.main(args)
}

fun Application.module() {
    val repository = PostgresUserRepository()
    configureSerialization(repository)
    configureDI()
    configureDatabases()
    configureRouting()
}