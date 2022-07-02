package common

import "json.schemastore.org/github"

// TODO: drop when cuelang.org/issue/390 is fixed.
// Declare definitions for sub-schemas
_#job:  ((github.#Workflow & {}).jobs & {x: _}).x
_#step: ((_#job & {steps:                   _}).steps & [_])[0]

#checkoutCode: _#step & {
	name: "Checkout Code"
	uses: "actions/checkout@v2"
}
