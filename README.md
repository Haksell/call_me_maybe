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

## constrained decosing

- the model produce logits for all tokens
- we identify which tokens would maintain both a valid json structure and compliance with the expected schema
- we set logits of invalid tokens to -infinity
- we sample from the valid tokens

## output

- [ ] your program will produce a single json file: `data/output/function_calling_results.json`.
- [ ] for each prompt, add a json object to this file. each object in the array must contain exactly the following keys:
    - prompt (string): the original natural-language request
    - name (string): the name of the function to call
    - parameters (object): all required arguments with the correct types

## validation rules

• the file must be valid json (no trailing commas, no comments)
• keys and types must match the schema in functions_definition.json exactly
• no extra keys or prose are allowed anywhere in the output
• all required arguments must be present
• argument types must match the function definition (number, string, boolean, etc.)

## performance and reliability

your implementation should achieve:
• near-perfect accuracy: 90%+ correct function selection and argument extraction
• 100% valid json: every output must be parseable and schema-compliant
• reasonable speed: process all test prompts in under 5 minutes on standard hardware
• robust error handling: gracefully handle malformed inputs, missing files, and edge cases

## repository

your repository must contain:
- src/ directory with your implementation
- pyproject.toml and uv.lock for dependency management
- llm_sdk/ directory (copied from the provided package)
- data/input/ directory with test files (for demonstration)
- readme.md with comprehensive documentation
- any additional files needed to run your solution
- do not include the output/ directory in your repository. it will be generated during the peer review

todo: fix .gitignore

## tests

1. ensure input files are in the data/input/ directory
2. run: `uv run python -m src [–functions_definition <function_definition_file>] [–input <input_file>] [–output <output_file>]`
3. check that `output/function_calling_results.json` is created
4. validate the json structure and content
5. verify function names and argument types match the definitions

test with various edge cases: empty strings, large numbers, special characters, wrong types, ambiguous prompts, and functions with multiple parameters.

## bonus

• support for multiple llm models beyond qwen/qwen3-0.6b
• recoding the tokenizer: avoiding direct use of encode and decode in the main code, instead using get_logits_from_input_ids and get_path_to_vocab_file
• advanced error recovery mechanisms
• performance optimizations (caching, batching)
• comprehensive test suite
• visualization of the generation process
• support for complex nested function arguments
• public implementation of tokenizer encode and optional decode methods
• demonstration of how encoding and decoding integrate with constrained decoding

## push check

- flake8
- mypy
- pydantic
- include docstrings in functions and classes following pep257 (e.g., google or numpy style) to document purpose, parameters, and returns.
- allowed libs: `json` (builtin), `numpy`
- clean this mess of a readme (follow subject rules)

## after push

- remove useless makefile rules
- reclean readme

## resources

- https://www.aidancooper.co.uk/constrained-decoding/