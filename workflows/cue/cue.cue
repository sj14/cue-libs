package cue

import (
	"json.schemastore.org/github"
	"github.com/sj14/cue-libs/workflows/common"
)

// TODO: drop when cuelang.org/issue/390 is fixed.
// Declare definitions for sub-schemas
_#job:  ((github.#Workflow & {}).jobs & {x: _}).x
_#step: ((_#job & {steps:                   _}).steps & [_])[0]

#stepSetup: _#step & {
	name: "Setup CUE"
	uses: "cue-lang/setup-cue@v1.0.0-alpha.2"
}

#stepFmt: _#step & {
	name: "Run CUE fmt"
	run: """
		cue fmt ./...
		git diff --exit-code
		"""
}

#stepVet: _#step & {
	name: "Run CUE vet"
	run: """
		cue vet ./...
		git diff --exit-code
		"""
}

#jobDefault: _#job & {
	"runs-on": "ubuntu-22.04"
	steps: [
		common.#checkoutCode,
		#stepSetup,
		#stepFmt,
		#stepVet,
		// TODO: check if exported file is up2date
	]
}
