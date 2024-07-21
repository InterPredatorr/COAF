package entity

import extensions.dayMonthYear
import extensions.now
import kotlinx.datetime.LocalDate
import utils.randomUUID

data class CoafPassportProgram(
    var id: String = randomUUID(),
    var name: String,
    var issueDate: String
) {
    companion object {
        fun empty(): CoafPassportProgram {
            return CoafPassportProgram(
                name = "Mentorship",
                issueDate = LocalDate.now().dayMonthYear()
            )
        }
    }
}
