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
