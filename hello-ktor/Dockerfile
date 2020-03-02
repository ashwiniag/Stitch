# base imgae to be built upon
FROM adoptopenjdk/openjdk11:alpine-slim

# Set the working directory to /helloproject
WORKDIR /stitch

# Copy the current directory contents to helloproject
COPY . /stitch

# Run
CMD java -jar ./hello-ktor/build/libs/hello-ktor-1.0-all.jar

