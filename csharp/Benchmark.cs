using System;
using System.IO;
using System.Text.RegularExpressions;
using System.Diagnostics;

class Benchmark
{
    static void Main(string[] args)
    {
        if (args.Length != 1)
        {
            Console.WriteLine("Usage: benchmark <filename>");
            Environment.Exit(1);
        }

        StreamReader reader = new System.IO.StreamReader(args[0]);
        string data = reader.ReadToEnd();

        Benchmark.Measure(data, @"Twain");
        Benchmark.Measure(data, @"(?i)Twain");
        Benchmark.Measure(data, @"[a-z]shing");
        Benchmark.Measure(data, @"Huck[a-zA-Z]+|Saw[a-zA-Z]+");
        Benchmark.Measure(data, @"\b\w+nn\b");
        Benchmark.Measure(data, @"[a-q][^u-z]{13}x");
        Benchmark.Measure(data, @"Tom|Sawyer|Huckleberry|Finn");
        Benchmark.Measure(data, @"(?i)Tom|Sawyer|Huckleberry|Finn");
        Benchmark.Measure(data, @".{0,2}(Tom|Sawyer|Huckleberry|Finn)");
        Benchmark.Measure(data, @".{2,4}(Tom|Sawyer|Huckleberry|Finn)");
        Benchmark.Measure(data, @"Tom.{10,25}river|river.{10,25}Tom");
        Benchmark.Measure(data, @"[a-zA-Z]+ing");
        Benchmark.Measure(data, @"\s[a-zA-Z]{0,12}ing\s");
        Benchmark.Measure(data, @"([A-Za-z]awyer|[A-Za-z]inn)\s");
        Benchmark.Measure(data, @"[""'][^""']{0,30}[?!\.][""']");
    }

    static void Measure(string data, string pattern)
    {
        Stopwatch stopwatch = Stopwatch.StartNew();

        MatchCollection matches = Regex.Matches(data, pattern);
        int count = matches.Count;

        stopwatch.Stop();

        Console.WriteLine(stopwatch.Elapsed.TotalMilliseconds.ToString("G", System.Globalization.CultureInfo.InvariantCulture) + " - " + count);
    }
}
