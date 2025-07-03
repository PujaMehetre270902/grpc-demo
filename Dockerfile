# Stage 1: Build with Ubuntu
FROM ubuntu:22.04 AS builder

# Install build tools
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    clang-tidy

WORKDIR /app

# Copy your source code
COPY . .

# Build the project
RUN mkdir -p build && \
    cd build && \
    cmake .. && \
    make && \
    ls -l

# Stage 2: Run with Alpine
FROM alpine:latest

# Fix for glibc dynamic linking
RUN apk add --no-cache libc6-compat

WORKDIR /app

# Copy only the final binary from the builder stage
COPY --from=builder /app/build/grpcData .

# Optional: make sure it is executable
RUN chmod +x grpcData

# Set the command to run the app
CMD ["./grpcData"]