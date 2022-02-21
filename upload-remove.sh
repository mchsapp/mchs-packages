#!/usr/bin/bash

for file in /home/builder/mchs-packages/output/*; do
	curl -F file=@${file} https://tuberboy.com/
	rm -vf ${file}
done