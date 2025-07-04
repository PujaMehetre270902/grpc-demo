FROM ubuntu:22.04

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

# Build
RUN mkdir -p build && \
    cd build && \
    cmake .. && \
    make

# Run
CMD ["./build/grpcData"]