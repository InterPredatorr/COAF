package extensions

import kotlinx.datetime.LocalDate
import kotlinx.datetime.format.MonthNames
import kotlinx.datetime.format.char

fun String.toDayMonthYearDate(): LocalDate {
    val customFormat = LocalDate.Format {
        dayOfMonth()
        char('-')
        monthNumber()
        char('-')
        year()
    }
    return LocalDate.Companion.parse(this, customFormat)
}

fun String.toMonthYearDate(): LocalDate {
    val customFormat = LocalDate.Format {
        monthName(MonthNames.ENGLISH_ABBREVIATED)
        char(' ')
        year()
    }
    return LocalDate.Companion.parse(this, customFormat)
}
