image:
  repository: docker.io/velero/velero
  tag: v1.18.0
  pullPolicy: IfNotPresent

resources:
  requests:
    memory: 128Mi
    cpu: 500m
  limits:
    memory: 512Mi
    cpu: 1000m
  
dnsPolicy: ClusterFirst

initContainers:
- name: velero-plugin-for-aws
  image: velero/velero-plugin-for-aws:v1.13.1
  volumeMounts:
  - mountPath: /target
    name: plugins

# Liveness probe of the pod
livenessProbe:
  httpGet:
    path: /metrics
    port: http-monitoring
    scheme: HTTP
  initialDelaySeconds: 10
  periodSeconds: 30
  timeoutSeconds: 5
  successThreshold: 1
  failureThreshold: 5

# Readiness probe of the pod
readinessProbe:
  httpGet:
    path: /metrics
    port: http-monitoring
    scheme: HTTP
  initialDelaySeconds: 10
  periodSeconds: 30
  timeoutSeconds: 5
  successThreshold: 1
  failureThreshold: 5

# This job upgrades the CRDs.
upgradeCRDs: false

# This job is meant primarily for cleaning up CRDs on CI systems.
# Using this on production systems, especially those that have multiple releases of Velero, will be destructive.
cleanUpCRDs: false

configuration:
  backupStorageLocation:
  - name: default
    provider: aws
    prefix: velero/${cluster_name}
    bucket: ${cluster_name}-velero
    config:
      region: ${region}

  volumeSnapshotLocation:
  - name: default
    provider: aws
    config:
      region: ${region}

metrics:
  enabled: true

schedules:
  storageclasses:
    enabled: true
    schedule: '0 3 * * *'
    template:
      ttl: 2160h0m0s
      storageLocation: default
      snapshotVolumes: true
      includedNamespaces: 
      - "*"
      excludedNamespaces:
      - kube-system
      - kube-public
      - monitoring
      - velero

  resources:
    enabled: true
    schedule: '0 4,16 * * *'
    template:
      ttl: 2160h0m0s
      snapshotVolumes: false
      includedNamespaces:
      - "*"
      excludedNamespaces:
      - kube-system
      - kube-public
      - monitoring
      - velero
      includedResources:
      - "*"
      includeClusterResources: true
