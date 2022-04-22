#!/usr/bin/bash
DATE=`date`
helm repo index docs --url https://witcom-gmbh.github.io/witcom-charts/
git add .
git commit -m "Chart update ${DATE}"  
git push origin main
