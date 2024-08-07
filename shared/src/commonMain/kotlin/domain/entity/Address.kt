package domain.entity

import kotlinx.serialization.Serializable

@Serializable
data class Address(
    var country: String,
    var region: String,
    var city: String
) {
    val description: String
        get() = listOf(city, region, country).joinToString(", ")

    fun isEmpty(): Boolean = country.isEmpty() && region.isEmpty() && city.isEmpty()

    companion object {

        val empty = Address("", "", "")
    }
}
