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
| `success-artifact-ids` | The artifact IDs created on success as JSON array (e.g., ["docker.io/myapp:v1.2.3"]) | ❌ | - |

*Required when `stage-result` is 'success'

## Input Formats

### success-artifact-ids

This input supports multiple formats for maximum flexibility:

1. **JSON Array (Recommended)**: `'["artifact1", "artifact2", "artifact3"]'`
   - Best for programmatic generation
   - Handles complex URLs and special characters safely
   - Formats as a bulleted list in the summary

2. **Comma-delimited (Legacy)**: `'artifact1, artifact2, artifact3'`
   - Backward compatible with existing workflows
   - Automatically converted to bulleted list format

3. **Single Artifact**: `'single-artifact'`
   - For workflows with only one artifact

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

### Multiple Artifacts (JSON Array - Recommended)
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

### Backward Compatibility (Comma-delimited)
```yaml
- name: Summarize with Legacy Format
  uses: optivem/summarize-system-stage-action@v1
  with:
    stage-name: 'Production'
    stage-result: 'success'
    environment: 'prod'
    success-version: 'v1.2.3'
    success-artifact-ids: 'docker.io/myapp:v1.2.3, https://github.com/owner/repo/releases/tag/v1.2.3'
```

## Dependencies

This action depends on:
- [`optivem/summarize-stage-action@v1`](https://github.com/optivem/summarize-stage-action) - The base action for stage summarization

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
