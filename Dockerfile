FROM ubuntu:22.04

# Install build tools
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        cmake \
        clang-tidy \
        git \
        pkg-config

# Install Catch2 from source with proper configuration
RUN git clone https://github.com/catchorg/Catch2.git /tmp/Catch2 && \
    cd /tmp/Catch2 && \
    git checkout v2.13.9 && \
    mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_TESTING=OFF && \
    make -j$(nproc) && \
    make install && \
    ldconfig && \
    rm -rf /tmp/Catch2

# Set workdir
WORKDIR /app

# Copy project
COPY . .

# Build project
RUN mkdir -p build && \
    cd build && \
    cmake .. -DCMAKE_PREFIX_PATH="/usr/local" -DCMAKE_BUILD_TYPE=Release && \
    make

# Run tests
CMD ["./build/vehicle_controller_tests"]
