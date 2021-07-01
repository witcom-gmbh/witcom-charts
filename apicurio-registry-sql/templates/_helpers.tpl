{{/*
Expand the name of the chart.
*/}}
{{- define "apicurio-registry-sql.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "apicurio-registry-sql.fullname" -}}
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
{{- define "apicurio-registry-sql.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "apicurio-registry-sql.labels" -}}
helm.sh/chart: {{ include "apicurio-registry-sql.chart" . }}
{{ include "apicurio-registry-sql.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "apicurio-registry-sql.selectorLabels" -}}
app.kubernetes.io/name: {{ include "apicurio-registry-sql.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "apicurio-registry-sql.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "apicurio-registry-sql.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the globalId Topic
*/}}
{{- define "apicurio-registry-sql.globalIdTopic" -}}
{{- if .Values.kafka.globalIdTopic }}
{{- .Values.kafka.globalIdTopic | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-global-id-topic" .Release.Name  | replace "+" "_" | trunc 63 | trimSuffix "-"  }}
{{- end }}
{{- end }}


{{/*
Create the name of the globalStorage Topic        
*/}}
{{- define "apicurio-registry-sql.globalStorageTopic" -}}
{{- if .Values.kafka.globalStorageTopic }}
{{- .Values.kafka.globalStorageTopic | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-global-storage-topic" .Release.Name  | replace "+" "_" | trunc 63 | trimSuffix "-"  }}
{{- end }}
{{- end }}

