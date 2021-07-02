import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public final class Benchmark {
    public static void main(String... args) throws IOException {
        if (args.length != 1) {
            System.out.println("Usage: java Benchmark <filename>");
            System.exit(1);
        }

        final String data = Files.readString(Paths.get(args[0]));

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
        measure(data, "[\"'][^\"']{0,30}[?!\\.][\"']");
    }

    private static void measure(String data, String pattern) {
        long startTime = System.nanoTime();

        final Matcher matcher = Pattern.compile(pattern).matcher(data);
        int count = 0;
        while (matcher.find()) {
            ++count;
        }

        long elapsed = System.nanoTime() - startTime;

        System.out.println(elapsed / 1e6 + " - " + count);
    }
}
