# Summarize System Stage Action

A GitHub Action that creates comprehensive summaries of system stage execution results, perfect for CI/CD pipelines that need to track deployment stages across different environments.

## Features

- ✅ Validates inputs based on stage results
- 🌍 Tracks environment-specific deployments  
- 🎯 Records release candidates and artifacts
- 📊 Generates structured stage summaries
- 🔗 Supports artifact tracking (images, releases, etc.)

## Usage

```yaml
- name: Summarize Acceptance Stage
  uses: optivem/summarize-system-stage-action@v1
  with:
    stage-name: 'Acceptance'
    stage-result: 'success'
    environment: 'acceptance-env'
    success-version: 'v1.2.3-rc.1'
    success-artifact-ids: '["docker.io/myapp:v1.2.3-rc.1", "https://github.com/owner/repo/releases/tag/v1.2.3-rc.1"]'
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `stage-name` | The name of the stage (e.g., Acceptance, QA, Production) | ✅ | - |
| `stage-result` | Overall result of the stage (success/failure/skipped) | ✅ | - |
| `environment` | The environment name for this stage | ✅ | - |
| `success-version` | The version created on success (e.g., prerelease version) | ❌* | - |
| `success-artifact-ids` | The artifact IDs created on success as JSON array. Single: ["artifact"], Multiple: ["artifact1", "artifact2"] | ❌ | - |

*Required when `stage-result` is 'success'

## Input Formats

### success-artifact-ids

This input accepts **JSON arrays only** for consistency and reliability:

**JSON Array Format** (Required): `'["artifact1", "artifact2", "artifact3"]'`
- Safe handling of complex URLs and special characters
- Formats as a clean bulleted list in the summary
- Single artifacts must also use array format: `'["single-artifact"]'`

## Examples

### Successful Stage
```yaml
- name: Summarize Production Deployment
  uses: optivem/summarize-system-stage-action@v1
  with:
    stage-name: 'Production'
    stage-result: 'success'
    environment: 'prod'
    success-version: 'v1.2.3'
    success-artifact-ids: '["docker.io/myapp:v1.2.3"]'
```

### Failed Stage
```yaml
- name: Summarize QA Stage
  uses: optivem/summarize-system-stage-action@v1
  with:
    stage-name: 'QA'
    stage-result: 'failure'
    environment: 'qa-env'
```

### Skipped Stage
```yaml
- name: Summarize Skipped Stage
  uses: optivem/summarize-system-stage-action@v1
  with:
    stage-name: 'Acceptance'
    stage-result: 'skipped'
    environment: 'acceptance-env'
```

### Multiple Artifacts (JSON Array)
```yaml
- name: Summarize with Multiple Artifacts
  uses: optivem/summarize-system-stage-action@v1
  with:
    stage-name: 'Production'
    stage-result: 'success'
    environment: 'prod'
    success-version: 'v1.2.3'
    success-artifact-ids: >
      [
        "docker.io/myapp:v1.2.3",
        "docker.io/myapp:latest", 
        "https://github.com/owner/repo/releases/tag/v1.2.3",
        "https://artifacts.example.com/myapp-v1.2.3.tar.gz"
      ]
```

### Single Artifact (JSON Array)
```yaml
- name: Summarize with Single Artifact
  uses: optivem/summarize-system-stage-action@v1
  with:
    stage-name: 'Staging'
    stage-result: 'success'
    environment: 'staging'
    success-version: 'v1.2.3-rc.1'
    success-artifact-ids: '["docker.io/myapp:v1.2.3-rc.1"]'
```

## Dependencies

This action depends on:
- [`optivem/summarize-stage-action@v1`](https://github.com/optivem/summarize-stage-action) - The base action for stage summarization

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
