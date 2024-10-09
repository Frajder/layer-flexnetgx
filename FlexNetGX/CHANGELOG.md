# Changelog

## [Unreleased]

### Added

- **Dockerfile** for building the AWS Lambda function (`flexnet-gx-lambda/Dockerfile`).
- **Environment Variable Support**: `.env.example` added for AWS configurations.
- **Detailed Documentation**: Updated `README.md` files with Docker instructions.
- **Dockerfile** for building and running the FlexNet GX Web Frontend (`flexnet-gx-web/Dockerfile`).
- **nginx.conf**: Nginx configuration file for serving the web application.
- **Instructions** in `flexnet-gx-web/README.md` for building and running with Docker.
- **CHANGELOG.md**: Documenting changes to the project.

### Changed

- **`deploy-lambda.sh`**: Now uses environment variables instead of hardcoded AWS ARNs.
- **`deploy.sh`**: Adjusted to source environment variables from `.env`.
- **Removed Redundant File**: Deleted `src/main.rs` from `flexnet-gx-blockchain`.
- **`flexnet-gx-web/build.sh`**: No longer necessary when using Docker; instructions updated.

### Removed

- **Hardcoded AWS Credentials**: Removed from scripts to enhance security.
- **Redundant Files**: Cleaned up unnecessary files in the project.