package entity

import kotlinx.serialization.Serializable
import utils.randomUUID

@Serializable
data class Education(
    var id: String = randomUUID(),
    var universityName: String,
    var faculty: String,
    var department: String,
    var startDate: String,
    var endDate: String
) {
    companion object {
        fun empty() =
            Education(
                universityName = "Yerevan State University",
                faculty = "Informatics And Applied Mathematics",
                department = "Information Security",
                startDate = "Apr 2021",
                endDate = "Mar 2025"
            )
    }
}