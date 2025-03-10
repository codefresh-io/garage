# garage

![Version: 0.5.0-cf.3](https://img.shields.io/badge/Version-0.5.0--cf.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.9.4](https://img.shields.io/badge/AppVersion-v0.9.4-informational?style=flat-square)

S3-compatible object store for small self-hosted geo-distributed deployments

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| garagehq.deuxfleurs.fr |  |  |
| codefresh.io |  |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| argoWorkflowsConfigHook | object | `{"image":{"pullPolicy":"IfNotPresent","repository":"quay.io/codefresh/garage-argo-workflows-config-hook","tag":"2024.05.18-5def96f"}}` | Config hook for argo workflows |
| deployment.kind | string | `"StatefulSet"` |  |
| deployment.replicaCount | int | `3` |  |
| fullnameOverride | string | `""` |  |
| garage."garage.toml" | string | `"metadata_dir = \"/mnt/meta\"\ndata_dir = \"/mnt/data\"\n\ndb_engine = \"{{ .Values.garage.dbEngine }}\"\n\nblock_size = {{ .Values.garage.blockSize }}\n\nreplication_mode = \"{{ .Values.garage.replicationMode }}\"\n\ncompression_level = {{ .Values.garage.compressionLevel }}\n\nrpc_bind_addr = \"{{ .Values.garage.rpcBindAddr }}\"\n# rpc_secret will be populated by the init container from a k8s secret object\nrpc_secret = \"__RPC_SECRET_REPLACE__\"\n\nbootstrap_peers = {{ .Values.garage.bootstrapPeers }}\n\n[kubernetes_discovery]\nnamespace = \"{{ .Release.Namespace }}\"\nservice_name = \"{{ include \"garage.fullname\" . }}\"\nskip_crd = {{ .Values.garage.kubernetesSkipCrd }}\n\n[s3_api]\ns3_region = \"{{ .Values.garage.s3.api.region }}\"\napi_bind_addr = \"[::]:3900\"\nroot_domain = \"{{ .Values.garage.s3.api.rootDomain }}\"\n\n[s3_web]\nbind_addr = \"[::]:3902\"\nroot_domain = \"{{ .Values.garage.s3.web.rootDomain }}\"\nindex = \"{{ .Values.garage.s3.web.index }}\"\n\n[admin]\napi_bind_addr = \"[::]:3903\"\n{{- if .Values.monitoring.tracing.sink }}\ntrace_sink = \"{{ .Values.monitoring.tracing.sink }}\"\n{{- end }}"` |  |
| garage.blockSize | string | `"1048576"` |  |
| garage.bootstrapPeers | list | `[]` |  |
| garage.compressionLevel | string | `"1"` |  |
| garage.dbEngine | string | `"lmdb"` |  |
| garage.kubernetesSkipCrd | bool | `false` |  |
| garage.replicationMode | string | `"3"` |  |
| garage.rpcBindAddr | string | `"[::]:3901"` |  |
| garage.rpcSecret | string | `""` |  |
| garage.s3.api.region | string | `"garage"` |  |
| garage.s3.api.rootDomain | string | `".s3.garage.tld"` |  |
| garage.s3.web.index | string | `"index.html"` |  |
| garage.s3.web.rootDomain | string | `".web.garage.tld"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"dxflrs/garage"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.s3.api.annotations | object | `{}` |  |
| ingress.s3.api.enabled | bool | `false` |  |
| ingress.s3.api.hosts[0].host | string | `"s3.garage.tld"` |  |
| ingress.s3.api.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.s3.api.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.s3.api.hosts[1].host | string | `"*.s3.garage.tld"` |  |
| ingress.s3.api.hosts[1].paths[0].path | string | `"/"` |  |
| ingress.s3.api.hosts[1].paths[0].pathType | string | `"Prefix"` |  |
| ingress.s3.api.labels | object | `{}` |  |
| ingress.s3.api.tls | list | `[]` |  |
| ingress.s3.web.annotations | object | `{}` |  |
| ingress.s3.web.enabled | bool | `false` |  |
| ingress.s3.web.hosts[0].host | string | `"*.web.garage.tld"` |  |
| ingress.s3.web.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.s3.web.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.s3.web.hosts[1].host | string | `"mywebpage.example.com"` |  |
| ingress.s3.web.hosts[1].paths[0].path | string | `"/"` |  |
| ingress.s3.web.hosts[1].paths[0].pathType | string | `"Prefix"` |  |
| ingress.s3.web.labels | object | `{}` |  |
| ingress.s3.web.tls | list | `[]` |  |
| initImage.pullPolicy | string | `"IfNotPresent"` |  |
| initImage.repository | string | `"busybox"` |  |
| initImage.tag | string | `"stable"` |  |
| monitoring.metrics.enabled | bool | `false` |  |
| monitoring.metrics.serviceMonitor.enabled | bool | `false` |  |
| monitoring.metrics.serviceMonitor.interval | string | `"15s"` |  |
| monitoring.metrics.serviceMonitor.labels | object | `{}` |  |
| monitoring.metrics.serviceMonitor.path | string | `"/metrics"` |  |
| monitoring.metrics.serviceMonitor.relabelings | list | `[]` |  |
| monitoring.metrics.serviceMonitor.scheme | string | `"http"` |  |
| monitoring.metrics.serviceMonitor.scrapeTimeout | string | `"10s"` |  |
| monitoring.metrics.serviceMonitor.tlsConfig | object | `{}` |  |
| monitoring.tracing.sink | string | `""` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.data.hostPath | string | `"/var/lib/garage/data"` |  |
| persistence.data.size | string | `"100Mi"` |  |
| persistence.data.storageClass | string | `""` |  |
| persistence.enabled | bool | `true` |  |
| persistence.meta.hostPath | string | `"/var/lib/garage/meta"` |  |
| persistence.meta.size | string | `"100Mi"` |  |
| persistence.meta.storageClass | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsGroup | int | `1000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `1000` |  |
| resources | object | `{}` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| service.s3.admin.port | int | `3903` |  |
| service.s3.api.port | int | `3900` |  |
| service.s3.web.port | int | `3902` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tests.awsCliImage | string | `"amazon/aws-cli:2.24.11"` |  |
| tests.enabled | bool | `true` |  |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.9.1](https://github.com/norwoodj/helm-docs/releases/v1.9.1)
