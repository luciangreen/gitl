#!/usr/bin/env bash

# chmod +x ./luciancicd.sh
# ./luciancicd.sh my_repo_name "Description of changes."

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
GITHUB2O_DIR="${DROPBOX}/GitHub2o/${REP_NAME}"

LUCIANCICD_DIR="${DROPBOX}/GitHub/luciancicd/"
LUCIANCICD_PL="luciancicd.pl"
GITL_PL="${DROPBOX}/GitHub/gitl/gitl.pl"

# ..gitl_data/<rep_name>/n.txt → we'll interpret as:
GITL_DATA_BASE="${DROPBOX}/GitHub/gitl_data"
GITL_DATA_REPO_DIR="${GITL_DATA_BASE}/${REP_NAME}"
N_FILE="${GITL_DATA_REPO_DIR}/n.txt"

MAIN_FILE="${GITL_TEST_DIR}/main_file.txt"

echo "==================================================================="
echo " Lucian CI/CD + GitL notes"
echo "==================================================================="
echo "1. If Lucian CI/CD could create two versions of a repository because"
echo "   it has two or more first predicates, then a NEW first predicate"
echo "   should be written that can call either of them (a dispatcher)."
echo
echo "2. People should write the DATE in the commit description, e.g.:"
echo "      \"2025-11-22 – Fixed parser and updated docs.\""
echo
echo "3. When multiple repositories are connected, treat them as a SINGLE"
echo "   logical repository by using a single calling predicate that calls"
echo "   into the connected repos in a controlled way."
echo
echo "4. This version of Lucian CI/CD naively assumes the user controls ALL"
echo "   repositories that their repository uses. Otherwise, any external"
echo "   repo-like folders should be EXCLUDED from being saved (e.g. not"
echo "   copied to gitl_data). In that case, the user would download these"
echo "   imported folders locally but not necessarily change them."
echo "===========================================
========================"
echo

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

echo
echo "=== Step 1: Copy gitl_test repo → GitHub2 working copy ==="

mkdir -p "${GITHUB2_DIR}"
rm -rf "${GITHUB2_DIR:?}/"*
cp -a "${GITL_TEST_DIR}/." "${GITHUB2_DIR}/"

echo "Copied contents from:"
echo "  ${GITL_TEST_DIR} → ${GITHUB2_DIR}"

echo
echo "=== Step 2: Update LPPM registry with repository dependencies (placeholder) ==="
echo ">> TODO: Insert your actual LPPM registry update command here."
echo "For example:"
echo "  swipl -q -s path/to/lppm_registry.pl -g \"update_lppm_registry('${REP_NAME}')\" -t halt"
echo "(Currently this step does nothing.)"
echo

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
echo "=== Step 4: Replace gitl_test contents with changed code from GitHub2o ==="

if [ ! -d "${GITHUB2O_DIR}" ]; then
  echo "ERROR: Changed-code directory not found:"
  echo "  ${GITHUB2O_DIR}"
  echo "luciancicd probably did not populate GitHub2o as expected."
  exit 1
fi

# Clear gitl_test and copy from GitHub2o
rm -rf "${GITL_TEST_DIR:?}/"*
cp -a "${GITHUB2O_DIR}/." "${GITL_TEST_DIR}/"

echo "Updated gitl_test contents from:"
echo "  ${GITHUB2O_DIR} → ${GITL_TEST_DIR}"

echo
echo "=== Step 4.5: Check gitl_data baseline vs finished GitHub2o code ==="
echo "Rule: only commit if ..gitl_data/<rep_name>/<n>/* differs from GitHub2o/<rep_name>/*."

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

echo "Baseline version n = ${N_VALUE}"
echo "Baseline dir: ${BASELINE_DIR}"
echo "Finished (changed) code dir: ${GITHUB2O_DIR}"

# Compare baseline vs *changed* code in GitHub2o
if diff -qr "${BASELINE_DIR}" "${GITHUB2O_DIR}" >/dev/null 2>&1; then
  echo "No differences between baseline (${BASELINE_DIR}) and changed code (${GITHUB2O_DIR})."
  echo "Skipping gitl commit because code is effectively the same as baseline."
  exit 0
else
  echo "Differences detected between baseline and changed code."
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