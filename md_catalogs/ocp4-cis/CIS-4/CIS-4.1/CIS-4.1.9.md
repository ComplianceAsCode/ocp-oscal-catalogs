# CIS-4.1.9 - \[Worker Node Configuration Files\] Ensure that the kubelet --config configuration file has permissions set to 600 or more restrictive

## Control Statement

Ensure that if the kubelet refers to a configuration file with the `--config` argument, that file has permissions of `600` or more restrictive.

## Control rationale_statement

The kubelet reads various parameters, including security settings, from a config file specified by the `--config` argument. If this file is specified you should restrict its file permissions to maintain the integrity of the file. The file should be writable by only the administrators on the system.

## Control impact_statement

None

## Control remediation_procedure

None required.

## Control audit_procedure

In OpenShift 4, the `kublet.conf` file is managed by the Machine Config Operator. The kubelet config file is found at `/var/lib/kubelet/config.json` with file permissions set to `600`.

Run the command:

```

for node in $(oc get nodes -o jsonpath='{.items[*].metadata.name}')
do
 oc debug node/${node} -- chroot /host stat -c %a /var/lib/kubelet/config.json
done
```

Verify that the permissions are `600`.

## Control CIS_Controls

TITLE:Maintain Secure Images CONTROL:v7 5.2 DESCRIPTION:Maintain secure images or templates for all systems in the enterprise based on the organization's approved configuration standards. Any new system deployment or existing system that becomes compromised should be imaged using one of those images or templates.;TITLE:Minimize And Sparingly Use Administrative Privileges CONTROL:v6 5.1 DESCRIPTION:Minimize administrative privileges and only use administrative accounts when they are required. Implement focused auditing on the use of administrative privileged functions and monitor for anomalous behavior.;
