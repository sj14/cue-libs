Release: {
	on: [
		"push",
		"pull_request",
	]
	name: "Workflow 1"
	jobs: {
		"runs-on": "ubuntu-latest"
		steps: [
			_#installGo,
		]
	}
}

_#checkoutCode: {
	name: "Checkout Code"
	uses: "actions/checkout@v2"
}

_#installGo: {
	name: "Setup Go"
	uses: "actions/setup-go@v3"
	with: {
		"go-version":            string | *"1.18"
		cache:                   string | *"true"
		"cache-dependency-path": string | *"go.sum"
	}
}

_#goTest: {
	name: "Test"
	run:  "go test -race ./..."
}
