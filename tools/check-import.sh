#!/bin/bash
# Copyright 2020 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

set -e

ARTIFACT_PATH=${1:-"*.tar.gz"}

if [[ -n "venv" ]]; then
    source venv/bin/activate
fi

# galaxy_importer.main does not return non-zero error code on error
PY_EXE=$(command -v python3 || command -v python)
output=$($PY_EXE -m galaxy_importer.main $ARTIFACT_PATH) || true
if echo $output | grep ERROR: ; then
    #echo $output
    exit 1
fi

