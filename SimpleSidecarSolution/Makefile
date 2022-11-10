all: enroll versions tf clean

enroll:
	echo Enrolling /identity_token_goes_here/dark_api_endpoint.jwt. If jwt is not in the correct folder, this step will fail.
	docker run --rm \
    --volume "${PWD}/identity_token_goes_here:/mnt" \
    openziti/quickstart \
    /openziti/ziti-bin/ziti edge enroll /mnt/dark_api_endpoint.jwt

terraform:
	terraform -chdir=./terraform init
	terraform -chdir=./terraform apply

clean:
	rm identity_token_goes_here/dark_api_endpoint.json

versions:
	aws --version
	aws sts get-caller-identity
	terraform --version
