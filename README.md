# SquareCode

## Overview

This project is a web application designed to create QR codes for any URL. It provides a user-friendly interface for generating QR codes quickly and efficiently, making it ideal for personal or professional use.

## Prerequisites

> [!IMPORTANT]
>
> - Docker
> - Docker Compose

## User Interface (UI)

| <a href="https://www.robertovicario.com/SquareCode"><img src="./docs/cover.png" alt="UI" width="384"></a> |
| :-: |
| **Home - SquareCode** |

## Instructions

Usage:

```sh
bash cmd.sh {start|stop|setup|clear}
```

### `setup`

If you haven't built the project yet, you can do so by running:

```sh
bash cmd.sh setup
```

To run in detached mode, use:

```sh
bash cmd.sh setup -d
```

Once the setup process is complete, the project will be accessible at `localhost:8999`.

> [!WARNING]
>
> If this port is already in use, search for all occurrences of `8999` within the project and replace them with your preferred port number. After making these changes, you'll need to rebuild the project for the modifications to take effect.

### `start`

The program will run in debug mode, meaning frontend changes will be rendered upon reload. However, if you make changes to the backend, you will need to restart the program by running:

```sh
bash cmd.sh start
```

To run in detached mode, use:

```sh
bash cmd.sh start -d
```

### `stop`

To stop the program, simply run:

```sh
bash cmd.sh stop
```

> [!TIP]  
> For a quicker way to stop, use `ctrl + C` to force stop the program.

### `clear`

If you need to clear all containers and their orphaned dependencies, you can run:

```sh
bash cmd.sh clear
```

## License

This project is distributed under [GNU General Public License version 3](https://opensource.org/license/gpl-3-0). You can find the complete text of the license in the project repository.
