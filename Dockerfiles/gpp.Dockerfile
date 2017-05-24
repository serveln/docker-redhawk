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

FROM redhawk/runtime:2.0.5
LABEL version="2.0.5" \
    description="REDHAWK GPP Runner" \
    maintainer="Thomas Goodwin <btgoodwin@geontech.com>"

ENV DOMAINNAME ""
ENV NODENAME   ""
ENV GPPNAME    ""

ADD files/gpp-node-init.sh /root/gpp-node-init.sh
RUN chmod u+x /root/gpp-node-init.sh && echo "/root/gpp-node-init.sh" | tee -a /root/.bashrc

ADD files/supervisord-device.conf /etc/supervisor.d/device.conf
CMD ["/usr/bin/supervisord"]
