# Stage 1: Builder
FROM alpine:latest AS builder

# Install build tools and clang-tidy
RUN apk add --no-cache build-base cmake clang-tidy

WORKDIR /app

# Copy source code
COPY . .

# Build
RUN mkdir -p build && \
    cd build && \
    cmake .. && \
    make && \
    ls -l

# Stage 2: Runtime
FROM alpine:latest

# 👇 Add this line to get the C++ standard library!
RUN apk add --no-cache libstdc++

WORKDIR /app

# Copy only the built binary
COPY --from=builder /app/build/grpcData .

# Ensure executable permissions
RUN chmod +x grpcData

# Default command
CMD ["./grpcData"]