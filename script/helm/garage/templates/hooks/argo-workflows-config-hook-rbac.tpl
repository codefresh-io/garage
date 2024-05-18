apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    helm.sh/hook: post-install,post-upgrade
  name: garage-argo-workflows-config-hook
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: garage-argo-workflows-config-hook
  annotations:
    helm.sh/hook: post-install,post-upgrade
rules:
- apiGroups: ["apps"]
  resources: ["statefulsets"]
  verbs: ["get", "list", "watch", "update", "patch"]
- apiGroups: [""]
  resources: ["secrets", "configmaps"]
  verbs: ["get", "list", "watch", "create", "update", "delete","patch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: garage-argo-workflows-config-hook
subjects:
- kind: ServiceAccount
  name: garage-argo-workflows-config-hook
  namespace: {{ .Release.Namespace }}
roleRef:
  kind: Role
  name: garage-argo-workflows-config-hook
  apiGroup: rbac.authorization.k8s.io
