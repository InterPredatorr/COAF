package extensions

import kotlinx.datetime.Clock
import kotlinx.datetime.LocalDate
import kotlinx.datetime.TimeZone
import kotlinx.datetime.format
import kotlinx.datetime.format.FormatStringsInDatetimeFormats
import kotlinx.datetime.format.MonthNames
import kotlinx.datetime.format.byUnicodePattern
import kotlinx.datetime.toLocalDateTime

@OptIn(FormatStringsInDatetimeFormats::class)
fun LocalDate.dayMonthYear(): String {
    return this.format(LocalDate.Format {
        byUnicodePattern("dd-MM-uuuu")
    })
}

@OptIn(FormatStringsInDatetimeFormats::class)
fun LocalDate.monthNameYear(): String {
    return this.format(LocalDate.Format {
        monthName(MonthNames.ENGLISH_ABBREVIATED)
        chars(" ")
        year()
    })
}

fun LocalDate.Companion.now(): LocalDate {
    val now = Clock.System.now()
    val tz = TimeZone.currentSystemDefault()
    val nowDate = now.toLocalDateTime(tz).date
    return nowDate
}
