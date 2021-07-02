#include <chrono>
#include <fstream>
#include <iostream>
#include <regex>
#include <boost/regex.hpp>

void measure(const std::string& data, const std::string& pattern) {
  using clock = std::chrono::high_resolution_clock;
  const auto start = clock::now();

  const REGEX_NAMESPACE::regex re{pattern};
  unsigned count = 0;

  for (REGEX_NAMESPACE::sregex_token_iterator it{data.cbegin(), data.cend(), re}, end{}; it != end; ++it)
    count++;

  const auto end = clock::now();
  const double elapsed = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count() * 1e-6;
  std::cout << elapsed << " - " << count << "\n";
}

int main(int argc, char** argv) {
  if (argc != 2) {
    std::cerr << "Usage: benchmark <filename>\n";
    return 1;
  }

  std::ifstream file{argv[1]};
  if (!file) {
    std::cerr << "unable to open " << argv[1] << "\n";
    return 1;
  }

  const std::string data{std::istreambuf_iterator<char>{file}, std::istreambuf_iterator<char>{}};

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

  return 0;
}
