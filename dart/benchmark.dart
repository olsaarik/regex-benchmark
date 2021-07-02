import 'dart:io';

main(List<String> arguments) {
  if (arguments.length != 1) {
    print('Usage: dart bencharmark.dart <filename>');
    exit(1);
  }

  new File(arguments[0])
    .readAsString()
    .then((String data) {
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
    });
}

measure(data, pattern){
  var stopwatch = new Stopwatch()..start();

  RegExp exp = new RegExp(pattern);
  Iterable<Match> matches = exp.allMatches(data);
  var count = matches.length;

  stopwatch.stop();

  print('${stopwatch.elapsedMicroseconds / 1e3} ${count}');
}
