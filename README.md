# Apache Instrumentation on RHEL with AppDynamics

This project demonstrates how to instrument a Red Hat Enterprise Linux (RHEL) Apache base image with the AppDynamics Apache agent.

## Prerequisites

- **Docker**: Ensure Docker is installed and running on your system. For installation instructions, refer to the [Docker documentation](https://docs.docker.com/get-docker/).
- **AppDynamics Account**: Obtain the necessary credentials and access to download the AppDynamics Apache agent. Visit the [AppDynamics website](https://www.appdynamics.com/) for more information.

## Project Structure

- `Dockerfile`: Defines the Docker image build process, including the installation of Apache and the AppDynamics agent.
- `appdynamics_agent.conf`: Configuration file for the AppDynamics Apache agent.
- `build-run.sh`: Shell script to build the Docker image and run the container.
- `load.sh`: Shell script to simulate load on the Apache server for testing purposes.
- `index.html`: A simple HTML file served by the Apache server.

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/mithun100/Apache_Instrumentation_RHEL.git
cd Apache_Instrumentation_RHEL
```

### 2. Download the AppDynamics Apache Agent

- Download the AppDynamics Apache agent from the [AppDynamics Downloads](https://download.appdynamics.com/) page.
- Place the downloaded agent file in the `Apache_Instrumentation_RHEL` directory.
- Change the line in Dockerfile as per the downloaded agent name

```bash
#Copy the agent files
COPY ./appdynamics-sdk-native-nativeWebServer-64bit-linux-24.11.0.2449.tgz ./
```

### 3. Build and Run the Docker Image

- Ensure the `build-run.sh` script has execute permissions:

```bash
chmod +x build-run.sh
```

- Execute the script to build the Docker image and run the container:

```bash
./build-run.sh
```

This script will:
- Build the Docker image using the provided `Dockerfile`.
- Start a Docker container from the built image.
- Install the AppDynamics Apache agent within the container.
- Start the Apache server with the AppDynamics agent configured.

### 4. Access the Apache Server

- Open your web browser and navigate to `http://localhost:8080` to access the Apache server.

### 5. Simulate Load for Testing

- Ensure the `load.sh` script has execute permissions:

```bash
chmod +x load.sh
```

- Execute the script to simulate load on the Apache server:

```bash
./load.sh
```

This script will send multiple requests to the Apache server to generate traffic, which can be monitored via AppDynamics.

### 6. Monitor with AppDynamics

- Log in to your AppDynamics controller dashboard.
- Navigate to the appropriate application tier to view metrics and ensure that the Apache agent is reporting data correctly.

## Notes

- The `appdynamics_agent.conf` file contains the configuration settings for the AppDynamics Apache agent. Ensure that the `Controller`, `Application`, and `Tier` settings are correctly configured to match your AppDynamics environment.
- The `index.html` file is a simple web page served by the Apache server. You can customize this file as needed.
- The `load.sh` script uses `curl` to generate load on the server. Ensure that `curl` is installed on your system.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
