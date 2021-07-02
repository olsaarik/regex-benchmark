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

    measure(data, "Twain");
    measure(data, "(?i)Twain");
    measure(data, "[a-z]shing");
    measure(data, "Huck[a-zA-Z]+|Saw[a-zA-Z]+");
    measure(data, "\\b\\w+nn\\b");
    measure(data, "[a-q][^u-z]{13}x");
    measure(data, "Tom|Sawyer|Huckleberry|Finn");
    measure(data, "(?i)Tom|Sawyer|Huckleberry|Finn");
    measure(data, ".{0,2}(Tom|Sawyer|Huckleberry|Finn)");
    measure(data, ".{2,4}(Tom|Sawyer|Huckleberry|Finn)");
    measure(data, "Tom.{10,25}river|river.{10,25}Tom");
    measure(data, "[a-zA-Z]+ing");
    measure(data, "\\s[a-zA-Z]{0,12}ing\\s");
    measure(data, "([A-Za-z]awyer|[A-Za-z]inn)\\s");
    measure(data, "[\"'][^\"']{0,30}[?!\\.][\\\"']");
    measure(data, "\\u221E|\\u2713");
    measure(data, "\\p{Sm}");
}

fun match(data: String, pattern: String) {
    val start = System.nanoTime()

    val regex = Regex(pattern)
    var results = regex.findAll(data)
    val count = results.count()

    val elapsed = System.nanoTime() - start
    
    println((elapsed / 1e6).toString() + " - " + count)
}
