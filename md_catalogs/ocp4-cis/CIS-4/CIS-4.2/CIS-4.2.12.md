# CIS-4.2.12 - \[Kubelet\] Verify that the RotateKubeletServerCertificate argument is set to true

## Control Statement

Enable kubelet server certificate rotation.

## Control rationale_statement

`RotateKubeletServerCertificate` causes the kubelet to both request a serving certificate after bootstrapping its client credentials and rotate the certificate as its existing credentials expire. This automated periodic rotation ensures that the there are no downtimes due to expired certificates and thus addressing availability in the CIA security triad.

Note: This recommendation only applies if you let kubelets get their certificates from the API server. In case your kubelet certificates come from an outside authority/tool (e.g. Vault) then you need to take care of rotation yourself.

## Control impact_statement

None

## Control remediation_procedure

None required.

## Control audit_procedure

Run the following command on each node:

```

#Verify the rotateKubeletServerCertificate feature gate is on 
for node in $(oc get nodes -o jsonpath='{.items[*].metadata.name}'); do oc debug node/${node} -- chroot /host more /etc/kubernetes/kubelet.conf; done

# Verify the rotateCertificates argument is set to true
for node in $(oc get nodes -o jsonpath='{.items[*].metadata.name}')
do
 oc debug node/${node} -- chroot host grep rotate /etc/kubernetes/kubelet.conf;
done
```

Verify that the `RotateKubeletServerCertificate` argument is set to `true`.

Verify that the `rotateCertificates` argument is set to `true`

## Control CIS_Controls

TITLE:Encrypt Sensitive Data in Transit CONTROL:v8 3.10 DESCRIPTION:Encrypt sensitive data in transit. Example implementations can include: Transport Layer Security (TLS) and Open Secure Shell (OpenSSH).;TITLE:Encrypt All Sensitive Information in Transit CONTROL:v7 14.4 DESCRIPTION:Encrypt all sensitive information in transit.;
