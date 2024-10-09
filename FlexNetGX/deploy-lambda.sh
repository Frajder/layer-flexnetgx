#!/bin/bash

set -e

if [ ! -f .env ]; then
    echo ".env file not found. Please create one based on .env.example"
    exit 1
fi

source .env

# Check required variables
if [ -z "$LAMBDA_FUNCTION_NAME" ] || [ -z "$LAMBDA_FUNCTION_ARN" ] || [ -z "$LAMBDA_ROLE_ARN" ]; then
    echo "Please set LAMBDA_FUNCTION_NAME, LAMBDA_FUNCTION_ARN, and LAMBDA_ROLE_ARN in your .env file."
    exit 1
fi

# Lambda function configurations
LAMBDA_RUNTIME="${LAMBDA_RUNTIME:-provided.al2}"
LAMBDA_HANDLER="${LAMBDA_HANDLER:-bootstrap}"

# Build and package Lambda function
echo "Building and packaging Lambda function..."
cd flexnet-gx-lambda
docker build -t flexnet-gx-lambda-builder .

# Extract rust.zip from Docker image
echo "Extracting rust.zip from Docker image..."
docker create --name temp-container flexnet-gx-lambda-builder
docker cp temp-container:/usr/src/app/rust.zip ./rust.zip
docker rm temp-container

# Update Lambda function configuration
echo "Updating Lambda function configuration..."
aws lambda update-function-configuration \
    --function-name "$LAMBDA_FUNCTION_ARN" \
    --runtime "$LAMBDA_RUNTIME" \
    --handler "$LAMBDA_HANDLER" \
    --role "$LAMBDA_ROLE_ARN"

# Deploy Lambda function code
echo "Deploying Lambda function code..."
aws lambda update-function-code \
    --function-name "$LAMBDA_FUNCTION_ARN" \
    --zip-file fileb://rust.zip

# Verify the update
echo "Verifying Lambda function update..."
aws lambda get-function --function-name "$LAMBDA_FUNCTION_ARN"

echo "Lambda function updated successfully."
cd ..