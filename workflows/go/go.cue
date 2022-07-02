package go

import (
	"json.schemastore.org/github"
	"github.com/sj14/cue-libs/workflows/common"
)

// TODO: drop when cuelang.org/issue/390 is fixed.
// Declare definitions for sub-schemas
_#job:  ((github.#Workflow & {}).jobs & {x: _}).x
_#step: ((_#job & {steps:                   _}).steps & [_])[0]

#stepSetup: _#step & {
	name: "Setup Go"
	uses: "actions/setup-go@v3"
	with: {
		"go-version":            string | *"1.18"
		cache:                   string | *"true"
		"cache-dependency-path": string | *"go.sum"
	}
}

#stepFmt: _#step & {
	name: "Run Go fmt"
	run: """
		go fmt ./...
		git diff --exit-code
		"""
}

#stepMod: _#step & {
	name: "Run Go fmt"
	run: """
		go mod tidy
		go mod verify
		git diff --exit-code
		"""
}

#stepTest: _#step & {
	name: "Run Go tests"
	run:  "go test -race ./..."
}

#jobDefault: _#job & {
	"runs-on": "ubuntu-22.04"
	steps: [
		common.#checkoutCode,
		#stepSetup,
		#stepMod,
		#stepFmt,
		#stepTest,
	]
}
