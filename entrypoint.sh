#!/usr/bin/env bash

set -eu

echo "Analyzing $INPUT_PATH..."

PROJECT_DIR="/tmp/projects"
PROJECT_NAME="project"
LOG_PATH="/tmp/analysis.log"
REPORT_PATH=$INPUT_REPORT_PATH

mkdir -p $PROJECT_DIR

/ghidra/support/analyzeHeadless \
  $PROJECT_DIR \
  $PROJECT_NAME \
  -import $INPUT_PATH \
  -log $LOG_PATH

python3 /gen_report.py $LOG_PATH $REPORT_PATH

echo "::set-output name=report::$(cat $REPORT_PATH)"