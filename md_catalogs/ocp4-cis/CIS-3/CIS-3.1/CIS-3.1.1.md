# CIS-3.1.1 - \[Authentication and Authorization\] Client certificate authentication should not be used for users

## Control Statement

Kubernetes provides the option to use client certificates for user authentication. However as there is no way to revoke these certificates when a user leaves an organization or loses their credential, they are not suitable for this purpose.    It is not possible to fully disable client certificate use within a cluster as it is used for component to component authentication.

## Control rationale_statement

With any authentication mechanism the ability to revoke credentials if they are compromised or no longer required, is a key control. Kubernetes client certificate authentication does not allow for this due to a lack of support for certificate revocation.

## Control impact_statement

External mechanisms for authentication generally require additional software to be deployed.

## Control remediation_procedure

Configure an identity provider for the OpenShift cluster. [Understanding identity provider configuration | Authentication | OpenShift Container Platform 4.5](https://docs.openshift.com/container-platform/4.5/authentication/understanding-identity-provider.html). Once an identity provider has been defined, you can use RBAC to define and apply permissions. After you define an identity provider and create a new `cluster-admin` user, remove the `kubeadmin` user to improve cluster security.

## Control audit_procedure

For users to interact with OpenShift Container Platform, they must first authenticate to the cluster. The authentication layer identifies the user with requests to the OpenShift Container Platform API. The authorization layer then uses information about the requesting user to determine if the request is allowed. [Understanding authentication | Authentication | OpenShift Container Platform 4.5](https://docs.openshift.com/container-platform/4.5/authentication/understanding-authentication.html)

The OpenShift Container Platform includes a built-in OAuth server for token-based authentication. Developers and administrators obtain OAuth access tokens to authenticate themselves to the API. It is recommended for an administrator to configure OAuth to specify an identity provider after the cluster is installed. User access to the cluster is managed through the identity provider. [Understanding identity provider configuration | Authentication | OpenShift Container Platform 4.5](https://docs.openshift.com/container-platform/4.5/authentication/understanding-identity-provider.html)

Run the following commands:

```

# To verify user authentication is enabled
oc describe authentication

# To verify that an identity provider is configured
oc get identity

# To verify that a custom cluster-admin user exists
oc get clusterrolebindings -o=custom-columns=NAME:.metadata.name,ROLE:.roleRef.name,SUBJECT:.subjects[*].kind | grep cluster-admin | grep User

# To verity that kbueadmin is removed, no results should be returned
oc get secrets kubeadmin -n kube-system
```

Verify that authentication is running. 

Verify that at least one identity provider is configured.

Verify that at least one user has cluster-admin role. For example
`NAME: cluster-admin-0` `ROLE: cluster-admin` `SUBJECT:*.kind User`

Verify that the `kubeadmin` user no longer exists

## Control CIS_Controls

TITLE:Uninstall or Disable Unnecessary Services on Enterprise Assets and Software CONTROL:v8 4.8 DESCRIPTION:Uninstall or disable unnecessary services on enterprise assets and software, such as an unused file sharing service, web application module, or service function.;
