# CIS-1.4.1 - \[Scheduler\] Ensure that the healthz endpoints for the scheduler are protected by RBAC

## Control Statement

Disable profiling, if not needed.

## Control rationale_statement

Profiling allows for the identification of specific performance bottlenecks. It generates a significant amount of program data that could potentially be exploited to uncover system and program details. If you are not experiencing any bottlenecks and do not need the profiler for troubleshooting purposes, it is recommended to turn it off to reduce the potential attack surface.

## Control impact_statement

Profiling information would not be available.

## Control remediation_procedure

A fix to this issue: https://bugzilla.redhat.com/show_bug.cgi?id=1889488

None required. Profiling is protected by RBAC and cannot be disabled.

## Control audit_procedure

In OpenShift 4, The Kubernetes Scheduler operator manages and updates the Kubernetes Scheduler deployed on top of OpenShift. By default, the operator exposes metrics via metrics service. The metrics are collected from the Kubernetes Scheduler operator. Profiling data is sent to `healthzPort`, the port of the localhost `healthz` endpoint. Changing this value may disrupt components that monitor the kubelet health. The default `healthz` `port` value is `10251`, and the `healthz` `bindAddress` is `127.0.0.1`

To ensure the collected data is not exploited, profiling endpoints are secured via RBAC (see cluster-debugger role). By default, the profiling endpoints are accessible only by users bound to `cluster-admin` or `cluster-debugger` role. Profiling can not be disabled. 

To verify the configuration, run the following command:

Run the following command:

```
# check configuration for ports, livenessProbe, readinessProbe, healthz

oc -n openshift-kube-scheduler get cm kube-scheduler-pod -o json | jq -r '.data."pod.yaml"' | jq '.spec.containers'

# Test to verify endpoints

oc -n openshift-kube-scheduler describe endpoints

Test to validate RBAC enabled on the scheduler endpoint; check with non-admin role

oc project openshift-kube-scheduler

POD=$(oc get pods -l app=openshift-kube-scheduler -o jsonpath='{.items[0].metadata.name}')

PORT=$(oc get pod $POD -o jsonpath='{.spec.containers[0].livenessProbe.httpGet.port}')

# Should return 403 Forbidden
oc rsh ${POD} curl http://localhost:${PORT}/metrics -k

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

Verify that the livenessProbe and readinessProbe are set to path: `healthz`.

Verify that only users with the `cluster_admi`n role can retrieve metrics from the endpoint.

Verify that a regular user cannot get information about the scheduler. NOTE: If this check fails, please check the status of this issue: https://bugzilla.redhat.com/show_bug.cgi?id=1889488

## Control CIS_Controls

TITLE:Define and Maintain Role-Based Access Control CONTROL:v8 6.8 DESCRIPTION:Define and maintain role-based access control, through determining and documenting the access rights necessary for each role within the enterprise to successfully carry out its assigned duties. Perform access control reviews of enterprise assets to validate that all privileges are authorized, on a recurring schedule at a minimum annually, or more frequently.;TITLE:Protect Information through Access Control Lists CONTROL:v7 14.6 DESCRIPTION:Protect all information stored on systems with file system, network share, claims, application, or database specific access control lists. These controls will enforce the principle that only authorized individuals should have access to the information based on their need to access the information as a part of their responsibilities.;
