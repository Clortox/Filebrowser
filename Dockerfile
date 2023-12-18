# Use the official Filebrowser image as a base
FROM filebrowser/filebrowser

# Copy the entrypoint script into the container
COPY ./entrypoint.sh /entrypoint.sh

# Ensure the script uses Unix line endings and is executable
RUN sed -i 's/\r$//' /entrypoint.sh && chmod +x /entrypoint.sh

# Set the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
