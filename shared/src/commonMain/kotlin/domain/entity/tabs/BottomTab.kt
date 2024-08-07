package domain.entity.tabs

enum class BottomTab {
    HOME,
    PEOPLE,
    FILES,
    MYPROFILE;

    val title: String
        get() {
            return when(this) {
                HOME -> "Home"
                PEOPLE -> "People"
                FILES -> "Files"
                MYPROFILE -> "My Profile"
            }
        }
}