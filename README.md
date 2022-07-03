https://github.com/cue-examples/github-actions-example

https://www.youtube.com/watch?v=Ey3ca0K2h2U

curl -sO https://json.schemastore.org/github-workflow.json

cue import -l '#Workflow:' -p github jsonschema: github-workflow.json


~~cue export workflows/workflows.cue --out yaml~~

~~cue export workflows/*.cue --out yaml --outfile .github/workflows/cue.yaml --force~~

```
cue fmt ./... 
cue cmd genworkflows ./workflows
```