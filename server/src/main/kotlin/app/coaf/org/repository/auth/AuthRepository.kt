package app.coaf.org.repository.auth

interface AuthRepository {
    suspend fun register()
}