package domain.utils
import fileReaderProvider
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json

@Serializable
data class AppConfig(
    val profile: Profile
)

@Serializable
data class Profile(
    val groups: Groups
)

@Serializable
data class Groups(
    val contactInfo: ContactInfo,
    val placeOfBirth: PlaceOfBirth,
    val currentResidence: CurrentResidence,
    val about: About,
    val smartCitizen: SmartCitizen
)

@Serializable
data class ContactInfo(
    val title: String,
    val items: Map<String, ContactItem>
)

@Serializable
data class PlaceOfBirth(
    val title: String,
    val items: Map<String, ContactItem>
)

@Serializable
data class CurrentResidence(
    val title: String,
    val items: Map<String, ContactItem>
)

@Serializable
data class About(
    val title: String,
    val placeholder: String
)

@Serializable
data class SmartCitizen(
    val title: String,
    val options: List<String>
)

@Serializable
data class ContactItem(
    val title: String,
    val placeholder: String,
    val type: String? = null
)



object SettingsManager {
    val shared: AppConfig? = fetchSettings()


    private fun fetchSettings(): AppConfig? {
        return loadAndParseJsonFile()
    }

    private fun parseJsonFile(jsonString: String): AppConfig? {
        try {
            return Json.decodeFromString<AppConfig>(jsonString)
        } catch (e: Exception) {
            println(e.message)
            return null
        }
    }

    private fun loadAndParseJsonFile(): AppConfig? {
        val reader = fileReaderProvider?.getFileReader()
        return try {
            val json: String = reader?.loadJsonFile("AppConfig.json") ?: throw Exception("Can't find the json file.")
            parseJsonFile(json)
        } catch (e: Exception) {
            print(e.message)
            null
        }
    }
}