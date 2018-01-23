# Create image from primetoninc/jdk:1.8
FROM primetoninc/jdk:1.8

# Author signature
MAINTAINER mouad.elfakir@gmail.com

# Copy hybris.zip inside the Container
COPY hybris.zip /src/hybris.zip

# Navigate to /src directory
WORKDIR /src

# Unzip hybris.zip
RUN unzip hybris.zip

# navigate to the platform directory
WORKDIR /src/hybris/bin/platform/

# Add exec permission to .sh files
RUN find ./ -type f -iname "*.sh" -exec chmod +x {} \;

# Expose http port
EXPOSE 9001

# Expose https port
EXPOSE 9002

# Expose Debug port
EXPOSE 8000

# Run ant clean all (also ant initialize if it's needed)
RUN . ./setantenv.sh && ant clean all

# Run Hybris server
CMD ["./hybrisserver.sh"]
