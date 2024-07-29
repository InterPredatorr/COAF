package app.coaf.org.plugins

import app.coaf.org.db.UsersTable
import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import io.ktor.server.application.Application
import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.SchemaUtils
import org.jetbrains.exposed.sql.transactions.transaction

fun Application.configureDatabases() {
    val driverClass = environment.config.property("storage.driverClassName").getString()
    val jdbcUrl = environment.config.property("storage.jdbcURL").getString()
    val db = Database.connect(provideDataSource(jdbcUrl,driverClass, "coaf", "coaf"))
    transaction(db) {
        SchemaUtils.create(UsersTable)
    }
}

private fun provideDataSource(url:String, driverClass:String, username: String, password: String): HikariDataSource {
    val hikariConfig= HikariConfig().apply {
        driverClassName = driverClass
        jdbcUrl = url
        setUsername(username)
        setPassword(password)
        validate()
    }
    return HikariDataSource(hikariConfig)
}