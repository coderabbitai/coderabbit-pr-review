// Redeclared variable (error)
let value = 1;
let value = 2;

// Duplicate function parameters (error)
function duplicateParams(a, a) {
    console.log(a);
}

// Constant reassignment (error)
const constVar = 123;
constVar = 456;

// Invalid left-hand assignment (error)
function invalidAssignment() {
    42 = x;
}

// Reserved keyword as identifier (error)
let for = 'reserved keyword';

// Using 'await' outside async function (error)
await fetch('https://example.com');

// Duplicate key in object literal (error)
const obj = {
    key: 1,
    key: 2
};

// Illegal break statement (error)
break;

// Illegal return statement outside function (error)
return 42;
