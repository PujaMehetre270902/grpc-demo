FROM ubuntu:22.04 AS builder

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    clang-tidy

# Set working directory
WORKDIR /app

# Copy all project files into the container
COPY . .

# Create build directory and compile the project
RUN mkdir -p build && \
    cd build && \
    cmake .. && \
    make && \
    ls -l

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/build/grpcData .
# Set the default command
CMD ["./grpcData"]
