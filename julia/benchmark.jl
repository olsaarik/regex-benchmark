function measure(data, pattern)
    start = time()
    count = length(collect(eachmatch(pattern, data)))
    elapsed = time() - start
    elapsed_ms = 1000 * elapsed

    println(string(elapsed_ms) * " - " * string(count))
end

if length(ARGS) < 1
    println("Usage: julia benchmark.jl <filename>")
    exit(1)
end

data = open(f->read(f, String), ARGS[1])

measure(data, r"Twain");
measure(data, r"(?i)Twain");
measure(data, r"[a-z]shing");
measure(data, r"Huck[a-zA-Z]+|Saw[a-zA-Z]+");
measure(data, r"\b\w+nn\b");
measure(data, r"[a-q][^u-z]{13}x");
measure(data, r"Tom|Sawyer|Huckleberry|Finn");
measure(data, r"(?i)Tom|Sawyer|Huckleberry|Finn");
measure(data, r".{0,2}(Tom|Sawyer|Huckleberry|Finn)");
measure(data, r".{2,4}(Tom|Sawyer|Huckleberry|Finn)");
measure(data, r"Tom.{10,25}river|river.{10,25}Tom");
measure(data, r"[a-zA-Z]+ing");
measure(data, r"\s[a-zA-Z]{0,12}ing\s");
measure(data, r"([A-Za-z]awyer|[A-Za-z]inn)\s");
measure(data, r"[\"'][^\"']{0,30}[?!\\.][\"']");
