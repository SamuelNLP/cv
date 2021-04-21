# some common operations

clean_dist:
	rm -rf dist *.egg-info

clean_tests:
	rm -rf .pytest_cache .tox
	py3clean .

clean_mypy:
	rm -rf .mypy_cache

clean_notebooks:
	rm -rf .ipynb_checkpoints

clean: clean_dist clean_mypy clean_tests clean_notebooks

clean_pip:
	pip freeze | xargs pip uninstall -y

test:
	pytest -n 4 -p no:cacheprovider

package: clean_dist
	python setup.py sdist

vulture:
	vulture module/

isort:
	isort .

format: isort
	black .

export_reqs:
	pip-chill --no-version > requirements.txt

install_reqs:
	pip install pip --upgrade
	pip install -r requirements.txt --upgrade

install_jupyter:
	pip install jupyter

reinstall_pip: clean_pip install_reqs
