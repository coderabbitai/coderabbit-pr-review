import { useState } from 'react'

const greeting: string = "Hello, world!";

async function test() {
    
    const [state, setState] = useState<string>("test string")

    const [state2, setState2] = useState<string>("test string")

    const [first, second] = await Promise.all([
        await (new Promise(() => {console.log("logging this long task")})),
        new Promise(() => {console.log("logging another long task")}),
    ])

    return {
        state,
        setState,
        first,
        second
    }
}
