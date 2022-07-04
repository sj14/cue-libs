package go

import (
	"github.com/sj14/cue-libs/workflows/common"
)

#stepSetup: common.#step & {
	name: "Setup Go"
	uses: "actions/setup-go@v3"
	with: {
		"go-version":            string | *"1.18"
		cache:                   string | *"true"
		"cache-dependency-path": string | *"go.sum"
	}
}

#stepFmt: common.#step & {
	name: "Go fmt"
	run: """
		go fmt ./...
		git diff --exit-code
		"""
}

#stepMod: common.#step & {
	name: "Mod checks"
	run: """
		go mod tidy
		go mod verify
		git diff --exit-code
		"""
}

#stepVet: common.#step & {
	name: "Go vet"
	run: """
		go vet ./...
		"""
}

#stepTest: common.#step & {
	name: "Go tests"
	run:  "go test -race ./..."
}

#jobDefault: common.#job & {
	"runs-on": "ubuntu-22.04"
	steps: [
		common.#checkoutCode,
		#stepSetup,
		#stepMod,
		#stepFmt,
		#stepVet,
		#stepTest,
	]
}
