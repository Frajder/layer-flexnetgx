# Dockerfile for building the AWS Lambda function

# Stage 1: Build the Rust project
FROM rust:1.66 as builder

# Install musl target
RUN rustup target add x86_64-unknown-linux-musl

# Set work directory
WORKDIR /usr/src/app

# Copy Cargo.toml and Cargo.lock
COPY Cargo.toml Cargo.lock ./

# Build dependencies
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --release --target x86_64-unknown-linux-musl
RUN rm src/main.rs

# Copy source code
COPY . .

# Build the project
RUN cargo build --release --target x86_64-unknown-linux-musl

# Package the Lambda function
RUN cd ./target/x86_64-unknown-linux-musl/release/ && \
    zip -j /usr/src/app/rust.zip bootstrap

# Stage 2: Prepare the final image (optional)
FROM alpine:latest

# Copy the zip file
COPY --from=builder /usr/src/app/rust.zip /rust.zip

# Entry point (if needed)
# ENTRYPOINT ["your-entrypoint"]
