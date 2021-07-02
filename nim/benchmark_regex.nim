import times
import os
import strformat

import pkg/regex

if paramCount() == 0:
  echo "Usage: ./benchmark <filename>"
  quit(QuitFailure)

proc measure(data: string, pattern: string) =
  let time = cpuTime()
  let r_pattern = re(pattern)
  let matches = data.findAll(r_pattern)
  let count = len(matches)
  let elapsed_time = cpuTime() - time 
  echo &"{elapsed_time * 1e3} - {count}"

let data = readFile(paramStr(1))

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
