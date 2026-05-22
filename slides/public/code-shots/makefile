help: ## show this help
	@sed -ne "s/^##\(.*\)/\1/p" $(MAKEFILE_LIST)
	@printf "────────────────────────`tput bold``tput setaf 2` Make Commands `tput sgr0`────────────────────────────────\n"
	@sed -ne "/@sed/!s/\(^[^#?=]*:\).*##\(.*\)/`tput setaf 2``tput bold`\1`tput sgr0`\2/p" $(MAKEFILE_LIST)
	@printf "────────────────────────`tput bold``tput setaf 4` Make Variables `tput sgr0`───────────────────────────────\n"
	@sed -ne "/@sed/!s/\(.*\)?=\(.*\)##\(.*\)/`tput setaf 4``tput bold`\1:`tput setaf 5`\2`tput sgr0`\3/p" $(MAKEFILE_LIST)
	@printf "───────────────────────────────────────────────────────────────────────\n"

# remove if you want another default.
.DEFAULT_GOAL := help

CC := freeze --config user.json


piphany-hello.svg: piphany-hello.scm user.json
	${CC} $< -o $@ 

piphany-hello-config.svg: piphany-hello-config.scm user.json
	${CC} $< -o $@

piphany-hello-file.svg: piphany-hello-file.scm user.json
	${CC} $< -o $@

nix-support.svg: nix-support.scm user.json
	${CC} $< -o $@

metadata.svg: metadata.scm user.json
	${CC} $< -o $@

test.svg: test.scm user.json
	${CC} $< -o $@

all: piphany-hello.svg piphany-hello-config.svg piphany-hello-file.svg nix-support.svg metadata.svg test.svg
