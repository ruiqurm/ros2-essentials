# Repository Guidelines

## Project Structure & Module Organization
The repository centers on multiple ROS 2 workspaces under directories suffixed with `_ws` (for example `template_ws`, `husky_ws`). Each workspace provides `docker/` for container orchestration, `src/` for ROS packages, and optional `docs/` for workspace-specific notes. Shared automation lives in `scripts/`, documentation sources in `docs/`, reusable Docker fragments in `docker_modules/`, and quality checks in `tests/`. When adding new modules, mirror the layout used in `template_ws` so lint checks in `tests/diff_base/` stay aligned.

## Build, Test, and Development Commands
Run `./scripts/post_install.sh` after cloning or pulling; it re-links shared files and should also be used with `-f` when switching branches. Develop inside a workspace’s container: `cd template_ws/docker && docker compose up --build` launches the environment with the latest image, while `docker compose pull` grabs pre-built images to save build time. Use `./scripts/create_workspace.sh your_ws` to bootstrap additional workspaces from the template.

## Coding Style & Naming Conventions
Follow the formatting patterns already present: Python and shell scripts use 4-space indentation, YAML/Compose files use 2 spaces, and environment variables remain uppercase with underscores. Keep filenames kebab-case unless ROS tooling enforces otherwise, and align new workspace assets with the templates enforced by `tests/lint_comp_template.py`. Prefer descriptive package names that match ROS 2 conventions (`<robot>_<capability>`).

## Testing Guidelines
Execute `./tests/test_all.sh` before proposing changes; it runs the repository lint suite (`lint_compose.py`, `lint_dockerfile.py`, etc.) to ensure every workspace stays in sync with the template. Add workspace-specific tests under the relevant `*_ws/src/` package and document how to run them inside that workspace’s README. Strive for meaningful coverage of launch files and Docker changes by exercising them in their containerized environment.

## Commit & Pull Request Guidelines
Use Conventional Commit subjects (`feat: add husky teleop module`, `fix: resolve docker compose env mismatch`) and keep commits focused. Reference supporting documentation or upstream sources in the body when importing code. Open a GitHub issue before large changes, link it in your PR, and include evidence that `./tests/test_all.sh` passed plus screenshots or logs for user-facing changes. Avoid force-pushing once reviews start; coordinate revisions through follow-up commits.

## Environment & Configuration Tips
Ensure your host shell exports `USER_UID=$(id -u)` when working with containers so file permissions match. Clean stale Compose artifacts with `docker compose down --volumes --remove-orphans` inside each workspace’s `docker/` directory, and prune shared volumes such as `ros2-gazebo-cache` only when no workspace depends on them.
