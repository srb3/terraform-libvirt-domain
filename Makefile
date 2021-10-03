.PHONY: all build test out clean

SHELL = /bin/bash

all: all_default all_base_volume all_cloud_init all_main_volume  all_override

all_default: build_default test_default clean_default
build_default: build_deployment_default
test_default: test_deployment_default
clean_default: clean_deployment_default

build_deployment_default:
	@pushd examples/default; \
	terraform init; \
	terraform apply -auto-approve; \
	popd

test_deployment_default:
	cinc-auditor exec test/integration/default/ \
		-t ssh://cloud@libvirthost -i ~/.ssh/id_rsa \
		--input-file test/integration/default/attrs.yml

clean_deployment_default:
	@pushd examples/default; \
	terraform destroy -auto-approve; \
	popd

all_base_volume: build_base_volume test_base_volume clean_base_volume
build_base_volume: build_deployment_base_volume
test_base_volume: test_deployment_base_volume
clean_base_volume: clean_deployment_base_volume

build_deployment_base_volume:
	@pushd examples/base_volume; \
	terraform init; \
	terraform apply -auto-approve; \
	popd

test_deployment_base_volume:
	cinc-auditor exec test/integration/base_volume/ \
		-t ssh://cloud@ubuntu-commonbase -i ~/.ssh/id_rsa \
		--input-file test/integration/base_volume/attrs.yml

clean_deployment_base_volume:
	@pushd examples/base_volume; \
	terraform destroy -auto-approve; \
	popd

all_cloud_init: build_cloud_init test_cloud_init clean_cloud_init
build_cloud_init: build_deployment_cloud_init
test_cloud_init: test_deployment_cloud_init
clean_cloud_init: clean_deployment_cloud_init

build_deployment_cloud_init:
	@pushd examples/cloud_init; \
	terraform init; \
	terraform apply -auto-approve; \
	popd

test_deployment_cloud_init:
	cinc-auditor exec test/integration/cloud_init/ \
		-t ssh://jdoe@ubuntu-0 -i ~/.ssh/id_rsa \
		--input-file test/integration/cloud_init/attrs.yml \
		--no-backend-cache --sudo

clean_deployment_cloud_init:
	@pushd examples/cloud_init; \
	terraform destroy -auto-approve; \
	popd

all_main_volume: build_main_volume test_main_volume clean_main_volume
build_main_volume: build_deployment_main_volume
test_main_volume: test_deployment_main_volume
clean_main_volume: clean_deployment_main_volume

build_deployment_main_volume:
	@pushd examples/main_volume; \
	terraform init; \
	terraform apply -auto-approve; \
	popd

test_deployment_main_volume:
	cinc-auditor exec test/integration/main_volume/ \
		-t ssh://cloud@ubuntu-mainvol -i ~/.ssh/id_rsa \
		--input-file test/integration/main_volume/attrs.yml

clean_deployment_main_volume:
	@pushd examples/main_volume; \
	terraform destroy -auto-approve; \
	popd

all_override: build_override test_override clean_override
build_override: build_deployment_override
test_override: test_deployment_override
clean_override: clean_deployment_override

build_deployment_override:
	@pushd examples/override; \
	terraform init; \
	terraform apply -auto-approve; \
	popd

test_deployment_override:
	cinc-auditor exec test/integration/override/ \
		-t ssh://msmith@centos-domain -i ~/.ssh/id_rsa \
		--input-file test/integration/override/attrs.yml

clean_deployment_override:
	@pushd examples/override; \
	terraform destroy -auto-approve; \
	popd
