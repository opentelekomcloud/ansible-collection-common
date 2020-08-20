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

TOXDIR=${1:-.}
ANSIBLE_COLLECTIONS_PATH=$(mktemp -d)
echo "Executing ansible-test sanity checks in ${ANSIBLE_COLLECTIONS_PATH}"

trap "rm -rf ${ANSIBLE_COLLECTIONS_PATH}" err exit

rm -rf "${ANSIBLE_COLLECTIONS_PATH}"
mkdir -p ${ANSIBLE_COLLECTIONS_PATH}
# Created collection x.y at z
output=$(ansible-galaxy collection build --force | sed 's,.* at ,,')
# bla bla bla installing x.y to 'z'
location=$(ansible-galaxy collection install ${output} \
  -p ${ANSIBLE_COLLECTIONS_PATH} --force 2>/dev/null \
  | grep 'Installing' | sed 's,.* to ,,;' | tr -d "'")
echo $location
cd $location
echo "Running ansible-test with version:"
ansible --version
ansible-test sanity \
    --venv --python 3.6 --debug -v
