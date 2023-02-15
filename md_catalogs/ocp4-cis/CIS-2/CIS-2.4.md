# CIS-2.4 - \[etcd\] Ensure that the --peer-cert-file and --peer-key-file arguments are set as appropriate

## Control Statement

etcd should be configured to make use of TLS encryption for peer connections.

## Control rationale_statement

etcd is a highly-available key value store used by Kubernetes deployments for persistent storage of all of its REST API objects. These objects are sensitive in nature and should be encrypted in transit and also amongst peers in the etcd clusters.

## Control impact_statement

etcd cluster peers are set up TLS for their communication.

## Control remediation_procedure

None. This configuration is managed by the etcd operator.

## Control audit_procedure

OpenShift uses X.509 certificates to provide secure communication to etcd. OpenShift generates these files and sets the arguments appropriately. etcd certificates are used for encrypted communication between etcd member peers, as well as encrypted client traffic. Peer certificates are generated and used for communication between etcd members.

Openshift installs etcd as static pods on control plane nodes, and mounts the configuration files from `/etc/etcd/` on the host. The `etcd.conf` file includes `peer-cert-file` and `peer-key-file` configurations as referenced in `/etc/etcd/etcd.conf`.

Run the following command:

```

# For --peer-cert-file
for i in $(oc get pods -oname -n openshift-etcd)
do
 oc exec -n openshift-etcd -c etcd $i -- \
 ps -o command= -C etcd | sed 's/.*\(--peer-cert-file=[^ ]*\).*/\1/'
done

# For --peer-key-file
for i in $(oc get pods -oname -n openshift-etcd)
do
 oc exec -n openshift-etcd -c etcd $i -- \
 ps -o command= -C etcd | sed 's/.*\(--peer-key-file=[^ ]*\).*/\1/'
done
```

Verify that the following is returned for each etcd member.
`--peer-cert-file=/etc/kubernetes/static-pod-certs/secrets/etcd-all-peer/etcd-peer-${ETCD_DNS_NAME}.crt`
`--peer-key-file=/etc/kubernetes/static-pod-certs/secrets/etcd-all-peer/etcd-peer-${ETCD_DNS_NAME}.key`

For example
`--peer-cert-file=/etc/kubernetes/static-pod-certs/secrets/etcd-all-peer/etcd-peer-ip-10-0-158-52.us-east-2.compute.internal.crt`
`--peer-key-file=/etc/kubernetes/static-pod-certs/secrets/etcd-all-peer/etcd-peer-ip-10-0-158-52.us-east-2.compute.internal.key`

## Control CIS_Controls

TITLE:Encrypt Sensitive Data in Transit CONTROL:v8 3.10 DESCRIPTION:Encrypt sensitive data in transit. Example implementations can include: Transport Layer Security (TLS) and Open Secure Shell (OpenSSH).;TITLE:Encrypt All Sensitive Information in Transit CONTROL:v7 14.4 DESCRIPTION:Encrypt all sensitive information in transit.;
