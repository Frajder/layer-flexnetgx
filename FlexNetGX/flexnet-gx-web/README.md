# FlexNet GX Web Frontend

This directory contains the Yew-based web frontend for the FlexNet GX application.

## Building and Running with Docker

To build and run the FlexNet GX Web Frontend using Docker:

1. **Build the Docker image**:

   ```bash
   docker build -t flexnet-gx-web .
   ```

2. **Run the Docker container**:

   ```bash
   docker run --rm -p 8080:80 flexnet-gx-web
   ```

   This command maps port `80` in the container to port `8080` on your host machine.

3. **Access the application**:

   Open your web browser and navigate to `http://localhost:8080` to see the application.

**Note**: If you prefer to use a different port, change the `-p` option accordingly (e.g., `-p 8000:80`).

## Project Structure

- `src/`: Contains the Rust source code for the Yew application.
- `Cargo.toml`: Rust project configuration file.
- `index.html`: The HTML file that loads the WebAssembly module.
- `Dockerfile`: Dockerfile to build and run the application.
- `nginx.conf`: Nginx configuration file for serving the application.

## Requirements

- **Docker**: Ensure Docker is installed on your system.

## Building Without Docker

If you prefer to build the project without Docker, follow these steps:

1. **Install Rust and wasm-pack**:

   - Install Rust from [rust-lang.org](https://www.rust-lang.org/tools/install).
   - Install `wasm-pack`:

     ```bash
     cargo install wasm-pack
     ```

2. **Build the project**:

   ```bash
   wasm-pack build --target web --out-name flexnet_gx_web --release
   ```

3. **Serve the application**:

   Use a simple HTTP server to serve the files. For example:

   ```bash
   python3 -m http.server 8080
   ```

   Then navigate to `http://localhost:8080` in your browser.

**Note**: Serving via a local file (`file://`) will not work due to browser security restrictions.

---

### Instructions to Run Docker

**Prerequisites**:

- Docker installed on your system. If not, download it from the [Docker website](https://www.docker.com/get-started).

**Steps**:

1. **Navigate to the `flexnet-gx-web` directory**:

   ```bash
   cd FlexNetGX/flexnet-gx-web
   ```

2. **Build the Docker image**:

   ```bash
   docker build -t flexnet-gx-web .
   ```

   This command builds the Docker image and tags it as `flexnet-gx-web`.

3. **Run the Docker container**:

   ```bash
   docker run --rm -p 8080:80 flexnet-gx-web
   ```

   - `--rm`: Automatically remove the container when it exits.
   - `-p 8080:80`: Maps port `80` in the container to port `8080` on your host machine.

4. **Access the application**:

   Open your web browser and navigate to:

   ```
   http://localhost:8080
   ```

   You should see the FlexNet GX Web Frontend running.

**Customizing the Port**:

If port `8080` is already in use or you want to use a different port, change the `-p` option

---

### Additional Notes

- **Multi-Stage Build**: The Dockerfile uses a multi-stage build to keep the final image small. The first stage builds the application using the Rust compiler and `wasm-pack`. The second stage uses an Nginx image to serve the compiled WebAssembly and associated files.

- **Nginx Configuration**: The `nginx.conf` file configures Nginx to serve the static files. It sets the document root to `/usr/share/nginx/html`, where the `index.html` and `pkg` directory are located.

- **Docker Image Size**: By using multi-stage builds and starting from `nginx:alpine`, the final Docker image is small and efficient.

- **Rebuilding the Image**: If you make changes to the source code, rebuild the Docker image to see the changes:

  ```bash
  docker build -t flexnet-gx-web .
  ```

@Frajder was here to enhance security, improve build consistency using Docker, and provide clearer documentation. These changes should make it easier to build, deploy, and maintain the FlexNet GX application.