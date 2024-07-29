package app.coaf.org.db

import entity.Gender
import entity.User
import entity.parseAddress
import entity.parseItem
import kotlinx.coroutines.Dispatchers
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.Transaction
import org.jetbrains.exposed.sql.transactions.experimental.newSuspendedTransaction

object UsersTable : IntIdTable("users") {
    val name = varchar("name", 50)
    val surname = varchar("surname", 50)
    val email = varchar("email", 255)
    val imageUrl = varchar("image_url", 255).nullable()
    val fatherName = varchar("father_name", 50).nullable()
    val birthday = varchar("birthday", 10).nullable()
    val gender = varchar("gender", 10).nullable()
    val mobilePhone = varchar("mobile_phone", 20).nullable()
    val about = varchar("about", 1000).nullable()
    val isSmartCitizen = bool("is_smart_citizen").nullable()
    val placeOfBirth = varchar("place_of_birth", 255).nullable()
    val currentResidence = varchar("current_residence", 255).nullable()
    val educations = text("educations").nullable()
    val workExperiences = text("work_experiences").nullable()
    val activities = text("activities").nullable()
    val certificates = text("certificates").nullable()
    val skills = text("skills").nullable()
    val programs = text("programs").nullable()
    val clubs = text("clubs").nullable()
}

class UserDAO(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<UserDAO>(UsersTable)

    var imageUrl by UsersTable.imageUrl
    var name by UsersTable.name
    var surname by UsersTable.surname
    var fatherName by UsersTable.fatherName
    var birthday by UsersTable.birthday
    var gender by UsersTable.gender
    var email by UsersTable.email
    var mobilePhone by UsersTable.mobilePhone
    var placeOfBirth by UsersTable.placeOfBirth
    var currentResidence by UsersTable.currentResidence
    var about by UsersTable.about
    var isSmartCitizen by UsersTable.isSmartCitizen
    var educations by UsersTable.educations
    var workExperiences by UsersTable.workExperiences
    var activities by UsersTable.activities
    var certificates by UsersTable.certificates
    var skills by UsersTable.skills
    var programs by UsersTable.programs
    var clubs by UsersTable.clubs
}

suspend fun <T> suspendTransaction(block: Transaction.() -> T): T =
    newSuspendedTransaction(Dispatchers.IO, statement = block)

fun daoToModel(dao: UserDAO) = User(
    id = dao.id.value.toString(),
    imageUrl = dao.imageUrl,
    name = dao.name,
    surname = dao.surname,
    fatherName = dao.fatherName,
    birthday = dao.birthday,
    gender = dao.gender?.let { Gender.valueOf(it) },
    email = dao.email,
    mobilePhone = dao.mobilePhone,
    placeOfBirth = dao.placeOfBirth?.let { parseAddress(it) },
    currentResidence = dao.currentResidence?.let { parseAddress(it) },
    about = dao.about,
    isSmartCitizen = dao.isSmartCitizen,
    educations = dao.educations?.let { parseItem(it) },
    workExperiences = dao.workExperiences?.let { parseItem(it) },
    activities = dao.activities?.let { parseItem(it) },
    certificates = dao.certificates?.let { parseItem(it) },
    skills = dao.skills?.split(","),
    programs = dao.programs?.let { parseItem(it) },
    clubs = dao.clubs?.let { parseItem(it) }
)