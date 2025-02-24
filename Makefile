install_pip:
	# create venv
	python -m venv venv
	# activate venv
	. venv/bin/activate
	# install requirements
	pip install -e .
	# install bitsandbytes
	pip install bitsandbytes==0.45.0