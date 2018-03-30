#!/bin/bash

for node in "tt-ha" "tt-ippbx"; do \
	ssh -t -l apexx $node "hostname"
# how to do without password prompt?
done

exit 0;
#	scp -r cgiProxyDataEdit \
#	apexx@$node:/home/apexx/public_html/ippbx/cgi-bin/admin/cgiProxyDataEdit.cgi; \
#sudo sed -i "38s/.*/PermitRootLogin without-password/" /etc/ssh/sshd_config
#sudo sed -i "38s/.*/PermitRootLogin yes/" /etc/ssh/sshd_config; systemctl restart sshd.service
