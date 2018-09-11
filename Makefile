PLAYBOOK ?= main
CHECK ?=
VERBOSE ?=
TAGS ?=
ANSIBLE_OPTS ?=
ROOT ?=

$(if ${CHECK},   $(eval ANSIBLE_OPTS += --check))
$(if ${VERBOSE}, $(eval ANSIBLE_OPTS += -${VERBOSE}))
$(if ${TAGS},    $(eval ANSIBLE_OPTS += --tags ${TAGS}))

setup:
	$(eval ANSIBLE_OPTS += --vault-password-file vaulted_vars/system.txt)
	$(if ${ROOT},    $(eval ANSIBLE_OPTS += -e "ansible_user=root ansible_port=22"))
	ansible-playbook playbooks/setup.yml --diff --ask-become-pass ${ANSIBLE_OPTS}

deploy:
	$(eval ANSIBLE_OPTS += --vault-password-file vaulted_vars/system.txt)
	ansible-playbook playbooks/${PLAYBOOK}.yml --diff --ask-become-pass ${ANSIBLE_OPTS}

deploy-vagrant:
	VERBOSE=${VERBOSE} TAGS=${TAGS} vagrant provision

edit-vault:
	$(eval VAULT = vaulted_vars/system.yml)
	$(eval ANSIBLE_OPTS += --vault-password-file vaulted_vars/system.txt)
	ansible-vault edit ${VAULT} ${ANSIBLE_OPTS}
