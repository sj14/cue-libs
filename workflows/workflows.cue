package workflows

import (
	"github.com/sj14/cue-libs/workflows/common"
	"github.com/sj14/cue-libs/workflows/go"
)

Release: {
	name: "Release"
	on: [
		"push",
		"pull_request",
	]
	jobs: {
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
