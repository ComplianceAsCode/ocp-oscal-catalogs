# CIS-1.3.6 - \[Controller Manager\] Ensure that the RotateKubeletServerCertificate argument is set to true

## Control Statement

Enable kubelet server certificate rotation on controller-manager.

## Control rationale_statement

`RotateKubeletServerCertificate` causes the kubelet to both request a serving certificate after bootstrapping its client credentials and rotate the certificate as its existing credentials expire. This automated periodic rotation ensures that there are no downtimes due to expired certificates and thus addressing availability in the CIA security triad.

Note: This recommendation only applies if you let kubelets get their certificates from the API server. In case your kubelet certificates come from an outside authority/tool (e.g. Vault) then you need to take care of rotation yourself.

## Control impact_statement

None

## Control remediation_procedure

None required. Certificates for OpenShift platform components are automatically created and rotated by the OpenShift Container Platform.

## Control audit_procedure

Certificates for the kubelet are automatically created and rotated by the OpenShift Container Platform. The kubelet is installed automatically on every RHCOS node. The OpenShift `kubelet-serving-CA` manages certificates for the kubelet. Kubelet certificates are automatically issued and rotated. 

Run the following command:

```
oc get configmaps config -n openshift-kube-controller-manager -ojson | jq -r '.data["config.yaml"]' | jq -r '.extendedArguments["feature-gates"][]'
```

Verify that `RotateKubeletServerCertificate` argument exists and is set to `true`.

## Control CIS_Controls

TITLE:Use Unique Passwords CONTROL:v8 5.2 DESCRIPTION:Use unique passwords for all enterprise assets. Best practice implementation includes, at a minimum, an 8-character password for accounts using MFA and a 14-character password for accounts not using MFA. ;TITLE:Use Unique Passwords CONTROL:v7 4.4 DESCRIPTION:Where multi-factor authentication is not supported (such as local administrator, root, or service accounts), accounts will use passwords that are unique to that system.;
