import std.stdio;
import std.file;
import std.regex;
import std.datetime;
import std.datetime.stopwatch : StopWatch, AutoStart;
import core.stdc.stdlib;

void measure(string data, string pattern) {
    int count = 0;

    auto sw = StopWatch(AutoStart.yes);

    foreach (m; data.matchAll(regex(pattern))) {
        count++;
    }

    sw.stop();
    double end = sw.peek().total!"nsecs" / 1e6;

    printf("%f - %d\n", end, count);
}

void main(string [] args) {
    if(args.length != 2) {
        writeln("Usage: benchmark <filename>");
        exit(1);
    }

    string data = readText(args[1]);

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
