# CIS-4.2.2 - \[Kubelet\] Ensure that the --authorization-mode argument is not set to AlwaysAllow

## Control Statement

Do not allow all requests. Enable explicit authorization.

## Control rationale_statement

Kubelets, by default, allow all authenticated requests (even anonymous ones) without needing explicit authorization checks from the apiserver. You should restrict this behavior and only allow explicitly authorized requests.

## Control impact_statement

Unauthorized requests will be denied.

## Control remediation_procedure

None required. Unauthenticated/Unauthorized users have no access to OpenShift nodes.

## Control audit_procedure

In OpenShift 4, the kublet config file is managed by the Machine Config Operator. By default, Unauthenticated/Unauthorized users have no access to OpenShift nodes. Run the following command:

```

#In one terminal, run:
 oc proxy

#Then in another terminal, run:
for name in $(oc get nodes -ojsonpath='{.items[*].metadata.name}')
do 
 curl -sS http://127.0.0.1:8080/api/v1/nodes/$name/proxy/configz | jq -r '.kubeletconfig.authorization.mode'
 done

# Alternative without oc proxy
POD=$(oc -n openshift-kube-apiserver get pod -l app=openshift-kube-apiserver -o jsonpath='{.items[0].metadata.name}')

TOKEN=$(oc whoami -t)

for name in $(oc get nodes -ojsonpath='{.items[*].metadata.name}')
do
 oc exec -n openshift-kube-apiserver $POD -- curl -sS https://172.25.0.1/api/v1/nodes/$name/proxy/configz -k -H "Authorization: Bearer $TOKEN" | jq -r '.kubeletconfig.authorization.mode'
done
```

Verify that access is not successful.

## Control CIS_Controls

TITLE:Configure Data Access Control Lists CONTROL:v8 3.3 DESCRIPTION:Configure data access control lists based on a user’s need to know. Apply data access control lists, also known as access permissions, to local and remote file systems, databases, and applications.;TITLE:Ensure Only Approved Ports, Protocols and Services Are Running CONTROL:v7 9.2 DESCRIPTION:Ensure that only network ports, protocols, and services listening on a system with validated business needs, are running on each system.;
