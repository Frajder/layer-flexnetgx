# syntax=docker/dockerfile:1.4
# Stage 1: Build the Yew application
FROM rust:1.73 as builder

# Install curl and other dependencies
RUN apt-get update && apt-get install -y curl pkg-config libssl-dev

# Install wasm-pack using the prebuilt binary
RUN curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

# Set the working directory
WORKDIR /usr/src/app

# Copy the Cargo.toml and Cargo.lock files
COPY Cargo.toml Cargo.lock ./

# Build dependencies (optional but can speed up builds)
RUN mkdir src && echo "pub fn dummy() {}" > src/lib.rs
RUN wasm-pack build --target web --out-name flexnet_gx_web --release || true
RUN rm -r src

# Copy the source code
COPY src ./src

# Copy the index.html file
COPY index.html ./

# Build the application
RUN wasm-pack build --target web --out-name flexnet_gx_web --release

# Stage 2: Serve the application using Nginx
FROM nginx:alpine

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy our Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/

# Copy the built files from the builder stage
COPY --from=builder /usr/src/app/pkg /usr/share/nginx/html/pkg

# Copy the index.html file
COPY --from=builder /usr/src/app/index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
