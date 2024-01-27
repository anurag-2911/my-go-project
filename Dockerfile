# Start from the official Go image to create a build artifact.
# This image will be used in the build stage.
FROM golang:1.21.6 AS builder

# Set the working directory inside the container.
WORKDIR /app

# Copy go.mod and go.sum to download dependencies.
# Copying this separately prevents re-downloading dependencies on every build.
COPY go.mod ./

# Download dependencies.
RUN go mod download

# Copy the rest of the source code.
COPY cmd/ ./cmd/

# Build the Go app.
RUN CGO_ENABLED=0 GOOS=linux go build -v -o myapp ./cmd/myapp

# Start a new stage from scratch for the final image.
FROM alpine:latest

# Install certificates for secure connections.
RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copy the pre-built binary file from the builder stage.
COPY --from=builder /app/myapp .

# Command to run the executable.
CMD ["./myapp"]
