package entity

import utils.randomUUID

data class CoafClub(
    var id: String = randomUUID(),
    var name: String,
    var position: CoafClubPosition
) {
    companion object {
        fun empty(): CoafClub {
            return CoafClub(
                name = listOf("English", "Debate").random(),
                position = CoafClubPosition.entries.toTypedArray().random()
            )
        }
    }
}
