run:
	uv run main.py

# TODO: check
install:
	uv sync

clean:
	rm -rf .venv *.zip data llm_sdk

lint:
	flake8 .
	mypy . --warn-return-any --warn-unused-ignores --ignore-missing-imports --disallow-untyped-defs --check-untyped-defs

lint-strict:
	flake8 .
	mypy . --strict

get-data:
	wget https://cdn.intra.42.fr/document/document/55016/data.zip -O data.zip
	unzip -o data.zip
	rm data.zip

get-llm-sdk:
	wget https://cdn.intra.42.fr/document/document/55017/llm_sdk.zip -O llm_sdk.zip
	unzip -o llm_sdk.zip
	rm llm_sdk.zip

# TODO: debug rule (pdb)

setup: install get-data get-llm-sdk

.PHONY: run install clean debug lint lint-strict get-data get-llm-sdk setup
