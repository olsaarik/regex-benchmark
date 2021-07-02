import java.io.File
import java.io.InputStream
import kotlin.text.Regex
import kotlin.system.exitProcess
import kotlin.system.measureNanoTime

fun main(args: Array<String>) {
    if (args.count() != 1) {
        println("Usage: kotlin benchmark.jar <filename>");
        exitProcess(1);
    }

    val inputStream: InputStream = File(args[0]).inputStream()
    val data = inputStream.bufferedReader().use { it.readText() }

    match(data, "Twain");
    match(data, "(?i)Twain");
    match(data, "[a-z]shing");
    match(data, "Huck[a-zA-Z]+|Saw[a-zA-Z]+");
    match(data, "\\b\\w+nn\\b");
    match(data, "[a-q][^u-z]{13}x");
    match(data, "Tom|Sawyer|Huckleberry|Finn");
    match(data, "(?i)Tom|Sawyer|Huckleberry|Finn");
    match(data, ".{0,2}(Tom|Sawyer|Huckleberry|Finn)");
    match(data, ".{2,4}(Tom|Sawyer|Huckleberry|Finn)");
    match(data, "Tom.{10,25}river|river.{10,25}Tom");
    match(data, "[a-zA-Z]+ing");
    match(data, "\\s[a-zA-Z]{0,12}ing\\s");
    match(data, "([A-Za-z]awyer|[A-Za-z]inn)\\s");
    match(data, "[\"'][^\"']{0,30}[?!\\.][\\\"']");
    match(data, "\\u221E|\\u2713");
    match(data, "\\p{Sm}");
}

fun match(data: String, pattern: String) {
    val start = System.nanoTime()

    val regex = Regex(pattern)
    var results = regex.findAll(data)
    val count = results.count()

    val elapsed = System.nanoTime() - start
    
    println((elapsed / 1e6).toString() + " - " + count)
}
