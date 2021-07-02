package main

import (
    "bytes"
    "fmt"
    "log"
    "os"
    "regexp"
    "time"
)

func measure(data string, pattern string) {
    start := time.Now()

    r, err := regexp.Compile(pattern)
    if err != nil {
        log.Fatal(err)
    }

    matches := r.FindAllString(data, -1)
    count := len(matches)

    elapsed := time.Since(start)

    fmt.Printf("%f - %v\n", float64(elapsed) / float64(time.Millisecond), count)
}

func main() {
    if len(os.Args) != 2 {
        fmt.Println("Usage: benchmark <filename>")
        os.Exit(1)
    }

    filerc, err := os.Open(os.Args[1])
    if err != nil {
        log.Fatal(err)
    }
    defer filerc.Close()

    buf := new(bytes.Buffer)
    buf.ReadFrom(filerc)
    data := buf.String()

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
