run:
	uv run main.py

# TODO: check
install:
	uv sync

clean:
	rm -rf .venv
	rm -rf *.zip
	rm -rf data

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

# TODO: debug rule (pdb)

.PHONY: run install clean debug lint lint-strict get-data
