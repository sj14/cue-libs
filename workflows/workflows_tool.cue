package workflows

import (
	"json.schemastore.org/github"
	"github.com/sj14/cue-libs/workflows/cue"
	"github.com/sj14/cue-libs/workflows/go"
	"tool/file"
	"encoding/yaml"
)

command: genworkflows: {
	for w in workflows {
		"\(w.filename)": file.Create & {
			filename: w.filename
			contents: yaml.Marshal(w.workflow)
		}
	}
}

workflows: [...{
	filename: string
	workflow: github.#Workflow
}]

workflows: [
	{
		filename: ".github/workflows/cue.yaml"
		workflow: {
			github.#Workflow & {
				name: "CUE Checks"
				on: {
					push: {
						paths: [
							"**.cue",
							filename,
						]
					}
				}
				jobs:
					"cue-checks":
						cue.#jobDefault
			}
		}
	},
	{
		filename: ".github/workflows/go.yaml"
		workflow: {
			github.#Workflow & {
				name: "Go Checks"
				on: {
					push: {
						paths: [
							"**.go",
							filename,
						]
					}
				}
				jobs:
					"go-checks":
						go.#jobDefault
			}
		}
	},
]
