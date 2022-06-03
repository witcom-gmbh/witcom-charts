{{/*
Expand the name of the chart.
*/}}
{{- define "kafka-connect-ui.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kafka-connect-ui.fullname" -}}
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
{{- define "kafka-connect-ui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kafka-connect-ui.labels" -}}
helm.sh/chart: {{ include "kafka-connect-ui.chart" . }}
{{ include "kafka-connect-ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kafka-connect-ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kafka-connect-ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kafka-connect-ui.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kafka-connect-ui.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Define OAuth2 Redirect-Url
*/}}
{{- define "kafka-connect-ui.oauthRedirectUrl" -}}
{{- if .Values.ingress.tls }}
{{- printf "https://%s/oauth2/callback" ( (first .Values.ingress.tls).hosts | first ) }}
{{- else }}
{{- printf "http://%s/oauth2/callback" ( (first .Values.ingress.hosts).host ) }}
{{- end }}
{{- end }}

{{/*
Defines the list of kafka-connect instances
*/}}
{{- define "kafka-connect-ui.connectUrls" -}}
{{- $list := list }}
{{- range .Values.connectClusters }}
{{- $list = append $list (printf "%s;%s" .url .name)}}
{{- end }}
{{- join "," $list }}
{{- end }}