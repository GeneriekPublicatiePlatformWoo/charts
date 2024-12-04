{{/*
Expand the name gpp-app the chart.
*/}}
{{- define "gpp-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gpp-app.fullname" -}}
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
{{- define "gpp-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "gpp-app.commonLabels" -}}
helm.sh/chart: {{ include "gpp-app.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
gpp-app labels
*/}}
{{- define "gpp-app.labels" -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{ include "gpp-app.commonLabels" . }}
{{ include "gpp-app.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "gpp-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gpp-app.name" . }}
{{- end }}

{{/*
Create a name for the worker
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "gpp-app.workerName" -}}
{{ include "gpp-app.name" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Create a default fully qualified name for the worker.
We truncate at 56 chars in order to provide space for the "-worker" suffix
*/}}
{{- define "gpp-app.workerFullname" -}}
{{ include "gpp-app.fullname" . | trunc 56 | trimSuffix "-" }}-worker
{{- end }}

{{/*
Worker labels
*/}}
{{- define "gpp-app.workerLabels" -}}
{{ include "gpp-app.commonLabels" . }}
{{ include "gpp-app.workerSelectorLabels" . }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "gpp-app.workerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "gpp-app.workerName" . }}
{{- end }}

{{/*
Create a name for Flower
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "gpp-app.flowerName" -}}
{{ include "gpp-app.name" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Create a default fully qualified name for Flower.
We truncate at 56 chars in order to provide space for the "-flower" suffix
*/}}
{{- define "gpp-app.flowerFullname" -}}
{{ include "gpp-app.fullname" . | trunc 56 | trimSuffix "-" }}-flower
{{- end }}

{{/*
Flower labels
*/}}
{{- define "gpp-app.flowerLabels" -}}
{{ include "gpp-app.commonLabels" . }}
{{ include "gpp-app.flowerSelectorLabels" . }}
{{- end }}

{{/*
Flower selector labels
*/}}
{{- define "gpp-app.flowerSelectorLabels" -}}
app.kubernetes.io/name: {{ include "gpp-app.flowerName" . }}
{{- end  }}

{{/*
Create the name of the service account to use
*/}}
{{- define "gpp-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "gpp-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Ingress annotations
*/}}
{{- define "gpp-app.ingress.annotations" -}}
  {{- range $key, $val := .Values.ingress.annotations }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
{{- end }}

{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "gpp-app.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "gpp-app.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}

{{/*
Create a name for NGINX
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "gpp-app.nginxName" -}}
{{ include "gpp-app.name" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
Create a default fully qualified name for NGINX.
We truncate at 57 chars in order to provide space for the "-nginx" suffix
*/}}
{{- define "gpp-app.nginxFullname" -}}
{{ include "gpp-app.fullname" . | trunc 57 | trimSuffix "-" }}-nginx
{{- end }}

{{/*
NGINX labels
*/}}
{{- define "gpp-app.nginxLabels" -}}
{{ include "gpp-app.commonLabels" . }}
{{ include "gpp-app.nginxSelectorLabels" . }}
{{- end }}

{{/*
NGINX selector labels
*/}}
{{- define "gpp-app.nginxSelectorLabels" -}}
app.kubernetes.io/name: {{ include "gpp-app.nginxName" . }}
{{- end }}