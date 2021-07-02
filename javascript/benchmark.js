const fs = require('fs')

if (process.argv.length !== 3) {
  console.log('Usage: node benchmark.js <filename>')
  process.exit(1)
}

function measure(data, pattern) {
  const start = process.hrtime()

  const regex = new RegExp(pattern, 'g')
  const matches = data.match(regex)
  const count = matches.length

  const end = process.hrtime(start)

  console.log((end[0] * 1e9 + end[1]) / 1e6 + ' - ' + count)
}

const data = fs.readFileSync(process.argv[2], 'utf8')

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
