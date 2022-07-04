package common

import "json.schemastore.org/github"

// TODO: drop when cuelang.org/issue/390 is fixed.
// Declare definitions for sub-schemas
#job:  ((github.#Workflow & {}).jobs & {x: _}).x
#step: ((#job & {steps:                    _}).steps & [_])[0]

#checkoutCode: #step & {
	name: "Checkout Code"
	uses: "actions/checkout@v2"
}
