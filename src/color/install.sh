#!/bin/bash
set -e

echo "Activating feature 'color'"
echo "The provided favorite color is: ${FAVORITE}"


# The 'install.sh' entrypoint script is always executed as the root user.
#
# These following environment variables are passed in by the dev container CLI.
# These may be useful in instances where the context of the final 
# remoteUser or containerUser is useful.
# For more details, see https://containers.dev/implementors/features#user-env-var
echo "The effective dev container remoteUser is '$_REMOTE_USER'"
echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"

echo "The effective dev container containerUser is '$_CONTAINER_USER'"
echo "The effective dev container containerUser's home directory is '$_CONTAINER_USER_HOME'"

cat > /usr/local/bin/color \
<< EOF
#!/bin/sh
pytest -k ${FAVORITE}
EOF



# echo "Downloading the Latest Mojo Compiler"
# curl https://get.modular.com | sh - && modular auth buildAndTestMojoOSS
# modular install mojo
# BASHRC=$( [ -f "$HOME/.bash_profile" ] && echo "$HOME/.bash_profile" || echo "$HOME/.bashrc" )
# echo 'export MODULAR_HOME="/home/runner/.modular"' >> "$BASHRC"
# echo 'export PATH="/home/runner/.modular/pkg/packages.modular.com_mojo/bin:$PATH"' >> "$BASHRC"
# source "$BASHRC"

chmod +x /usr/local/bin/color
