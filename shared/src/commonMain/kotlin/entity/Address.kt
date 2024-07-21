package entity

data class Address(
    var country: String,
    var region: String,
    var city: String
) {
    val description: String
        get() = listOf(city, region, country).joinToString(", ")

    companion object {
        val empty = Address("Armenia", "Aragatsotn", "Arteni")
    }
}
