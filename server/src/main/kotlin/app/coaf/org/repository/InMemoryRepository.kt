package app.coaf.org.repository

import app.coaf.org.model.RemoteConfig

class InMemoryRepository: Repository {

    private var config: RemoteConfig? = null

    override suspend fun getRemoteConfigs(): RemoteConfig {
        val tmpConfig = RemoteConfig("")
        this.config = tmpConfig
        return tmpConfig
    }
}