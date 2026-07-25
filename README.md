# call_me_maybe

## general rules

- [ ] makefile
- [ ] pytest
- [ ] all classes must use pydantic for validation
- [ ] model: `Qwen/Qwen3-0.6B` (and optionally more)
- [ ] The function to call should be chosen using the LLM, not with heuristics or any other sort of medieval magic.
- [ ] It is forbidden to use any private methods or attributes from the llm_sdk package.
- [ ] You should create a virtual environment and install the packages numpy and pydantic using uv. To use llm_sdk, you can copy it in the same directory as the one src is in.
- [ ] The reviewer, as well as the moulinette, will just run uv sync.

## usage

- `uv run python -m src [--functions_definition <function_definition_file>] [--input <input_file>] [--output <output_file>]`
- By default, the program will read input files from the `data/input/` directory and write output to the `data/output/` directory. You can optionally specify custom paths using the `--input` and `--output` arguments.
- For example:
```console
$ uv run python -m src
    --functions_definition data/input/functions_definition.json
    --input data/input/function_calling_tests.json
    --output data/output/function_calls.json
```

## push check

- flake8
- mypy
- pydantic
- include docstrings in functions and classes following PEP 257 (e.g., Google or NumPy style) to document purpose, parameters, and returns.
- allowed libs: `json` (builtin), `numpy`
- clean this mess of a readme

## after push

- remove useless makefile rules
- reclean readme