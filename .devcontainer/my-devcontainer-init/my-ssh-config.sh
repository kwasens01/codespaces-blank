#!/bin/bash
##
## xref: vscode-dev-containers/sshd.md at main · microsoft/vscode-dev-containers
##  https://github.com/microsoft/vscode-dev-containers/blob/main/script-library/docs/sshd.md#usage-when-this-script-is-already-installed-in-an-image

sudo passwd $(whoami)
