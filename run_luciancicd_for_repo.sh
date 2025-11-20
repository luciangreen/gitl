#!/usr/bin/env bash

# chmod +x ./run_luciancicd_for_repo.sh
# ./run_luciancicd_for_repo.sh my_repo_name "Description of changes."

set -euo pipefail

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <rep_name> \"Description of changes.\""
  exit 1
fi

REP_NAME="$1"
DESCRIPTION="$2"

# Adjust this if your Dropbox path is different
DROPBOX="${HOME}/Dropbox"

GITL_TEST_DIR="${DROPBOX}/GitHub/gitl_test/${REP_NAME}"
GITHUB2_DIR="${DROPBOX}/GitHub2/${REP_NAME}"
LUCIANCICD_DIR="${DROPBOX}/GitHub/luciancicd/"
LUCIANCICD_PL="luciancicd.pl"
GITL_PL="${DROPBOX}/GitHub/gitl/gitl.pl"

MAIN_FILE="${GITL_TEST_DIR}/main_file.txt"

GITL_DATA_BASE="${DROPBOX}/GitHub/gitl_data"
GITL_DATA_REPO_DIR="${GITL_DATA_BASE}/${REP_NAME}"
N_FILE="${GITL_DATA_REPO_DIR}/n.txt"

echo "=== Step 0: Ensure main_file.txt exists and is correct ==="
if [ ! -f "${MAIN_FILE}" ]; then
  cat <<EOF
main_file.txt is missing at:
  ${MAIN_FILE}

Please create this file with **one line** containing the first predicate name
and arity, for example:

  my_first_predicate/2

Then re-run this script.
EOF
  exit 1
else
  echo "Found main_file.txt at ${MAIN_FILE}."
  echo "Contents:"
  cat "${MAIN_FILE}" || true
  echo
  echo "If this is not the correct first predicate name/arity, abort now (Ctrl+C) and fix it."
  sleep 2
fi

echo "=== Step 1: Copy gitl_test repo → GitHub2 working copy ==="

mkdir -p "${GITHUB2_DIR}"
# Clear existing contents of GitHub2 working dir (but not the dir itself)
rm -rf "${GITHUB2_DIR:?}/"*
# Copy everything from gitl_test to GitHub2
cp -a "${GITL_TEST_DIR}/." "${GITHUB2_DIR}/"

echo "Copied contents from:"
echo "  ${GITL_TEST_DIR} → ${GITHUB2_DIR}"

echo
echo "=== Step 2: Update LPPM registry with repository dependencies (placeholder) ==="
echo ">> TODO: Insert your actual LPPM registry update command here."
echo "For example, you might call a Prolog script such as:"
echo "  swipl -q -s path/to/lppm_registry.pl -g \"update_lppm_registry('${REP_NAME}')\" -t halt"
echo "Currently this step is a NO-OP."
echo

# Example (commented out) if you have such a script:
# swipl -q -s "${DROPBOX}/GitHub/lppm_registry/lppm_registry.pl" \
#      -g "update_lppm_registry('${REP_NAME}')" \
#      -t halt

LUCIANCICD_PATH="${LUCIANCICD_DIR}""${LUCIANCICD_PL}"
echo "=== Step 3: Run Lucian CI/CD ==="
if [ ! -f "${LUCIANCICD_PATH}" ]; then
  echo "ERROR: luciancicd.pl not found at: ${LUCIANCICD_PATH}"
  exit 1
fi

# Assumes luciancicd.pl defines a predicate luciancicd/0
echo "Running luciancicd/0 from ${LUCIANCICD_PL} ..."
cd "${LUCIANCICD_DIR}"
swipl -q -s "${LUCIANCICD_PL}" -g luciancicd -t halt
echo "Lucian CI/CD run completed."

echo
echo "=== Step 4: Replace gitl_test contents with updated GitHub2 contents ==="
# Remove all contents in gitl_test repo
rm -rf "${GITL_TEST_DIR:?}/"*
# Copy back from GitHub2 to gitl_test
cp -a "${GITHUB2_DIR}/." "${GITL_TEST_DIR}/"

echo "Updated gitl_test contents from:"
echo "  ${GITHUB2_DIR} → ${GITL_TEST_DIR}"

echo
echo "=== Step 4.5: Check gitl_data baseline before committing ==="

if [ ! -f "${N_FILE}" ]; then
  echo "WARNING: n.txt not found at ${N_FILE}"
  echo "Skipping commit, because no baseline version is defined."
  exit 0
fi

N_VALUE="$(tr -d ' \t\r\n' < "${N_FILE}")"

if [ -z "${N_VALUE}" ]; then
  echo "WARNING: n.txt at ${N_FILE} is empty."
  echo "Skipping commit, because no baseline version is defined."
  exit 0
fi

BASELINE_DIR="${GITL_DATA_REPO_DIR}/${N_VALUE}"

if [ ! -d "${BASELINE_DIR}" ]; then
  echo "WARNING: Baseline directory ${BASELINE_DIR} does not exist."
  echo "Skipping commit, because baseline version ${N_VALUE} is missing."
  exit 0
fi

echo "Baseline version: n = ${N_VALUE}"
echo "Baseline dir: ${BASELINE_DIR}"
echo "New code dir: ${GITHUB2_DIR}"

# Compare baseline vs finished code
if diff -qr "${BASELINE_DIR}" "${GITHUB2_DIR}" >/dev/null 2>&1; then
  echo "No differences between baseline (${BASELINE_DIR}) and finished code (${GITHUB2_DIR})."
  echo "Skipping gitl commit because code is effectively the same as baseline."
  exit 0
else
  echo "Differences detected between baseline and finished code."
  echo "Proceeding to gitl commit."
fi

echo
echo "=== Step 5: Run gitl commit/2 ==="
if [ ! -f "${GITL_PL}" ]; then
  echo "ERROR: gitl.pl not found at: ${GITL_PL}"
  exit 1
fi

echo "Running commit('${REP_NAME}', '${DESCRIPTION}') in gitl.pl ..."
swipl -q -s "${GITL_PL}" \
      -g "commit('${REP_NAME}', '${DESCRIPTION}')" \
      -t halt || {
  echo "gitl commit/2 failed (possibly because there were no changes)."
  exit 1
}

echo "gitl commit/2 completed successfully."
echo "=== Workflow finished for repo: ${REP_NAME} ==="