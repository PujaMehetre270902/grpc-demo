FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake

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

# Set the default command
CMD ["./build/grpcData"]
