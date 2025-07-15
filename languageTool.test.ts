import { runLanguageTool } from "./languageTool"
import fs from "fs"
import { env } from "../../utils/env"

const fileContent = fs.readFileSync("sample.txt", "utf-8")

const mockParams = {
	logger: {
		child: () => ({
			debug: console.log,
			error: console.error,
		}),
	},
	settings: {
		configSettings: {
			reviews: {
				profile: "chill", // or "assertive"
				tools: {
					languagetool: {
						enabled: true,
						disabled_categories: [],
						disabled_rules: [],
						enabled_categories: [],
						enabled_rules: [],
						enabled_only: false,
						level: "default",
					},
				},
			},
			language: "en-US",
		},
	},
	fileHunks: [
		{
			repoFile: {
				filename: "sample.txt",
			},
			fileContent,
			hunks: [],
			toolOutputs: {},
		},
	],
} as any

// Fake credentials for testing (you should replace these with valid test creds or mock the API)
env.LANGUAGETOOL_USERNAME = "fakeUser"
env.LANGUAGETOOL_API_KEY = "fakeKey"

runLanguageTool(mockParams).then(() => {
	console.log("Test complete. Tool outputs:", mockParams.fileHunks[0].toolOutputs)
})

