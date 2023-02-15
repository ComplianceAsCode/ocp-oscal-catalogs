# CIS-4.2.10 - \[Kubelet\] Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate

## Control Statement

Setup TLS connection on the Kubelets.

## Control rationale_statement

The connections from the `apiserver` to the kubelet are used for fetching logs for pods, attaching (through kubectl) to running pods, and using the kubelet’s port-forwarding functionality. These connections terminate at the kubelet’s HTTPS endpoint. By default, the `apiserver` does not verify the kubelet’s serving certificate, which makes the connection subject to man-in-the-middle attacks, and unsafe to run over untrusted and/or public networks.

## Control impact_statement

TLS and client certificate authentication must be configured for your Kubernetes cluster deployment.

## Control remediation_procedure

OpenShift automatically manages TLS authentication for the API server communication with the `node/kublet`. This is not configurable.

## Control audit_procedure

By default, OpenShift uses X.509 certificates to provide secure connections between the API server and `node/kubelet`. OpenShift Container Platform monitors certificates for proper validity, for the cluster certificates it issues and manages. The OpenShift Container Platform manages certificate rotation and the alerting framework has rules to help identify when a certificate issue is about to occur. 

Run the following command on each node:

```
oc get configmap config -n openshift-kube-apiserver -ojson | jq -r '.data["config.yaml"]' | jq '.kubeletClientInfo' 
```

Verify that the `kubelet-client-certificate` argument is set to `/etc/kubernetes/static-pod-certs/secrets/kubelet-client/tls.crt`

Verify that the `kubelet-client-key` argument is set to `/etc/kubernetes/static-pod-certs/secrets/kublet-client/tls.key`

## Control CIS_Controls

TITLE:Encrypt Sensitive Data in Transit CONTROL:v8 3.10 DESCRIPTION:Encrypt sensitive data in transit. Example implementations can include: Transport Layer Security (TLS) and Open Secure Shell (OpenSSH).;TITLE:Encrypt All Sensitive Information in Transit CONTROL:v7 14.4 DESCRIPTION:Encrypt all sensitive information in transit.;
