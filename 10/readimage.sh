#!/bin/bash

# Check if podman is installed
if command -v podman &> /dev/null
then
    container_engine="podman"
# Check if docker is installed
elif command -v docker &> /dev/null
then
    container_engine="docker"
else
    # Neither podman nor docker is installed
    echo "Neither Podman nor Docker is installed."
    echo "Please install either Podman or Docker to proceed."
    exit 1
fi
echo "Using $container_engine as the container engine."
#
yq() {
  $container_engine run --rm -i -v "${PWD}":/workdir mikefarah/yq "$@"
}

# Default file
FILE="docker-compose.yml"

# Check for -f argument
while getopts "f:" opt; do
  case $opt in
    f)
      FILE="$OPTARG"
      ;;
    *)
      echo "Usage: $0 [-f docker-compose-file] build <service_name>"
      exit 1
      ;;
  esac
done

# Check if file exists
if [ ! -f "$FILE" ]; then
    echo "File $FILE does not exist."
    exit 1
fi

# Read and print service name, platform, and image
services=$(yq e '.services | keys | .[]' "$FILE")

for service in $services; do
    platform=$(yq e ".services.$service.platform" "$FILE")
    image=$(yq e ".services.$service.image" "$FILE")
    echo "Service: $service"
    echo "Platform: $platform"
    echo "Image: $image"
    echo "---------------------"
done

build_image() {
    local service=$1
    local platform=$(yq e ".services.$service.platform" "$FILE")
    local image=$(yq e ".services.$service.image" "$FILE")
    local context=$(yq e ".services.$service.build.context" "$FILE")
    local dockerfile=$(yq e ".services.$service.build.dockerfile" "$FILE")
    
    # Check if platform is defined
    if [ -z "$platform" ]; then
        echo "Error: Platform is not defined for service $service."
        exit 1
    fi
    
    # Replace '/' and ':' with '-' in the platform string to make it suitable for a tag
    local platform_tag=$(echo "$platform" | tr '/:' '-')
    
    # Append platform information to the image tag
    local new_image_tag="${image}-${platform_tag}"
    
    echo "Building service: $service"
    echo "Platform: $platform"
    echo "Image: $new_image_tag"
    echo "---------------------"
    
    $container_engine buildx build --platform "$platform" -t "$new_image_tag" -f "$context/$dockerfile" "$context"
}
# Check for "build" argument and optional service name
if [ "$1" == "build" ]; then
    if [ "$#" -ge 2 ]; then
        # Build specified service
        build_image "$2"
    else
        # Build all services
        services=$(yq e '.services | keys | .[]' "$FILE")
        for service in $services; do
            build_image "$service"
        done
    fi
else
    echo "Usage: $0 [-f docker-compose-file] build [service_name]"
    exit 1
fi
