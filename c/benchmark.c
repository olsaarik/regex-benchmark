#include <stdio.h>
#include <string.h>
#include <sys/time.h>

#if __has_include(<time.h>)
#include <time.h>
#endif

#define PCRE2_CODE_UNIT_WIDTH 8
#include <pcre2.h>

char *read_file(char *filename)
{
  char *data;
  long length = 0;

  FILE *fh = fopen(filename, "rb");

  fseek(fh, 0, SEEK_END);
  length = ftell(fh);
  fseek(fh, 0, SEEK_SET);

  data = malloc(length);

  size_t result = fread(data, length, 1, fh);
  if (result != 1)
  {
	fputs("err", stderr);
	exit(1);
  }
  fclose(fh);

  return data;
}

void measure(char *data, char *pattern)
{
  int count = 0;
  double elapsed;
  struct timespec start, end;
  pcre2_code *re;
  int errorcode;
  PCRE2_SIZE erroroffset;
  pcre2_match_data *match_data;
  int length;
  PCRE2_SIZE offset = 0;
  PCRE2_SIZE *ovector;

  clock_gettime(CLOCK_MONOTONIC, &start);

  re = pcre2_compile((PCRE2_SPTR) pattern, PCRE2_ZERO_TERMINATED, 0, &errorcode, &erroroffset, NULL);
  match_data = pcre2_match_data_create_from_pattern(re, NULL);
  length = strlen(data);

  while (pcre2_match(re, (PCRE2_SPTR8) data, length, offset, 0, match_data, NULL) == 1)
  {
    count++;

    ovector = pcre2_get_ovector_pointer(match_data);
    offset = ovector[1];
  }

  clock_gettime(CLOCK_MONOTONIC, &end);
  elapsed = ((end.tv_sec - start.tv_sec) * 1e9 + end.tv_nsec - start.tv_nsec) / 1e6;

  printf("%f - %d\n", elapsed, count);

  pcre2_match_data_free(match_data);
  pcre2_code_free(re);
}

int main(int argc, char **argv)
{
  if (argc != 2)
  {
    printf("Usage: benchmark  <filename>");
    exit(1);
  }

  char *data = read_file(argv[1]);

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

  free(data);

  return 0;
}
