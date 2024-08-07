package domain.entity

import kotlinx.serialization.Serializable

@Serializable
enum class CoafClubPosition {
    ATTENDEE,
    ORGANIZER;

    override fun toString(): String {
        return this.name.lowercase()
            .replaceFirstChar { if (it.isLowerCase()) it.titlecase() else it.toString() }
    }
}
