package entity

data class Certificate(
    var providerName: String,
    var yearOfProvision: String,
    var name: String
) {
    companion object {
        fun empty() = Certificate(
            "Arteni's Middle School",
            "Aug 2019",
            "School Completion"
        )
    }
}
