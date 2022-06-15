#!/usr/bin/bash
DATE=`date`
helm repo index docs --url https://witcom-gmbh.github.io/witcom-charts/
git add .
git commit -m "chart: update ${DATE}" --signoff 
git push origin main
