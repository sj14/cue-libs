Release: {
	on: [
		"push",
		"pull_request",
	]
	name: "Workflow 1"
	jobs: {
		"runs-on": "ubuntu-latest"
		steps: [
			_#checkoutCode,
			_#goSetup,
			// _#goMod,
			_#goFmt,
			_#goTest,

		]
	}
}

_#checkoutCode: {
	name: "Checkout Code"
	uses: "actions/checkout@v2"
}

_#goSetup: {
	name: "Setup Go"
	uses: "actions/setup-go@v3"
	with: {
		"go-version":            string | *"1.18"
		cache:                   string | *"true"
		"cache-dependency-path": string | *"go.sum"
	}
}

_#goFmt: {
	name: "Run Go fmt"
	run: """
		go fmt ./...
		git status --exit-code
		"""
}

_#goTest: {
	name: "Run Go tests"
	run:  "go test -race ./..."
}
