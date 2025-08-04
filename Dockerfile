FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clone the Duo Universal Python repository
RUN git clone https://github.com/duosecurity/duo_universal_python.git /tmp/duo_universal_python

# Copy demo files to working directory
RUN cp -r /tmp/duo_universal_python/demo/* /app/ && \
    rm -rf /tmp/duo_universal_python

# Install Python dependencies
RUN pip install --no-cache-dir \
    duo_universal \
    flask \
    pyopenssl

# Create a startup script to handle config file location
RUN echo '#!/bin/bash\n\
if [ -f "$DUO_CONFIG_PATH" ]; then\n\
    cp "$DUO_CONFIG_PATH" /app/duo.conf\n\
else\n\
    echo "Error: duo.conf not found at $DUO_CONFIG_PATH"\n\
    echo "Please create a duo.conf file in the config directory"\n\
    exit 1\n\
fi\n\
flask run --host=0.0.0.0 --port 8080 --cert=adhoc' > /app/start.sh && chmod +x /app/start.sh
#python app.py --cert=adhoc' > /app/start.sh && chmod +x /app/start.sh

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["/app/start.sh"]