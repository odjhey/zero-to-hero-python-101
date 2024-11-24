import toml
import sys
import os


def update_pyproject_toml(project_name):
    """Update pyproject.toml to add the watch script."""
    pyproject_path = "pyproject.toml"

    if not os.path.exists(pyproject_path):
        print(f"Error: {pyproject_path} not found.")
        sys.exit(1)

    with open(pyproject_path, "r") as f:
        config = toml.load(f)

    # Add the watch script
    config["tool"]["poetry"]["scripts"] = config["tool"]["poetry"].get("scripts", {})
    config["tool"]["poetry"]["scripts"]["watch"] = f"{project_name}:watch"

    with open(pyproject_path, "w") as f:
        toml.dump(config, f)

    print(f"Updated {pyproject_path} with the watch script.")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: update_pyproject_toml.py <sanitized_project_name>")
        sys.exit(1)

    sanitized_project_name = sys.argv[1]
    update_pyproject_toml(sanitized_project_name)
