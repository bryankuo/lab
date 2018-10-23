#!/bin/bash
#192.168.66.212
#220.134.181.113:8080
#linux.die.net/man/1/wget
wget \
	--recursive \
	--no-clobber \
	--page-requisites \
	--html-extension \
	--convert-links \
	--restrict-file-names=unix \
	--no-parent \
	192.168.66.212:80/fs-property/package
exit 0
