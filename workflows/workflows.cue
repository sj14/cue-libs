package workflows

import (
	"json.schemastore.org/github"
	"github.com/sj14/cue-libs/workflows/common"
	"github.com/sj14/cue-libs/workflows/go"
)

// TODO: drop when cuelang.org/issue/390 is fixed.
// Declare definitions for sub-schemas
_#job:  ((github.#Workflow & {}).jobs & {x: _}).x
_#step: ((_#job & {steps:                   _}).steps & [_])[0]

"test.yaml": github.#Workflow & {
	{
		name: "Release"
		on: [
			"push",
			"pull_request",
		]
		jobs: gotests: {
			"runs-on": "ubuntu-latest"
			steps: [
				common.#checkoutCode,
				go.#goSetup,
				go.#goMod,
				go.#goFmt,
				go.#goTest,
			]
		}
	}
}
