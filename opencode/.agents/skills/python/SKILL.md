---
name: python
description: Python - a general purpose programming language
---

# Python

## Project Setup

Use `uv` for managing dependencies.
`uv sync` creates the `.venv` directory that has all the dependencies in it.

### Tools

You can use `uv` to execute tools.

For static analysis, use `uv run mypy .`
For testing, use `uv run pytest`
For formatting, use `uvx black .`
For linting, use `uvx ruff check`
For lsp warnings, use `npx pyright --python-interpreter .venv/bin/python`

After making changes, make sure all the above tools pass.

### Executing

For executing any script, use `uv run <script>`

