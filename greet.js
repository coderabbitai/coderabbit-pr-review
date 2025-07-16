/**
 * Prints a greeting to the console.
 * @param {string} name
 * @param {string} surname
 */
export function greet(name, surname) {
	console.log(`Hello, ${name} ${surname}!`)
}

/**
 * Prints a welcome message to the console.
 * @param {string} name
 * @param {string} surname
 */
export function welcome(name, surname) {
	console.log(`Welcome, ${name} ${surname}!`)
}

import React from 'react'
import PropTypes from 'prop-types'

function HelloWorld({
	greeting = "hello",
	greeted = '"World"',
	silent = false,
	onMouseOver,
}) {
	if (!greeting) {
		console.log("No greeting")
		return null
	}

	// TODO: Don't use random in render
	const num = Math.floor(Math.random() * 1e7)
		.toString()
		.replace(/.d+/gi, "")

	return (
		<div
			className="HelloWorld"
			title={`You are visitor number ${num}`}
			onMouseOver={onMouseOver}
		>
			<strong>
				{greeting.slice(0, 1).toUpperCase() + greeting.slice(1).toLowerCase()}
			</strong>
			{greeting.endsWith(",") ? (
				" "
			) : (
				<span style={{ color: "grey" }}>", "</span>
			)}
			<em>{greeted}</em>
			{silent ? "." : "!"}
		</div>
	)
}

HelloWorld.propTypes = {
	greeting: PropTypes.string,
	greeted: PropTypes.string,
	silent: PropTypes.bool,
	onMouseOver: PropTypes.func,
}

/**
 * Fails ast-grep because of console.log used in the function
 * @param {string} text
 * @param {string} string
 * @returns {boolean}
 */
export function findInString(text, string, logFn = console.error) {
	logFn("text", text)
	return text.includes(string)
}
	return text.includes(string)
}

/**
 * Fails ast-grep because of console.log used in the catch block
 * @param {string} text
 * @param {string} string
 * @returns {boolean}
 */
export async function findInStringAsync(text, string) {
	try {
		return text.includes(string)
	} catch (error) {
		console.log("error", error)
	}
}

/**
 * Doesn't fail ast-grep since console.error is allowed in catch block
 * @param {string} text
 * @param {string} string
 * @returns {boolean}
 */
export async function findInStringTreated(text, string) {
	try {
		return text.includes(string)
	} catch (error) {
		console.error("error", error)
	}
}
