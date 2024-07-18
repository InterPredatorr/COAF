package myProfile.tabs

enum class MyProfileTab {
    ABOUTME,
    COAFPASSPORT,
    RESOURCES;

    val title: String
        get() =
            when (this) {
                ABOUTME -> "ABOUT ME"
                COAFPASSPORT -> "COAF PASSPORT"
                RESOURCES -> this.name
            }
}