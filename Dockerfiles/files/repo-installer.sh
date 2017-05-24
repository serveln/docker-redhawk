#!/bin/bash
# This file is protected by Copyright. Please refer to the COPYRIGHT file
# distributed with this source distribution.
#
# This file is part of Docker REDHAWK.
#
# Docker REDHAWK is free software: you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option) any
# later version.
#
# Docker REDHAWK is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see http://www.gnu.org/licenses/.
#
set -e

echo RH_VERSION: "${RH_VERSION:?Need to set RH_VERSION}"

wget https://github.com/RedhawkSDR/redhawk/releases/download/${RH_VERSION}/redhawk-yum-${RH_VERSION}-el7-x86_64.tar.gz
tar xzf redhawk-yum-${RH_VERSION}-el7-x86_64.tar.gz
rm redhawk-yum-${RH_VERSION}-el7-x86_64.tar.gz
mv redhawk-${RH_VERSION}-el7-x86_64 redhawk-yum
pushd redhawk-yum

cat<<EOF|sed 's@LDIR@'`pwd`'@g'|tee /etc/yum.repos.d/redhawk.repo
[redhawk]
name=REDHAWK Repository
baseurl=file://LDIR/
enabled=1
gpgcheck=0
EOF

