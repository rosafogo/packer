.PHONY: all init prepare validate build run clean

all: init prepare validate build

init:
	packer init .

prepare:
	bash prepare.sh

validate:
	packer validate .

build:
	packer build .
	@echo ""
	@echo "✔ Imagem qcow2: outputs/ubuntu-lab-multiflora"
	@echo "  Suba a VM com: make run"

run:
	bash run-vm.sh

clean:
	rm -rf output-ubuntu-lab outputs http/user-data lab.auto.pkrvars.hcl