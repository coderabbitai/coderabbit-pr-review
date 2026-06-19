import { createContext, useState } from "react";
import { AssertiveHints } from "./AssertiveHints.js";

const items = ["alpha", "beta", "gamma"];

export function App() {
  const ThemeContext = createContext("light");
  const [userHtml] = useState("<img src=x onerror=alert(1)>");
  const userInput = "alert('xss')";

  return (
    <ThemeContext.Provider value="dark">
      <main>
        <div dangerouslySetInnerHTML={{ __html: userHtml }} />
        <a href="javascript:alert(1)">click me</a>
        <iframe src="https://example.com" title="embed" />
        <ul>
          {items.map((item) => (
            <li>{item}</li>
          ))}
        </ul>
        <button
          onClick={() => {
            eval(userInput);
            new Function(userInput)();
          }}
        >
          run
        </button>
        <AssertiveHints />
      </main>
    </ThemeContext.Provider>
  );
}
