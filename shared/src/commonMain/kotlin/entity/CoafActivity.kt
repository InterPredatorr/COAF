package entity

import utils.randomUUID

data class CoafActivity(
    var id: String = randomUUID(),
    var name: String,
    var startDate: String,
    var endDate: String
) {
    companion object {
        fun empty() = CoafActivity(
            name = "Student Council",
            startDate = "Jan 2015",
            endDate = "Feb 2018"
        )
    }
}
