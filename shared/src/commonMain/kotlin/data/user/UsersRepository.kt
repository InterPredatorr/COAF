package data.user

import domain.entity.User
import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.engine.cio.CIO
import io.ktor.client.plugins.HttpTimeout
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.plugins.defaultRequest
import io.ktor.client.request.get
import io.ktor.client.request.put
import io.ktor.client.request.setBody
import io.ktor.http.ContentType
import io.ktor.http.contentType
import io.ktor.http.path
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.json.Json

class UsersRepository {

    private val client = HttpClient(CIO) {
        defaultRequest {
            host = "10.2.20.117"
            port = 1234
        }
        install(ContentNegotiation) {
            json(
                Json {
                    ignoreUnknownKeys = true
                    isLenient = true
                    prettyPrint = true
                    useArrayPolymorphism = false
                }
            )
        }
        install(HttpTimeout) {
            requestTimeoutMillis = 30000
        }
        expectSuccess = true
    }

    private val _users: MutableList<User> = mutableListOf()

    var currentUser: User? = null

    val users: List<User>
        get() = _users

    @Throws(Throwable::class)
    suspend fun getUser(id: Int): User {
        val user: User = client.get("user/$id").body()
        currentUser = user
        return user
    }

    fun createUser(user: User): Boolean {
        _users.add(user)
        return true
    }

    @Throws(Throwable::class)
    suspend fun updateUser(user: User): User {
        return client.put {
            url {
                path("users/${user.id}")
            }
            contentType(ContentType.Application.Json)
            setBody(user)
        }.body()
    }

    fun deleteUser(id: Int): Boolean {
        _users.removeAll { it.id == id }
        return true

    }
}