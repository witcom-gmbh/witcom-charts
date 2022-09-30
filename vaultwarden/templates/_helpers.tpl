{{/*
Expand the name of the chart.
*/}}
{{- define "vaultwarden.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vaultwarden.fullname" -}}
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
{{- define "vaultwarden.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vaultwarden.labels" -}}
helm.sh/chart: {{ include "vaultwarden.chart" . }}
{{ include "vaultwarden.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vaultwarden.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vaultwarden.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vaultwarden.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "vaultwarden.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}



{{/*
labels for backup cron-job
*/}}
{{- define "dbbackupjob.labels" -}}
{{- with .Values.backup.cronJobLabels }}
{{- toYaml . }}
{{- end }}
{{- end }}
 
{{/*
Common labels for backup
*/}}
{{- define "dbbackup.labels" -}}
helm.sh/chart: {{ include "vaultwarden.chart" . }}
{{ include "dbbackup.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
 
{{/*
Selector labels for backup
*/}}
{{- define "dbbackup.selectorLabels" -}}
app.kubernetes.io/name: {{ printf "%s-backup" (include "vaultwarden.name" .) }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
 
 
{{/*
Return the secret with S3 credentials
*/}}
{{- define "dbbackup.secretName" -}}
    {{- if .Values.backup.s3.existingSecret -}}
        {{- printf "%s" .Values.backup.s3.existingSecret -}}
    {{- else -}}
        {{ printf "%s-backup" (include "vaultwarden.fullname" .) }} 
    {{- end -}}
{{- end -}}

{{/*
Return true if a secret object should be created for S3 backups
*/}}
{{- define "dbbackup.createSecret" -}}
{{- if and (not .Values.backup.s3.existingSecret) (.Values.backup.enabled) }}
    {{- true -}}
{{- else -}}
{{- end -}}
{{- end -}}

