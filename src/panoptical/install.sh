#!/bin/bash
set -e
# FIXME need to install pytest after dependsOn: python devcontainer property
# pip install pytest

cat > /usr/local/bin/panoptical \
<< EOF
#!/bin/sh
# pytest -s panoptical_test.py --spec ${SPEC}
EOF

chmod +x /usr/local/bin/panoptical
