package app.coaf.org.repository

import app.coaf.org.db.UsersTable
import app.coaf.org.db.suspendTransaction
import entity.Education
import entity.Gender
import entity.User
import entity.parseAddress
import entity.parseItem
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import org.jetbrains.exposed.sql.ResultRow
import org.jetbrains.exposed.sql.SqlExpressionBuilder.eq
import org.jetbrains.exposed.sql.deleteWhere
import org.jetbrains.exposed.sql.insert
import org.jetbrains.exposed.sql.lowerCase
import org.jetbrains.exposed.sql.selectAll
import org.jetbrains.exposed.sql.update

class PostgresUserRepository: UserRepository {

    private fun resultRowToUser(row: ResultRow): User {
        return User(
            id = row[UsersTable.id].toString(),
            imageUrl = row[UsersTable.imageUrl],
            name = row[UsersTable.name],
            surname = row[UsersTable.surname],
            fatherName = row[UsersTable.fatherName],
            birthday = row[UsersTable.birthday],
            gender = row[UsersTable.gender]?.let { Gender.valueOf(it) },
            email = row[UsersTable.email],
            mobilePhone = row[UsersTable.mobilePhone],
            placeOfBirth = row[UsersTable.placeOfBirth]?.let { parseAddress(it) },
            currentResidence = row[UsersTable.currentResidence]?.let { parseAddress(it) },
            about = row[UsersTable.about],
            isSmartCitizen = row[UsersTable.isSmartCitizen],
            educations = row[UsersTable.educations]?.let { parseItem<Education>(it) },
            workExperiences = row[UsersTable.workExperiences]?.let { parseItem(it) },
            activities = row[UsersTable.activities]?.let { parseItem(it) },
            certificates = row[UsersTable.certificates]?.let { parseItem(it) },
            skills = row[UsersTable.skills]?.split(","),
            programs = row[UsersTable.programs]?.let { parseItem(it) },
            clubs = row[UsersTable.clubs]?.let { parseItem(it) }
        )
    }

    override suspend fun addUser(user: User): User? = suspendTransaction {
        val insertStmt = UsersTable.insert { userTable ->
            userTable[imageUrl] = user.imageUrl
            userTable[name] = user.name
            userTable[surname] = user.surname
            userTable[fatherName] = user.fatherName
            userTable[birthday] = user.birthday
            userTable[gender] = user.gender?.name
            userTable[email] = user.email
            userTable[mobilePhone] = user.mobilePhone
            userTable[about] = user.about
            userTable[isSmartCitizen] = user.isSmartCitizen
            userTable[placeOfBirth] = user.placeOfBirth?.description
            userTable[currentResidence] = user.currentResidence?.description
            userTable[educations] = user.educations?.let { Json.encodeToString(it) }
            userTable[workExperiences] = user.workExperiences?.let { Json.encodeToString(it) }
            userTable[activities] = user.activities?.let { Json.encodeToString(it) }
            userTable[certificates] = user.certificates?.let { Json.encodeToString(it) }
            userTable[skills] = user.skills?.joinToString(",")
            userTable[programs] = user.programs?.let { Json.encodeToString(it) }
            userTable[clubs] = user.clubs?.let { Json.encodeToString(it) }
        }
        insertStmt.resultedValues?.singleOrNull()?.let { resultRowToUser(it) }
    }

    override suspend fun updateUser(user: User): Boolean = suspendTransaction {
        UsersTable.update( { UsersTable.email eq user.email } ) { userTable ->
            userTable[imageUrl] = user.imageUrl
            userTable[name] = user.name
            userTable[surname] = user.surname
            userTable[fatherName] = user.fatherName
            userTable[birthday] = user.birthday
            userTable[gender] = user.gender?.name
            userTable[email] = user.email
            userTable[mobilePhone] = user.mobilePhone
            userTable[about] = user.about
            userTable[isSmartCitizen] = user.isSmartCitizen
            userTable[placeOfBirth] = user.placeOfBirth?.description
            userTable[currentResidence] = user.currentResidence?.description
            userTable[educations] = user.educations?.let { Json.encodeToString(it) }
            userTable[workExperiences] = user.workExperiences?.let { Json.encodeToString(it) }
            userTable[activities] = user.activities?.let { Json.encodeToString(it) }
            userTable[certificates] = user.certificates?.let { Json.encodeToString(it) }
            userTable[skills] = user.skills?.joinToString(",")
            userTable[programs] = user.programs?.let { Json.encodeToString(it) }
            userTable[clubs] = user.clubs?.let { Json.encodeToString(it) }
        } > 0
    }

    override suspend fun deleteUser(email: String): Boolean = suspendTransaction {
        UsersTable.deleteWhere { UsersTable.email eq email } > 0
    }

    override suspend fun getUsers(): List<User> = suspendTransaction {
        UsersTable.selectAll().map { resultRowToUser(it) }
    }

    override suspend fun searchUser(query: String): List<User> = suspendTransaction {
        UsersTable.selectAll().where { (UsersTable.name.lowerCase() like "%${query.lowercase()}%") }
            .map { resultRowToUser(it) }
    }

    override suspend fun getUser(email: String): User? = suspendTransaction {
        UsersTable.selectAll().where { (UsersTable.email eq email) }.map { resultRowToUser(it) }.singleOrNull()
    }
}