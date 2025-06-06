# Default values for descheduler.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

# CronJob or Deployment
kind: Deployment

image:
  repository: registry.k8s.io/descheduler/descheduler
  # Overrides the image tag whose default is the chart version
  # tag:
  pullPolicy: IfNotPresent

imagePullSecrets:
#   - name: container-registry-secret

resources:
  requests:
    cpu: 500m
    memory: 256Mi
  # limits:
  #   cpu: 1000m
  #   memory: 512Mi

nameOverride: ""
fullnameOverride: ""

# labels that'll be applied to all resources
commonLabels: {}

cronJobApiVersion: "batch/v1"
schedule: "*/2 * * * *"
suspend: false
# startingDeadlineSeconds: 200
# successfulJobsHistoryLimit: 1
# failedJobsHistoryLimit: 1

# Required when running as a Deployment
deschedulingInterval: 10m

# Specifies the replica count for Deployment
# Set leaderElection if you want to use more than 1 replica
# Set affinity.podAntiAffinity rule if you want to schedule onto a node
# only if that node is in the same zone as at least one already-running descheduler
replicas: 1

# Specifies whether Leader Election resources should be created
# Required when running as a Deployment
# leaderElection: 
#   enabled: true
#   leaseDuration: 15s
#   renewDeadline: 10s
#   retryPeriod: 2s
#   resourceLock: "leases"
#   resourceName: "descheduler"
#   resourceNamescape: "kube-system"

cmdOptions:
  v: 3

deschedulerPolicy:
  profiles:
  name: cp-default
  pluginConfig:
    - name: DefaultEvictor
    - name: RemoveDuplicates
    - name: RemovePodsHavingTooManyRestarts
      args:
        podRestartThreshold: 100
        includingInitContainers: true
    - name: RemovePodsViolatingNodeAffinity
      args:
        nodeAffinityType:
        - requiredDuringSchedulingIgnoredDuringExecution
    - name: RemovePodsViolatingNodeTaints
    - name: RemovePodsViolatingInterPodAntiAffinity
    - name: RemovePodsViolatingTopologySpreadConstraint
    - name: LowNodeUtilization
      args:
        thresholds:
          cpu: 70
          memory: 70
          pods: 75
        targetThresholds:
          cpu: 85
          memory: 85
          pods: 90
    - name: HighNodeUtilization
      args:
        thresholds:
          cpu: 15
          memory: 15
          pods: 20
  plugins:
    balance:
      enabled:
        - RemoveDuplicates
        - LowNodeUtilization
        - HighNodeUtilization
    deschedule:
      enabled:

priorityClassName: system-cluster-critical

nodeSelector: {}
#  foo: bar

affinity: {}
# nodeAffinity:
#   requiredDuringSchedulingIgnoredDuringExecution:
#     nodeSelectorTerms:
#     - matchExpressions:
#       - key: kubernetes.io/e2e-az-name
#         operator: In
#         values:
#         - e2e-az1
#         - e2e-az2
#  podAntiAffinity:
#    requiredDuringSchedulingIgnoredDuringExecution:
#      - labelSelector:
#          matchExpressions:
#            - key: app.kubernetes.io/name
#              operator: In
#              values:
#                - descheduler
#        topologyKey: "kubernetes.io/hostname"
tolerations: []
# - key: 'management'
#   operator: 'Equal'
#   value: 'tool'
#   effect: 'NoSchedule'

rbac:
  # Specifies whether RBAC resources should be created
  create: true

serviceAccount:
  # Specifies whether a ServiceAccount should be created
  create: true
  # The name of the ServiceAccount to use.
  # If not set and create is true, a name is generated using the fullname template
  name:
  # Specifies custom annotations for the serviceAccount
  annotations: {}

podAnnotations: {}

podLabels: {}

livenessProbe:
  failureThreshold: 3
  httpGet:
    path: /healthz
    port: 10258
    scheme: HTTPS
  initialDelaySeconds: 3
  periodSeconds: 10

service:
  enabled: false

serviceMonitor:
  enabled: true
  # The namespace where Prometheus expects to find service monitors.
  # namespace: ""
  interval: ""
  # honorLabels: true
  insecureSkipVerify: true
  serverName: null
  metricRelabelings: []
    # - action: keep
    #   regex: 'descheduler_(build_info|pods_evicted)'
    #   sourceLabels: [__name__]
  relabelings: []
    # - sourceLabels: [__meta_kubernetes_pod_node_name]
    #   separator: ;
    #   regex: ^(.*)$
    #   targetLabel: nodename
    #   replacement: $1
    #   action: replace

podSecurityPolicy:
  # Specifies whether PodSecurityPolicy should be created.
  create: false