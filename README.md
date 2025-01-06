# Aibox

## Project Description
Aibox is a comprehensive solution designed to integrate various services such as JupyterHub, Rocket.Chat, Mattermost, Heimdall, Flowise, Langflow, Ollama, and Portainer into a single platform. It aims to provide a seamless experience for managing and utilizing these services. This project is ideal for developers, data scientists, and IT administrators who need a unified environment for their tools and services.

## Prerequisites
Before you begin, ensure you have met the following requirements:
- You have a Linux machine (Ubuntu recommended).
- You have Docker and Docker Compose installed.
- You have `git` installed.
- You have an NVIDIA GPU with drivers installed.
- You have NVIDIA Docker and NVIDIA Container Toolkit installed.

## Installation
To install the project, follow these steps:
1. Clone the repository:
    ```bash
    git clone https://github.com/techneguru/aibox.git
    ```
2. Navigate to the project directory:
    ```bash
    cd aibox
    ```
3. Run the setup script:
    ```bash
    ./setup_server.sh
    ```

4. Verify NVIDIA Docker installation:
    ```bash
    sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
    ```

## How to Run the Script
To run the setup script, follow these steps:
1. Ensure you have met all the prerequisites mentioned above.
2. Open a terminal and navigate to the project directory:
    ```bash
    cd aibox
    ```
3. Make the setup script executable (if not already):
    ```bash
    chmod +x setup_server.sh
    ```
4. Run the setup script:
    ```bash
    ./setup_server.sh
    ```

## Usage
To start the project, run:
```bash
docker-compose up -d
```

For more detailed usage instructions, refer to the documentation.

## Initial Logon Information
| Service      | URL                        | Port | Username   | Password     |
|--------------|----------------------------|------|------------|--------------|
| JupyterHub   | http://aibox.local/jupyter | 8000 | adminuser  | supersecret  |
| Rocket.Chat  | http://aibox.local/rocket  | 3000 | admin      | admin        |
| Mattermost   | http://aibox.local/mattermost | 8065 | mmuser  | mmuser_password |
| Heimdall     | http://aibox.local/heimdall | 8090 | admin     | admin        |
| Flowise      | http://aibox.local/flowise | 9000 | admin     | admin        |
| Langflow     | http://aibox.local/langflow | 8501 | admin     | admin        |
| Ollama       | http://aibox.local/ollama  | 9100 | admin      | admin        |
| Portainer    | http://aibox.local:9000    | 9000 | admin      | admin        |

## Contributing
To contribute to Aibox, follow these steps:
1. Fork this repository.
2. Create a branch: 
    ```bash
    git checkout -b <branch_name>
    ```
3. Make your changes and commit them:
    ```bash
    git commit -m '<commit_message>'
    ```
4. Push to the original branch:
    ```bash
    git push origin <branch_name>
    ```
5. Create the pull request.

Alternatively, see the GitHub documentation on [creating a pull request](https://help.github.com/articles/creating-a-pull-request/).

## License
This project is licensed under the MIT License - see the LICENSE file for details.