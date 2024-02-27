#!/bin/bash
set -e

cat > /usr/local/bin/panoptical \
<< EOF
#!/bin/sh
# pytest -k ${SPEC}
EOF

chmod +x /usr/local/bin/panoptical
