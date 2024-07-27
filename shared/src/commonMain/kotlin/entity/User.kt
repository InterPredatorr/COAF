package entity

import kotlinx.serialization.Serializable
import utils.randomUUID

@Serializable
data class User(
    var id: String,
    var imageUrl: String? = null,
    var name: String? = null,
    var surname: String? = null,
    var fatherName: String? = null,
    var birthday: String? = null,
    var gender: Gender? = null,
    var email: String? = null,
    var mobilePhone: String? = null,
    var placeOfBirth: Address? = null,
    var currentResidence: Address? = null,
    var about: String? = null,
    var isSmartCitizen: Boolean? = null,
    var educations: List<Education>? = null,
    var workExperiences: List<WorkExperience>? = null,
    var activities: List<CoafActivity>? = null,
    var certificates: List<Certificate>? = null,
    var skills: List<String>? = null,
    var programs: List<CoafPassportProgram>? = null,
    var clubs: List<CoafClub>? = null
) {
    val fullname: String
        get() = "$name $surname"

    constructor() : this(
        id = randomUUID(),
        imageUrl = User.imageUrl,
        name = "Sevak",
        surname = "Tadevosyan",
        fatherName = "Samvel",
        birthday = "13-04-2001",
        gender = Gender.MALE,
        email = "sevak.tadevosyan.dev@gmail.com",
        mobilePhone = "+37494610421",
        placeOfBirth = Address.empty,
        currentResidence = Address.empty,
        about = "I'm Sevak, from Arteni, I'm studying in Yerevan State University, at the faculty of Informatics and Applied Mathematics. In parallel, I'm working at PicsArt as a Software Engineer.",
        isSmartCitizen = true,
        educations = listOf(Education.empty(), Education.empty()),
        workExperiences = listOf(WorkExperience.empty(), WorkExperience.empty()),
        activities = listOf(CoafActivity.empty()),
        certificates = listOf(Certificate.empty()),
        skills = emptyList(),
        programs = listOf(CoafPassportProgram.empty(), CoafPassportProgram.empty()),
        clubs = listOf(CoafClub.empty(), CoafClub.empty())
    )

    companion object {
        private const val imageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpd4mJRIUwqgE8D_Z2znANEbtiz4GhI4M8NQ&s"

        fun users() = listOf(
            User(), User()
        )
    }
}
