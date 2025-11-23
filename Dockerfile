# Dockerfile for building Zig React Native libraries
# Usage: docker build -t zig-rn-builder .
#        docker run --rm -v $(pwd):/workspace -w /workspace/zig_backend zig-rn-builder

FROM ziglang/zig:0.13.0

# Install lipo for macOS universal binaries (if building on Linux for iOS)
RUN apk add --no-cache bash

WORKDIR /workspace

# Set the entrypoint to bash for running build scripts
ENTRYPOINT ["/bin/bash"]
CMD ["./build_all.sh"]
