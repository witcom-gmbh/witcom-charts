{{/*
Expand the name of the chart.
*/}}
{{- define "witcom-id-generator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "witcom-id-generator.fullname" -}}
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
{{- define "witcom-id-generator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "witcom-id-generator.labels" -}}
helm.sh/chart: {{ include "witcom-id-generator.chart" . }}
{{ include "witcom-id-generator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "witcom-id-generator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "witcom-id-generator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: generator
{{- end }}

{{/*
Common labels
*/}}
{{- define "witcom-id-generator.webapp.labels" -}}
helm.sh/chart: {{ include "witcom-id-generator.chart" . }}
{{ include "witcom-id-generator.webapp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Selector labels webapp
*/}}
{{- define "witcom-id-generator.webapp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "witcom-id-generator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: webapp
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "witcom-id-generator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "witcom-id-generator.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name for the redis requirement.
*/}}
{{- define "witcom-id-generator.redis.fullname" -}}
{{- $redisContext := dict "Values" .Values.redis "Release" .Release "Chart" (dict "Name" "redis") -}}
{{ include "redis.fullname" $redisContext }}
{{- end }}
