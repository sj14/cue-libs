package cue

import (
	"github.com/sj14/cue-libs/workflows/common"
)

#stepSetup: common.#step & {
	name: "Setup CUE"
	uses: "cue-lang/setup-cue@v1.0.0-alpha.2"
}

#stepFmt: common.#step & {
	name: "CUE fmt"
	run: """
		cue fmt ./...
		git diff --exit-code
		"""
}

#stepVet: common.#step & {
	name: "CUE vet"
	run: """
		cue vet ./...
		git diff --exit-code
		"""
}

#stepGen: common.#step & {
	name: "CUE genworkflows"
	run: """
		cue cmd genworkflows ./workflows
		git diff --exit-code
		"""
}

#jobDefault: common.#job & {
	"runs-on": "ubuntu-22.04"
	steps: [
		common.#checkoutCode,
		#stepSetup,
		#stepFmt,
		#stepVet,
		#stepGen,
	]
}
