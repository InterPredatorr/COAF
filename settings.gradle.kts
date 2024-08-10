rootProject.name = "COAF"
enableFeaturePreview("TYPESAFE_PROJECT_ACCESSORS")

pluginManagement {
    repositories {
        google {
            content {
                includeGroup("androidx")
                includeGroup("com.android")
                includeGroup("com.google")
            }
        }
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositories {
        google {
            content {
                includeGroup("androidx")
                includeGroup("com.android")
                includeGroup("com.google")
            }
        }
        mavenCentral()
    }
}

include(":composeApp")
include(":server")
include(":shared")