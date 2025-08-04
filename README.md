# Docker Compose Setup for Duo Universal Python Demo

This repo contains everything needed to quickly run the demo from [duo_universal_python](https://github.com/duosecurity/duo_universal_python) in a docker container accessible on the network. This is meant for testing and experimentation only - not for production use.

## Setup Instructions

1. **Clone the repo:**
   ```bash
   git clone https://github.com/ebob9/duo_universal_python_container.git
   cd duo_universal_python_container
   ```

2. **Set up your Duo configuration:**
   - Copy `config/duo.conf.example` to `config/duo.conf`
   - Log into your Duo Admin Panel
   - Create a new Web SDK application
   - Copy your Client ID, Client Secret, and API Hostname into `duo.conf`
   - Update the redirect_uri, if you want it to redirect to an actual application.

3. **Build and run the container:**
   ```bash
   # Build the Docker image
   docker-compose build

   # Run the container
   docker-compose up -d

   # View logs
   docker-compose logs -f
   ```

4. **Access the application:**
   - Navigate to https://localhost:8080
   - Log in with any username (password can be anything for the demo)
   - You'll be redirected to Duo for 2FA

## Troubleshooting

1. **Container won't start:**
   - Check that `config/duo.conf` exists and has valid credentials
   - Run `docker-compose logs` to see error messages

2. **Can't access from browser:**
   - Ensure port 8080 isn't already in use
   - Check firewall settings
   - Verify the redirect_uri matches your access URL

3. **Duo authentication fails:**
   - Verify your Duo credentials are correct
   - Check that the redirect_uri in duo.conf is a https url.
   - Ensure the Web SDK application is active in the Admin Panel.

## Security Notes

- Never commit `duo.conf` with real credentials.
- In production, use proper SSL certificates (not self-signed as this container does.)
- Consider using Docker secrets for sensitive configuration.

## Commands Reference

```bash
# Start the container
docker-compose up -d

# Stop the container
docker-compose down

# Rebuild after changes
docker-compose build --no-cache

# View logs
docker-compose logs -f

# Execute commands in the container
docker-compose exec duo_universal_python_container_demo bash

# Restart the container
docker-compose restart
```