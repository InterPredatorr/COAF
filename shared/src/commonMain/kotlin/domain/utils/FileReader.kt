import domain.utils.SharedFileReader


interface FileReaderProvider {
    fun getFileReader(): SharedFileReader
}

var fileReaderProvider: FileReaderProvider? = null