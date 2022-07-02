https://www.youtube.com/watch?v=Ey3ca0K2h2U

curl -sO https://json.schemastore.org/github-workflow.json

cue import -l '#Workflow:' -p github jsonschema: github-workflow.json