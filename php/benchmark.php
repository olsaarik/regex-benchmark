<?php

if (count($argv) !== 2) {
    echo 'Usage: php benchmark.php <filename>';
    die(1);
}

$data  = file_get_contents($argv[1]);

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
measure(data, "\\u221E|\\u2713");
measure(data, "\\p{Sm}");

function measure($data, $pattern) {
    $startTime = microtime(true);

    $count = preg_match_all($pattern, $data, $matches);

    $elapsed = (microtime(true) - $startTime) * 1e3;

    echo $elapsed . ' - ' . $count . PHP_EOL;
}
