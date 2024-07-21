package entity

data class CoafCertificate(
    val providerName: String,
    val yearOfProvision: Int,
    val name: String
) {
    companion object {
        val empty = Certificate(
            "Arteni's Middle School",
            2019,
            "School Completion"
        )
    }
}
