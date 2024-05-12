apiVersion: v1
kind: ServiceAccount
metadata:
  name: garage-argo-workflows-adapter
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: garage-argo-workflows-adapter
  annotations:
    "helm.sh/hook": post-install,post-upgrade
rules:
- apiGroups: ["apps"]
  resources: ["statefulsets"]
  verbs: ["get", "list", "watch"]
- apiGroups: [""]
  resources: ["secrets", "configmaps"]
  verbs: ["get", "list", "watch", "create", "update", "delete","patch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: garage-argo-workflows-adapter
subjects:
- kind: ServiceAccount
  name: garage-argo-workflows-adapter
  namespace: {{ .Release.Namespace }}
roleRef:
  kind: Role
  name: garage-argo-workflows-adapter
  apiGroup: rbac.authorization.k8s.io
