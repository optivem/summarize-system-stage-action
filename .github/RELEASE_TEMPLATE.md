# Release v1.0.0

## 🎉 Initial Release

This is the initial release of the **Summarize System Stage Action** - a GitHub Action that creates comprehensive summaries of system stage execution results for CI/CD pipelines.

## ✨ Features

- ✅ **Input Validation**: Automatically validates inputs based on stage results
- 🌍 **Environment Tracking**: Tracks deployments across different environments  
- 🎯 **Release Management**: Records release candidates and artifacts
- 📊 **Structured Summaries**: Generates well-formatted stage summaries
- 🔗 **Artifact Support**: Supports tracking of Docker images, releases, and other artifacts

## 🚀 Usage

```yaml
- name: Summarize Acceptance Stage
  uses: optivem/summarize-system-stage-action@v1
  with:
    stage-name: 'Acceptance'
    stage-result: 'success'
    environment: 'acceptance-env'
    success-version: 'v1.2.3-rc.1'
    success-artifact-ids: 'docker.io/myapp:v1.2.3-rc.1'
```

## 📋 Inputs

| Input | Description | Required |
|-------|-------------|----------|
| `stage-name` | Stage name (e.g., Acceptance, QA, Production) | ✅ |
| `stage-result` | Stage result (success/failure/skipped) | ✅ |
| `environment` | Environment name | ✅ |
| `success-version` | Version on success* | ❌ |
| `success-artifact-ids` | Artifact IDs on success | ❌ |

*Required when `stage-result` is 'success'

## 🔗 Dependencies

- [`optivem/summarize-stage-action@v1`](https://github.com/optivem/summarize-stage-action)

## 📝 What's Changed

- Initial implementation of system stage summarization
- Comprehensive input validation
- Environment-aware deployment tracking
- Release candidate and artifact management
- Full documentation and examples

**Full Changelog**: https://github.com/optivem/summarize-system-stage-action/commits/v1.0.0