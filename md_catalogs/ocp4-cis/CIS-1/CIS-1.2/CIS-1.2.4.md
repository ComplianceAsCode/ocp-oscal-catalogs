# CIS-1.2.4 - \[API Server\] Use https for kubelet connections

## Control Statement

Use https for kubelet connections.

## Control rationale_statement

Connections from `apiserver` to `kubelets` could potentially carry sensitive data such as secrets and keys. It is thus important to use in-transit encryption for any communication between the `apiserver` and `kubelets`.

## Control impact_statement

You require TLS to be configured on `apiserver` as well as `kubelets`.

## Control remediation_procedure

No remediation is required. OpenShift platform components use X.509 certificates for authentication. OpenShift manages the CAs and certificates for platform components. This is not configurable.

## Control audit_procedure

OpenShift does not use the `--kubelet-https` argument. OpenShift utilizes X.509 certificates for authentication of the control-plane components. OpenShift configures the API server to use an internal certificate authority (CA) to validate the user certificate sent during TLS negotiation. If the validation of the certificate is successful, the request is authenticated and user information is derived from the certificate subject fields.

To verify the kubelet client certificates are present, run the following command:

```
#for 4.5
oc get configmap config -n openshift-kube-apiserver -ojson | jq -r '.data["config.yaml"]' | jq '.kubeletClientInfo' 

#for 4.6
oc get configmap config -n openshift-kube-apiserver -ojson | jq -r '.data["config.yaml"]' | jq '.apiServerArguments'

#for both 4.5 and 4.6
oc -n openshift-apiserver describe secret serving-cert
```

Verify that the kubelet client-certificate and kubelet client-key files are present.

client-certificate: 

`/etc/kubernetes/static-pod-resources/secrets/kubelet-client/tls.crt`

client-key: 

`/etc/kubernetes/static-pod-resources/secrets/kubelet-client/tls.key`

Verify that the serving-cert for the `openshift-apiserver` is type kubernetes.io/tls and that returned Data includes `tls.crt` and `tls.key`.

## Control CIS_Controls

TITLE:Encrypt Sensitive Data in Transit CONTROL:v8 3.10 DESCRIPTION:Encrypt sensitive data in transit. Example implementations can include: Transport Layer Security (TLS) and Open Secure Shell (OpenSSH).;TITLE:Encrypt All Sensitive Information in Transit CONTROL:v7 14.4 DESCRIPTION:Encrypt all sensitive information in transit.;
