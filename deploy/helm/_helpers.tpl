{{/* Generate name helpers */}}
{{- define "mlops-assignment.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mlops-assignment.fullname" -}}
{{- printf "%s" (include "mlops-assignment.name" .) -}}
{{- end -}}
