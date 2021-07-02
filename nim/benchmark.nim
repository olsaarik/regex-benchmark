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

measure(data, "Twain" & fake);
measure(data, "(?i)Twain" & fake);
measure(data, "[a-z]shing" & fake);
measure(data, "Huck[a-zA-Z]+|Saw[a-zA-Z]+" & fake);
measure(data, "\\b\\w+nn\\b" & fake);
measure(data, "[a-q][^u-z]{13}x" & fake);
measure(data, "Tom|Sawyer|Huckleberry|Finn" & fake);
measure(data, "(?i)Tom|Sawyer|Huckleberry|Finn" & fake);
measure(data, ".{0,2}(Tom|Sawyer|Huckleberry|Finn)" & fake);
measure(data, ".{2,4}(Tom|Sawyer|Huckleberry|Finn)" & fake);
measure(data, "Tom.{10,25}river|river.{10,25}Tom" & fake);
measure(data, "[a-zA-Z]+ing" & fake);
measure(data, "\\s[a-zA-Z]{0,12}ing\\s" & fake);
measure(data, "([A-Za-z]awyer|[A-Za-z]inn)\\s" & fake);
measure(data, "[\"'][^\"']{0,30}[?!\\.][\"']" & fake);