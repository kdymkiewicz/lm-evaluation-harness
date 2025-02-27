install_pip:
	# create venv
	python -m venv venv
	# activate venv
	source venv/bin/activate
	# install requirements
	pip install -e .
	# install bitsandbytes
	pip install bitsandbytes==0.45.2
	# install hf cli
	pip install -U "huggingface_hub[cli]"
	# install wandb
	pip install wandb

wandb_login:
	wandb login

hf_login:
	huggingface-cli login