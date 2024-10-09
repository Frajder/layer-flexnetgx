# FlexNet GX Lambda Function

This directory contains the AWS Lambda function code for the FlexNet GX application.

## Building with Docker

To build the Lambda function using Docker:

1. **Build the Docker image**:

   ```bash
   docker build -t flexnet-gx-lambda-builder .
   ```

2. **Extract the `rust.zip` file from the Docker image**:

   ```bash
   docker create --name temp-container flexnet-gx-lambda-builder
   docker cp temp-container:/usr/src/app/rust.zip ./rust.zip
   docker rm temp-container
   ```

   The `rust.zip` file is now available in the current directory and can be deployed to AWS Lambda.

## Deployment

Ensure you have set up your AWS credentials and configured the `.env` file.

To deploy the Lambda function:

```bash
./deploy-lambda.sh
```

## Configuration

Copy the `.env.example` file to `.env` and fill in the required AWS configurations:

```bash
cp .env.example .env
```

Edit the `.env` file and set the following variables:

- `LAMBDA_FUNCTION_NAME`
- `LAMBDA_FUNCTION_ARN`
- `LAMBDA_ROLE_ARN`

## Requirements

- **Docker**: To build the Lambda function in a containerized environment.
- **AWS CLI**: Configured with appropriate permissions.