apiVersion: batch/v1
kind: Job
metadata:
  name: garage-argo-workflows-adapter
  annotations:
    "helm.sh/hook": post-install,post-upgrade
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
      serviceAccountName: garage-argo-workflows-adapter
      containers:
      - name: garage-argo-workflows-adapter
        image: "docker.io/ilmedcodefresh/garage-argo-workflows-adater:latest"
        imagePullPolicy: "Always"
        env:
        - name: NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: GARAGE_ADMIN_TOKEN
          valueFrom:
            secretKeyRef:
              name: garage-codefresh-admin
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
