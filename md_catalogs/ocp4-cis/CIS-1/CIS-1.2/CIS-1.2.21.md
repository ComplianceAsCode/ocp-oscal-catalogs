# CIS-1.2.21 - \[API Server\] Ensure that the healthz endpoint is protected by RBAC

## Control Statement

Disable profiling, if not needed.

## Control rationale_statement

Profiling allows for the identification of specific performance bottlenecks. It generates a significant amount of program data that could potentially be exploited to uncover system and program details. If you are not experiencing any bottlenecks and do not need the profiler for troubleshooting purposes, it is recommended to turn it off to reduce the potential attack surface.

## Control impact_statement

Profiling information would not be available.

## Control remediation_procedure

None required as profiling data is protected by RBAC.

## Control audit_procedure

Profiling is enabled by default in OpenShift. The API server operators expose Prometheus metrics via the metrics service. Profiling data is sent to `healthzPort`, the port of the localhost `healthz` endpoint. Changing this value may disrupt components that monitor the kubelet health. The default port value is 10248, and the `healthz`
`BindAddress` is `127.0.0.1`

To ensure the collected data is not exploited, profiling endpoints are exposed at each master port and secured via RBAC (see cluster-debugger role). By default, the profiling endpoints are accessible only by users bound to `cluster-admin` or `cluster-debugger` role. 

Profiling cannot be disabled.

To verify the configuration, run the following command:

```
# Verify endpoints
oc -n openshift-kube-apiserver describe endpoints

# Check config for ports, livenessProbe, readinessProbe, healthz
oc -n openshift-kube-apiserver get cm kube-apiserver-pod -o json | jq -r '.data."pod.yaml"' | jq '.spec.containers'

# Test to validate RBAC enabled on the apiserver endpoint; check with non-admin role
oc project openshift-kube-apiserver

POD=$(oc get pods -n openshift-kube-apiserver -l app=openshift-kube-apiserver -o jsonpath='{.items[0].metadata.name}')

PORT=$(oc get pods -n openshift-kube-apiserver -l app=openshift-kube-apiserver -o jsonpath='{.items[0].spec.containers[0].ports[0].hostPort}')

# Following should return 403 Forbidden
oc rsh -n openshift-kube-apiserver ${POD} curl https://localhost:${PORT}/metrics -k

# Create a service account to test RBAC
oc create -n openshift-kube-apiserver sa permission-test-sa

# Should return 403 Forbidden
SA_TOKEN=$(oc sa -n openshift-kube-apiserver get-token permission-test-sa)
oc rsh -n openshift-kube-apiserver ${POD} curl https://localhost:${PORT}/metrics -H "Authorization: Bearer $SA_TOKEN" -k

# Cleanup
oc delete -n openshift-kube-apiserver sa permission-test-sa

# As cluster admin, should succeed
CLUSTER_ADMIN_TOKEN=$(oc whoami -t)
oc rsh -n openshift-kube-apiserver ${POD} curl https://localhost:${PORT}/metrics -H "Authorization: Bearer $CLUSTER_ADMIN_TOKEN" -k
```

Verify that the `livenessProbe` and `readinessProbe` are set to path: `healthz`.

Verify that only users with the `cluster_admin` role can retrieve metrics from the endpoint.

## Control CIS_Controls

TITLE:Define and Maintain Role-Based Access Control CONTROL:v8 6.8 DESCRIPTION:Define and maintain role-based access control, through determining and documenting the access rights necessary for each role within the enterprise to successfully carry out its assigned duties. Perform access control reviews of enterprise assets to validate that all privileges are authorized, on a recurring schedule at a minimum annually, or more frequently.;TITLE:Protect Information through Access Control Lists CONTROL:v7 14.6 DESCRIPTION:Protect all information stored on systems with file system, network share, claims, application, or database specific access control lists. These controls will enforce the principle that only authorized individuals should have access to the information based on their need to access the information as a part of their responsibilities.;
