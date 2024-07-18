package domain.utils



expect class SharedFileReader() {

    fun loadJsonFile(fileName: String): String?
}