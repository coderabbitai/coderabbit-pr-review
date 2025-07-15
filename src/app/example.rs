fn main() {
    // Unnecessary clone
    let x = String::from("hello");
    let y = x.clone(); // Clippy will warn here about the unnecessary clone
    println!("{}", y);

    // Unused variable
    let unused_var = 42; // Clippy will warn about this

    // Possible panic on unwrap
    let result: Result<i32, &str> = Err("error");


    // // NEED TO TEST FURTHER, MIGHT CAUSE "cause a runtime panic"
    // // https://github.com/coderabbitai/pr-reviewer_test/pull/10606#discussion_r2087234807
    // let value = result.unwrap(); // This would trigger clippy::unwrap_used

    // Instead, use pattern matching or the ? operator
    let value = match result {
        Ok(v) => v,
        Err(e) => {
            eprintln!("Error: {}", e);
            -1 // Providing a default value for the example
        }
    };

    // Redundant reference
    let z = &y; // Clippy might suggest removing the reference here
    println!("{}", z);

    // Inefficient `for` loop
    let vec = vec![1, 2, 3, 4];
    for i in vec.iter() {  // Clippy may suggest using a `for` loop by value
        println!("{}", i);
    }

    // Excessive type annotation
    let a: i32 = 5; // Clippy will suggest removing the type annotation since it's obvious

    // Missing documentation
    let un_documented_function = |x: i32| x * 2; // Clippy may warn about missing documentation
}
