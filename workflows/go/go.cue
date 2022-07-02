package go

#goSetup: {
	name: "Setup Go"
	uses: "actions/setup-go@v3"
	with: {
		"go-version":            string | *"1.18"
		cache:                   string | *"true"
		"cache-dependency-path": string | *"go.sum"
	}
}

#goFmt: {
	name: "Run Go fmt"
	run: """
		go fmt ./...
		git diff --exit-code
		"""
}

#goMod: {
	name: "Run Go fmt"
	run: """
		go mod tidy
		go mod verify
		git diff --exit-code
		"""
}

#goTest: {
	name: "Run Go tests"
	run:  "go test -race ./..."
}
