// unused variable
const unusedVar = 42

// equality without type checking
if (unusedVar == "42") {
  console.log("Bad equality!")
}

// explicit any usage (TypeScript)
function doSomethingBad(param) {
  console.log(param)
}

// using debugger statement
debugger;

// deeply nested and complex function
function complexFunction(a, b, c, d, e) {
  if (a) {
    if (b) {
      if (c) {
        if (d) {
          if (e) {
            console.log("Nested madness!");
          }
        }
      }
    }
  }
}

// console logging directly (not allowed)
console.log("Direct logging")

// function declared but never used
function unusedFunction() {
  return "Never called!"
}

// badly named variables
let X = "badly named"
