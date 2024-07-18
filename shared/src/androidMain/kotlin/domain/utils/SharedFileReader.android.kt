package domain.utils

import FileReaderProvider
import android.content.Context
import okio.IOException
import okio.buffer
import okio.source
import java.nio.charset.Charset

class AndroidFileReaderProvider(private val context: Context) : FileReaderProvider {
    override fun getFileReader(): SharedFileReader {
        return SharedFileReader(context)
    }
}

actual class SharedFileReader actual constructor() {

    private lateinit var context: Context

    constructor(context: Context) : this() {
        this.context = context
    }

    actual fun loadJsonFile(fileName: String): String? {
        try {

            val source = context.resources.assets.open(fileName).source().buffer()
            return source.readByteString().string(Charset.forName("utf-8"))
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return null
    }
}