package uz.ttpu.specialclasses.task09

enum class Severity { MINOR, MAJOR, CRITICAL, BLOCKER }

sealed class Incident(val severity: Severity) {
    class FileProblem(val fileName: String) : Incident(Severity.MAJOR)
    class DatabaseDown(val database: String) : Incident(Severity.CRITICAL)
    class SlowPage(val url: String) : Incident(Severity.MINOR)
    object Crash : Incident(Severity.CRITICAL)
    object OutOfMemory : Incident(Severity.BLOCKER)
}

fun describe(incident: Incident): String = when (incident) {
    is Incident.FileProblem -> "File ${incident.fileName} cannot be read"
    is Incident.DatabaseDown -> "Database ${incident.database} is down"
    is Incident.SlowPage -> "Page ${incident.url} is slow"
    Incident.Crash -> "The application crashed"
    Incident.OutOfMemory -> "Out of memory error"
}

fun main() {
    val log = mutableListOf<Incident>()
    println("Report: file NAME, db NAME, slow URL, crash, oom, or end")
    while (true) {
        print("> ")
        val parts = readln().trim().split(" ", limit = 2)
        val argument = parts.getOrElse(1) { "" }
        when (parts[0].lowercase()) {
            "file" -> log.add(Incident.FileProblem(argument))
            "db" -> log.add(Incident.DatabaseDown(argument))
            "slow" -> log.add(Incident.SlowPage(argument))
            "crash" -> log.add(Incident.Crash)
            "oom" -> log.add(Incident.OutOfMemory)
            "end" -> break
            else -> println("Unknown report")
        }
    }
    for (incident in log.sortedByDescending { it.severity }) {
        if (incident.severity >= Severity.CRITICAL) {
            println("[ALERT] [${incident.severity}] ${describe(incident)}")
        } else {
            println("[${incident.severity}] ${describe(incident)}")
        }
    }
    val critical = log.count { it.severity >= Severity.CRITICAL }
    println("Critical incidents: $critical of ${log.size}")
}
