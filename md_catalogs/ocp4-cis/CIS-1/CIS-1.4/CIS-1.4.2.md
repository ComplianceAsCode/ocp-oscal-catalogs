# CIS-1.4.2 - \[Scheduler\] Verify that the scheduler API service is protected by authentication and authorization

## Control Statement

Do not bind the scheduler service to non-loopback insecure addresses.

## Control rationale_statement

The Scheduler API service which runs on port 10251/TCP by default is used for health and metrics information and is available without authentication or encryption. As such it should only be bound to a localhost interface, to minimize the cluster's attack surface

## Control impact_statement

None

## Control remediation_procedure

By default, the `--bind-address` argument is not present, the readinessProbe and `livenessProbe` arguments are set to `10251` and the `port` argument is set to `0`.

Check the status of this issue: https://bugzilla.redhat.com/show_bug.cgi?id=1889488

## Control audit_procedure

In OpenShift 4, The Kubernetes Scheduler operator manages and updates the Kubernetes Scheduler deployed on top of OpenShift. By default, the operator exposes metrics via metrics service. The metrics are collected from the Kubernetes Scheduler operator. Profiling data is sent to `healthzPort`, the port of the localhost `healthz` endpoint. Changing this value may disrupt components that monitor the kubelet health. The default `healthz` `port` value is `10251`, and the `healthz` `bindAddress` is `127.0.0.1`

To ensure the collected data is not exploited, profiling endpoints are secured via RBAC (see cluster-debugger role). By default, the profiling endpoints are accessible only by users bound to `cluster-admin` or `cluster-debugger` role. Profiling can not be disabled. 

The bind-address argument is not used. Both authentication and authorization are in place.

https://github.com/openshift/cluster-kube-scheduler-operator

Run the following command:

```
# to verify endpoints

oc -n openshift-kube-scheduler describe endpoints

# To verify that bind-adress is not used in the configuration and that port is set to 0
oc -n openshift-kube-scheduler get cm kube-scheduler-pod -o json | jq -r '.data."pod.yaml"' | jq '.spec.containers'

# To test for RBAC: 
oc project openshift-kube-scheduler

POD=$(oc get pods -l app=openshift-kube-scheduler -o jsonpath='{.items[0].metadata.name}')

POD_IP=$(oc get pods -l app=openshift-kube-scheduler -o jsonpath='{.items[0].status.podIP}')

PORT=$(oc get pod $POD -o jsonpath='{.spec.containers[0].livenessProbe.httpGet.port}')

# Should return a 403
oc rsh ${POD} curl http://${POD_IP}:${PORT}/metrics

# Create a service account to test RBAC
oc create sa permission-test-sa

# Should return 403 Forbidden
SA_TOKEN=$(oc sa get-token permission-test-sa)
oc rsh ${POD} curl http://localhost:${PORT}/metrics -H "Authorization: Bearer $SA_TOKEN" -k

# Cleanup
oc delete sa permission-test-sa

# As cluster admin, should succeed
CLUSTER_ADMIN_TOKEN=$(oc whoami -t)
oc rsh ${POD} curl http://localhost:${PORT}/metrics -H "Authorization: Bearer $CLUSTER_ADMIN_TOKEN" -k
```

Verify that the --bind-address argument is not present and that `healthz` is bound to `port` `10251`.

Verify that only users with the cluster_admin role can retrieve metrics from the endpoint.

Verify that a regular user cannot get information about the scheduler. NOTE: If this check fails, please check the status of this issue: https://bugzilla.redhat.com/show_bug.cgi?id=1889488

## Control CIS_Controls

TITLE:Maintain and Enforce Network-Based URL Filters CONTROL:v8 9.3 DESCRIPTION:Enforce and update network-based URL filters to limit an enterprise asset from connecting to potentially malicious or unapproved websites. Example implementations include category-based filtering, reputation-based filtering, or through the use of block lists. Enforce filters for all enterprise assets.;TITLE:Ensure Only Approved Ports, Protocols and Services Are Running CONTROL:v7 9.2 DESCRIPTION:Ensure that only network ports, protocols, and services listening on a system with validated business needs, are running on each system.;
