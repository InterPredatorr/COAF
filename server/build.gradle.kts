plugins {
    id("org.jetbrains.kotlin.jvm") version "2.0.0"
    id("io.ktor.plugin") version "2.3.12"
    kotlin("plugin.serialization") version "1.9.10"
    id("app.cash.sqldelight") version "2.0.2"
    application
}

group = "app.coaf.org"
version = "1.0.0"
application {
    mainClass.set("io.ktor.server.netty.EngineMain")
    applicationDefaultJvmArgs = listOf("-Dio.ktor.development=${extra["io.ktor.development"] ?: "false"}")
}

ktor {
    fatJar {
        archiveFileName.set("COAF.jar")
    }
}

dependencies {
    implementation(projects.shared)
    implementation(libs.logback)
    implementation(platform(libs.ktor.bom))
    implementation(libs.ktor.server.core)
    implementation(libs.ktor.server.netty)
    testImplementation(libs.ktor.server.tests)
    testImplementation(libs.kotlin.test.junit)
    implementation(libs.ktor.server.status.pages)
    implementation(libs.ktor.server.content.negotiation)
    implementation(libs.ktor.server.default.headers)
    implementation(libs.ktor.server.call.logging)
    implementation(libs.ktor.serialization.kotlinx.json.jvm)
    implementation(project.dependencies.platform(libs.koin.bom))
    implementation(libs.koin.ktor)
    implementation(libs.koin.logger.slf4j)
    implementation(libs.postgresql)
    implementation(libs.hikaricp)
    implementation(libs.jdbc.driver)
    implementation(libs.logback)
    implementation(libs.log4j.core)
    implementation(libs.log4j.slf4j.impl)
    implementation(libs.exposed.core)
    implementation(libs.exposed.jdbc)
    implementation(libs.exposed.dao)
}

sqldelight {
    databases {
        create("ServerDatabase") {
            packageName = "app.coaf.server"
            dialect("app.cash.sqldelight:postgresql-dialect:2.0.2")
        }
    }
}