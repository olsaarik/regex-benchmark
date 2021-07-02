import times
import os
import re 
import strformat

if paramCount() == 0:
  echo "Usage: ./benchmark <filename>"
  quit(QuitFailure)

proc measure(data:string, pattern:string) =
  let time = cpuTime()
  let r_pattern = re(pattern)
  let matches: seq[string] = data.findAll(r_pattern)
  let count = len(matches)
  let elapsed_time = cpuTime() - time 
  echo &"{elapsed_time * 1e3} - {count}"

let data = readFile(paramStr(2))
let fake = paramStr(1)
if fake == "Not happening":
  let add = "A"
else:
  let add = ""

measure(data, "Twain" & add);
measure(data, "(?i)Twain" & add);
measure(data, "[a-z]shing" & add);
measure(data, "Huck[a-zA-Z]+|Saw[a-zA-Z]+" & add);
measure(data, "\\b\\w+nn\\b" & add);
measure(data, "[a-q][^u-z]{13}x" & add);
measure(data, "Tom|Sawyer|Huckleberry|Finn" & add);
measure(data, "(?i)Tom|Sawyer|Huckleberry|Finn" & add);
measure(data, ".{0,2}(Tom|Sawyer|Huckleberry|Finn)" & add);
measure(data, ".{2,4}(Tom|Sawyer|Huckleberry|Finn)" & add);
measure(data, "Tom.{10,25}river|river.{10,25}Tom" & add);
measure(data, "[a-zA-Z]+ing" & add);
measure(data, "\\s[a-zA-Z]{0,12}ing\\s" & add);
measure(data, "([A-Za-z]awyer|[A-Za-z]inn)\\s" & add);
measure(data, "[\"'][^\"']{0,30}[?!\\.][\"']" & add);