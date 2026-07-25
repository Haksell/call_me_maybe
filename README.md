# call_me_maybe

## general rules

- [ ] makefile
- [ ] pytest
- [ ] all classes must use pydantic for validation
- [ ] model: `qwen/qwen3-0.6b` (and optionally more)
- [ ] the function to call should be chosen using the llm, not with heuristics or any other sort of medieval magic.
- [ ] it is forbidden to use any private methods or attributes from the llm_sdk package.
- [ ] you should create a virtual environment and install the packages numpy and pydantic using uv. to use llm_sdk, you can copy it in the same directory as the one src is in.
- [ ] the reviewer, as well as the moulinette, will just run uv sync.

## usage

- `uv run python -m src [--functions_definition <function_definition_file>] [--input <input_file>] [--output <output_file>]`
- by default, the program will read input files from the `data/input/` directory and write output to the `data/output/` directory. you can optionally specify custom paths using the `--input` and `--output` arguments.
- for example:
```console
$ uv run python -m src
  --functions_definition data/input/functions_definition.json
  --input data/input/function_calling_tests.json
  --output data/output/function_calls.json
```

## mandatory part

- [ ] given a question like "what is the sum of 40 and 2?", your solution should not return 42, but instead provide:
  - [ ] the function name: fn_add_numbers
  - [ ] the arguments: {"a": 40, "b": 2}
- [ ] your implementation must use constrained decoding to guarantee 100% valid json output, ensuring near-perfect reliability even with a small 0.6b parameter model.
- [ ] you must implement proper json error handling for input files, as they may contain invalid json or be missing entirely.

## the generation pipeline

- prompt
- tokenization (using bpe or sentencepiece)
- input ids
- llm processing
- logits
- token selection (usually just max but here we'll use constrained decoding)

## push check

- flake8
- mypy
- pydantic
- include docstrings in functions and classes following pep257 (e.g., google or numpy style) to document purpose, parameters, and returns.
- allowed libs: `json` (builtin), `numpy`
- clean this mess of a readme

## after push

- remove useless makefile rules
- reclean readme