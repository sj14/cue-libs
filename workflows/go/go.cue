package go

import "json.schemastore.org/github"

// TODO: drop when cuelang.org/issue/390 is fixed.
// Declare definitions for sub-schemas
_#job:  ((github.#Workflow & {}).jobs & {x: _}).x
_#step: ((_#job & {steps:                   _}).steps & [_])[0]

#goSetup: _#step & {
	name: "Setup Go"
	uses: "actions/setup-go@v3"
	with: {
		"go-version":            string | *"1.18"
		cache:                   string | *"true"
		"cache-dependency-path": string | *"go.sum"
	}
}

#goFmt: _#step & {
	name: "Run Go fmt"
	run: """
		go fmt ./...
		git diff --exit-code
		"""
}

#goMod: _#step & {
	name: "Run Go fmt"
	run: """
		go mod tidy
		go mod verify
		git diff --exit-code
		"""
}

#goTest: _#step & {
	name: "Run Go tests"
	run:  "go test -race ./..."
}
