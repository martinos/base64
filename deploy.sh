#! /usr/bin/env bash
find ./dist -type file | while read file; do aws s3 cp $file s3://base64.martinosis.com;done
