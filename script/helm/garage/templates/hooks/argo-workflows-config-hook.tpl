apiVersion: batch/v1
kind: Job
metadata:
  name: garage-argo-workflows-config-hook
  annotations:
    helm.sh/hook: post-install,post-upgrade
spec:
  template:
    metadata:
      name: "{{ .Release.Name }}"
      labels:
        app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
        app.kubernetes.io/instance: {{ .Release.Name | quote }}
        helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
    spec:
      restartPolicy: Never
      serviceAccountName: garage-argo-workflows-config-hook
      containers:
      - name: garage-argo-workflows-config-hook
        image: {{ printf "%s:%s" .Values.argoWorkflowsConfigHook.image.repository .Values.argoWorkflowsConfigHook.image.tag }}
        imagePullPolicy: {{ .Values.argoWorkflowsConfigHook.image.pullPolicy }}
        env:
        - name: NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: GARAGE_ADMIN_TOKEN
          valueFrom:
            secretKeyRef:
              name: garage-admin
              key: token
        - name: GARAGE_DEPLOYMENT_KIND
          value: {{ .Values.deployment.kind }}
        - name: GARAGE_WORKLOAD_NAME
          value: {{ include "garage.fullname" . }}
        - name: GARAGE_API_URL
          value: {{ printf "http://%s:%s" (include "garage.fullname" .) (toString .Values.service.s3.admin.port)  }}
        - name: GARAGE_S3_API_URL
          value: {{ printf "http://%s:%s" (include "garage.fullname" .) (toString .Values.service.s3.api.port)  }}
        {{- if .Values.persistence.enabled }}
        - name: GARAGE_NODE_CAPACITY_BYTES_REQUESTS
          value: {{ .Values.persistence.data.size }}
        {{- end }}
