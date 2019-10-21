run:
	docker run \
		--name vault \
		--restart unless-stopped \
		-d \
		--cap-add=IPC_LOCK \
		-p 8200:8200 \
		-v /opt/containers/vault/config:/vault/config \
		-v /opt/containers/vault/file:/vault/file \
		bovee.io/vault server

stop:
	docker stop vault
	docker rm vault

unseal:
	@vault operator unseal $(shell cat secrets.json | jq -r .one)
	@vault operator unseal $(shell cat secrets.json | jq -r .two)
	@vault operator unseal $(shell cat secrets.json | jq -r .three)


sleep:
	sleep 10

all: stop run sleep unseal