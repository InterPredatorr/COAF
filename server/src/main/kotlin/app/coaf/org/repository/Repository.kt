package app.coaf.org.repository

import app.coaf.org.model.RemoteConfig

interface Repository {
    suspend fun getRemoteConfigs(): RemoteConfig
}