# CIS-4.2.13 - \[Kubelet\] Ensure that the Kubelet only makes use of Strong Cryptographic Ciphers

## Control Statement

Ensure that the Kubelet is configured to only use strong cryptographic ciphers.

## Control rationale_statement

TLS ciphers have had a number of known vulnerabilities and weaknesses, which can reduce the protection provided by them. By default Kubernetes supports a number of TLS ciphersuites including some that have security concerns, weakening the protection provided.

## Control impact_statement

Kubelet clients that cannot support modern cryptographic ciphers will not be able to make connections to the Kubelet API.

## Control remediation_procedure

Follow the directions above and in the OpenShift documentation to configure the `tlsSecurityProfile`. [Configuring Ingress](https://docs.openshift.com/container-platform/4.5/networking/ingress-operator.html#nw-ingress-controller-configuration-parameters_configuring-ingress)

## Control audit_procedure

The set of cryptographic ciphers currently considered secure is the following:

```
 TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
 TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
 TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305
 TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
 TLS_RSA_WITH_AES_256_GCM_SHA384
 TLS_RSA_WITH_AES_128_GCM_SHA256
```

Ciphers for the API servers, authentication and the ingress controller can be configured using the `tlsSecurityProfile` parameter as of OpenShfit 4.3. The ingress controller provides external access to the API server. There are four TLS security profile types:

- Old
- Intermediate
- Modern
- Custom

Only the Old, Intermediate and Custom profiles are supported at this time for the Ingress controller. Custom provides the ability to specify individual TLS security profile parameters. Follow the steps in the documentation to configure the cipher suite for Ingress, API server and Authentication. https://docs.openshift.com/container-platform/4.5/networking/ingress-operator.html#nw-ingress-controller-configuration-parameters_configuring-ingress

Run the following commands to verify the cipher suite and minTLSversion for the ingress operator, authentication operator, `cliconfig`, OpenShift `APIserver` and Kube APIserver.

```
# needs verification

# verify cipher suites
oc describe --namespace=openshift-ingress-operator ingresscontroller/default

oc get kubeapiservers.operator.openshift.io cluster -o json |jq .spec.observedConfig.servingInfo

oc get openshiftapiservers.operator.openshift.io cluster -o json |jq .spec.observedConfig.servingInfo

oc get cm -n openshift-authentication v4-0-config-system-cliconfig -o jsonpath='{.data.v4\-0\-config\-system\-cliconfig}' | jq .servingInfo

#check value for tlsSecurityProfile; null is returned if default is used
oc get kubeapiservers.operator.openshift.io cluster -o json |jq .spec.tlsSecurityProfile
```

Verify that the cipher suites are appropriate. 

Verify that the `tlsSecurityProfile` is set to the value you chose. 

Note: The HAProxy Ingress controller image does not support TLS 1.3 and because the Modern profile requires TLS 1.3, it is not supported. The Ingress Operator converts the Modern profile to Intermediate. The Ingress Operator also converts the TLS 1.0 of an Old or Custom profile to 1.1, and TLS 1.3 of a Custom profile to 1.2.

## Control CIS_Controls

TITLE:Use Unique Passwords CONTROL:v8 5.2 DESCRIPTION:Use unique passwords for all enterprise assets. Best practice implementation includes, at a minimum, an 8-character password for accounts using MFA and a 14-character password for accounts not using MFA. ;TITLE:Utilize Client Certificates to Authenticate Hardware Assets CONTROL:v7 1.8 DESCRIPTION:Use client certificates to authenticate hardware assets connecting to the organization's trusted network.;TITLE:Address unapproved software CONTROL:v7 2.6 DESCRIPTION:Ensure that unauthorized software is either removed or the inventory is updated in a timely manner;
