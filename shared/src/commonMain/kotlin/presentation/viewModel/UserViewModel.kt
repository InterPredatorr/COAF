package presentation.viewModel

import data.user.UsersRepository
import domain.entity.User

class UserViewModel : BaseViewModel() {
    private val repository = UsersRepository()

    private val users: List<User>
        get() = repository.users

    private val currentUser: User? = null

    var onUsersUpdated: ((List<User>) -> Unit)? = null
        set(value) {
            field = value
            onUsersUpdated?.invoke(users)
        }

    var onUserUpdated: ((User?) -> Unit)? = null
        set(value) {
            field = value
            onUserUpdated?.invoke(currentUser)
        }

    @Throws(Throwable::class)
    suspend fun getUser(id: Int): User = repository.getUser(id)

    fun createUser(user: User): Boolean = repository.createUser(user)

    @Throws(Throwable::class)
    suspend fun updateUser(user: User): User = repository.updateUser(user)

    fun deleteUser(id: Int): Boolean = repository.deleteUser(id)
}
