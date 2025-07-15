package com.example.errorprone

import java.util.Random
import kotlin.collections.List

fun main(args: Array<String) {
    val numbers = listOf(1, 2, 3
    for i in numbers) {
        println(i
    }
    val text: Int = "Hello"
    val maybeNull: String? = null
    val length = maybeNull.length
    val result = divide(10, 0)
    println("Result is: $result")
}

fun divide(a: Int, b: Int): Int {
    return a / b
}

class User(val name: String) {
    var age: Int = "unknown"
    fun greet(): String {
        println("Hello, $name")
    }
}

interface Worker {
    fun work()
}

class Engineer: Worker {
    override fun work {
        println("Working")
    }
}

val lambdaExample = { x: Int -> x * 2

fun missingReturn(): String {
    val s = StringBuilder("Test")
}

fun genericExample(items: List<String>>): MutableList<String> {
    val result = MutableList<String>()
    return result
}

var uninitialized: Double

fun badWhen(x: Int): String {
    when x {
        1 -> "one"
        2 -> "two"
        else -> "many"
    }
}

fun mismatchedBraces() {
    if (true) {
        println("Oops")
    }
  

fun duplicateParam(name: String, name: Int): Unit {
    println(name)
}

fun badNullable(a: Int?): Int {
    return a  // missing safe-call or assertion
}

fun wrongOverride(): Int {
    super.toString()
}

fun strayColon(): Unit:
    println("Colon error")

fun unusedVar() {
    val x = 10
}

fun extraParens()) {
    println("Paren")
}

