package domain.entity

import extensions.dayMonthYear
import extensions.monthNameYear
import extensions.now
import kotlinx.datetime.LocalDate
import kotlinx.serialization.Serializable
import utils.randomUUID

@Serializable
enum class EmploymentType {
    FULLTIME,
    PARTTIME,
    SELFEMPLOYED,
    CONTRACT,
    FREELANCE,
    INTERNSHIP,
    APPRENTICESHIP,
    SEASONAL;

    val value: String
        get() {
            return when (this) {
                FULLTIME -> "Full-time"
                PARTTIME -> "Part-time"
                SELFEMPLOYED -> "Self-employed"
                CONTRACT -> "Contract"
                FREELANCE -> "Freelance"
                INTERNSHIP -> "Internship"
                APPRENTICESHIP -> "Apprenticeship"
                SEASONAL -> "Seasonal"
            }
        }
}

@Serializable
data class WorkExperience(
    var id: String = randomUUID(),
    var employee: String,
    var position: String,
    var employmentType: EmploymentType,
    var startDate: String,
    var endDate: String
) {
    companion object {
        fun empty() = WorkExperience(
            employee = "PicsArt",
            position = "Software Engineer",
            employmentType = EmploymentType.FULLTIME,
            startDate = "Apr 2022",
            endDate = LocalDate.now().monthNameYear()
        )
    }
}
