.PHONY: all build test out clean

SHELL = /bin/bash

all: all_default all_base_volume all_cloud_init_multi_host all_main_volume  all_override

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
		--input-file test/integration/attributes/default/attrs.yml \
		--reporter=cli json:test-result-default-$$(date "+%Y.%m.%d-%H.%M.%S").json

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
		--input-file test/integration/attributes/base_volume/attrs.yml \
		--reporter=cli json:test-result-base_volume-$$(date "+%Y.%m.%d-%H.%M.%S").json

clean_deployment_base_volume:
	@pushd examples/base_volume; \
	terraform destroy -auto-approve; \
	popd

all_cloud_init_multi_host: build_cloud_init_multi_host test_cloud_init_multi_host clean_cloud_init_multi_host
build_cloud_init_multi_host: build_deployment_cloud_init_multi_host
test_cloud_init_multi_host: test_deployment_cloud_init_multi_host
clean_cloud_init_multi_host: clean_deployment_cloud_init_multi_host

build_deployment_cloud_init_multi_host:
	@pushd examples/cloud_init_multi_host; \
	terraform init; \
	terraform apply -auto-approve; \
	popd

test_deployment_cloud_init_multi_host:
	cinc-auditor exec test/integration/cloud_init_multi_host/ \
		--input-file test/integration/attributes/cloud_init_multi_host/attrs.yml \
		--reporter=cli json:test-result-cloud_init_multi_host-$$(date "+%Y.%m.%d-%H.%M.%S").json

clean_deployment_cloud_init_multi_host:
	@pushd examples/cloud_init_multi_host; \
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
		--input-file test/integration/attributes/main_volume/attrs.yml \
		--reporter=cli json:test-result-main_volume-$$(date "+%Y.%m.%d-%H.%M.%S").json

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
		--input-file test/integration/attributes/override/attrs.yml \
		--reporter=cli json:test-result-override-$$(date "+%Y.%m.%d-%H.%M.%S").json

clean_deployment_override:
	@pushd examples/override; \
	terraform destroy -auto-approve; \
	popd
