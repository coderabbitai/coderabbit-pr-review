function greet(name: string) {
  console.log("Hello, " + name)
}

let unused = 123

const x = 1
x = 2

const items = [1, 2, 3]
items.forEach(async item => {
  await fetch(`/api/${item}`)
})

greet("world")
