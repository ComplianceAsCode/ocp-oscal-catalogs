# CIS-5.1.4 - \[RBAC and Service Accounts\] Minimize access to create pods

## Control Statement

The ability to create pods in a namespace can provide a number of opportunities for privilege escalation, such as assigning privileged service accounts to these pods or mounting hostPaths with access to sensitive data (unless Pod Security Policies are implemented to restrict this access)    As such, access to create new pods should be restricted to the smallest possible group of users.

## Control rationale_statement

The ability to create pods in a cluster opens up possibilities for privilege escalation and should be restricted, where possible.

## Control impact_statement

Care should be taken not to remove access to pods to system components which require this for their operation

## Control remediation_procedure

Where possible, remove `create` access to `pod` objects in the cluster.

## Control audit_procedure

Review the users who have create access to pod objects in the Kubernetes API.

## Control CIS_Controls

TITLE:Allowlist Authorized Scripts CONTROL:v8 2.7 DESCRIPTION:Use technical controls, such as digital signatures and version control, to ensure that only authorized scripts, such as specific .ps1, .py, etc., files, are allowed to execute. Block unauthorized scripts from executing. Reassess bi-annually, or more frequently.;TITLE:Maintain Secure Images CONTROL:v7 5.2 DESCRIPTION:Maintain secure images or templates for all systems in the enterprise based on the organization's approved configuration standards. Any new system deployment or existing system that becomes compromised should be imaged using one of those images or templates.;
