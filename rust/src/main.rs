use std::time::Instant;

use regex::bytes::RegexBuilder;

fn measure(data: &str, pattern: &str) {
    let start = Instant::now();

    let regex = RegexBuilder::new(pattern).build().unwrap();
    let count = regex.find_iter(data.as_bytes()).count();

    let elapsed = Instant::now().duration_since(start);

    println!("{} - {}", elapsed.as_secs_f64() * 1e3, count);
}

fn main() -> Result<(), Box<dyn std::error::Error + Send + Sync>> {
    let path = match std::env::args_os().nth(1) {
        None => return Err(From::from("Usage: benchmark <filename>")),
        Some(path) => path,
    };
    let data = std::fs::read_to_string(path)?;

    measure(&data, "Twain");
    measure(&data, "(?i)Twain");
    measure(&data, "[a-z]shing");
    measure(&data, "Huck[a-zA-Z]+|Saw[a-zA-Z]+");
    measure(&data, "\\b\\w+nn\\b");
    measure(&data, "[a-q][^u-z]{13}x");
    measure(&data, "Tom|Sawyer|Huckleberry|Finn");
    measure(&data, "(?i)Tom|Sawyer|Huckleberry|Finn");
    measure(&data, ".{0,2}(Tom|Sawyer|Huckleberry|Finn)");
    measure(&data, ".{2,4}(Tom|Sawyer|Huckleberry|Finn)");
    measure(&data, "Tom.{10,25}river|river.{10,25}Tom");
    measure(&data, "[a-zA-Z]+ing");
    measure(&data, "\\s[a-zA-Z]{0,12}ing\\s");
    measure(&data, "([A-Za-z]awyer|[A-Za-z]inn)\\s");
    measure(&data, "[\"'][^\"']{0,30}[?!\\.][\"']");

    Ok(())
}
