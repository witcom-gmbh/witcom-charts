{{/*
Expand the name of the chart.
*/}}
{{- define "extranet-docs-docservice.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "extranet-docs-docservice.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "extranet-docs-docservice.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "extranet-docs-docservice.labels" -}}
helm.sh/chart: {{ include "extranet-docs-docservice.chart" . }}
{{ include "extranet-docs-docservice.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "extranet-docs-docservice.selectorLabels" -}}
app.kubernetes.io/name: {{ include "extranet-docs-docservice.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "extranet-docs-docservice.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "extranet-docs-docservice.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the default secret to use
*/}}
{{- define "extranet-docs-docservice.defaultSecret" -}}
{{- if .Values.config.defaultSecretName }}
{{- default .Values.config.defaultSecretName  }}
{{- else }}
{{- default (include "extranet-docs-docservice.fullname" .) }}
{{- end }}
{{- end }}

