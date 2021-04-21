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
	tox

package: clean_dist
	python setup.py sdist

vulture:
	vulture module/

isort:
	isort -rc .

unused_imports:
	importchecker .

format: isort
	black .

export_reqs:
	pip-chill --no-version > requirements.txt

install_reqs:
	pip install pip --upgrade
	pip install -r requirements.txt --upgrade

install_jupyter:
	pip install jupyter
	pip install jupyter_contrib_nbextensions
	pip install jupyter_nbextensions_configurator
	jupyter contrib nbextension install --user
	jupyter nbextensions_configurator enable --user
	pip install autopep8
	pip install jupyterthemes
