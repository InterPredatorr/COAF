package entity

import utils.randomUUID

data class User(
    var id: String = randomUUID(),
    var imageUrl: String,
    var name: String,
    var surname: String,
    var fatherName: String,
    var birthday: String,
    var gender: Gender,
    var email: String,
    var mobilePhone: String,
    var placeOfBirth: Address,
    var currentResidence: Address,
    var about: String,
    var isSmartCitizen: Boolean,
    var educations: List<Education>,
    var workExperiences: List<WorkExperience>,
    var activities: List<CoafActivity>,
    var certificates: List<Certificate>,
    var skills: List<String>,
    var programs: List<CoafPassportProgram>,
    var clubs: List<CoafClub>
) {
    val fullname: String
        get() = "$name $surname"

    constructor() : this(
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
        workExperiences = listOf(WorkExperience.empty()),
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
