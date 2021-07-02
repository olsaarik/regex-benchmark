import sys
import re
from timeit import default_timer as timer

if len(sys.argv) != 2:
    print('Usage: python benchmark.py <filename>')
    sys.exit(1)

def measure(data, pattern):
    start_time = timer()

    regex = re.compile(pattern)
    matches = re.findall(regex, data)

    elapsed_time = timer() - start_time

    print(str(elapsed_time * 1e3) + ' - ' + str(len(matches)))

with open(sys.argv[1]) as file:
    data = file.read()

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