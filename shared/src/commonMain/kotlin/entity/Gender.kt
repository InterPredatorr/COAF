package entity

enum class Gender {
    MALE,
    FEMALE,
    OTHER;

    override fun toString(): String {
        return this.name.lowercase()
            .replaceFirstChar { if (it.isLowerCase()) it.titlecase() else it.toString() }
    }
}
