package app.coaf.org.di

import app.coaf.org.repository.PostgresUserRepository
import app.coaf.org.repository.UserRepository
import org.koin.dsl.module

val appModule = module {
    single<UserRepository> {
        PostgresUserRepository()
    }
}