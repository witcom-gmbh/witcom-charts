{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "witcom-zim.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "witcom-zim.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "witcom-zim.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "witcom-zim-component.uaa" -}}
{{- default "zimuaa" -}}
{{- end -}}

{{- define "witcom-zim-component.rmdbsvc" -}}
{{- default "rmdbsvc" -}}
{{- end -}}

{{- define "witcom-zim-component.labelsvc" -}}
{{- default "labelsvc" -}}
{{- end -}}

{{- define "witcom-zim-component.frontend" -}}
{{- default "frontend" -}}
{{- end -}}


{{/*
Create a default fully qualified app name for the zim-uaa mariadb requirement.
*/}}
{{- define "zimuaa.mariadb.fullname" -}}
{{- $dbContext := dict "Values" .Values.mariadbzimuaa "Release" .Release "Chart" (dict "Name" "mariadbzimuaa") -}}
{{ include "mariadb.fullname" $dbContext }}
{{- end -}}

{{/*
Create a default fully qualified app name for the frontend mariadb requirement.
*/}}
{{- define "frontend.mariadb.fullname" -}}
{{- $dbContext := dict "Values" .Values.mariadbfrontend "Release" .Release "Chart" (dict "Name" "mariadbfrontend") -}}
{{ include "mariadb.fullname" $dbContext }}
{{- end -}}

