#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CASK_FILE="${SCRIPT_DIR}/Casks/claude-code.rb"
GCS_BASE="https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases"

VERSION=$(curl -fsSL "${GCS_BASE}/latest")
echo "Versão mais recente: ${VERSION}"

CURRENT=$(grep 'version "' "${CASK_FILE}" | head -1 | sed 's/.*version "\(.*\)".*/\1/')
if [ "${VERSION}" = "${CURRENT}" ]; then
  echo "Já está na versão ${VERSION}. Nenhuma atualização necessária."
  exit 0
fi

MANIFEST=$(curl -fsSL "${GCS_BASE}/${VERSION}/manifest.json")

ARM64=$(echo "${MANIFEST}"  | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['platforms']['darwin-arm64']['checksum'])")
X64=$(echo "${MANIFEST}"    | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['platforms']['darwin-x64']['checksum'])")
LARM=$(echo "${MANIFEST}"   | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['platforms']['linux-arm64']['checksum'])")
LX64=$(echo "${MANIFEST}"   | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['platforms']['linux-x64']['checksum'])")

sed -i "" \
  -e "s/version \"[0-9.]*\"/version \"${VERSION}\"/" \
  -e "s/arm:          \"[a-f0-9]*\"/arm:          \"${ARM64}\"/" \
  -e "s/x86_64:       \"[a-f0-9]*\"/x86_64:       \"${X64}\"/" \
  -e "s/arm64_linux:  \"[a-f0-9]*\"/arm64_linux:  \"${LARM}\"/" \
  -e "s/x86_64_linux: \"[a-f0-9]*\"/x86_64_linux: \"${LX64}\"/" \
  "${CASK_FILE}"

echo "Atualizado de ${CURRENT} para ${VERSION}"
echo "SHA256 darwin-arm64:  ${ARM64}"
echo "SHA256 darwin-x64:    ${X64}"
echo "SHA256 linux-arm64:   ${LARM}"
echo "SHA256 linux-x64:     ${LX64}"
