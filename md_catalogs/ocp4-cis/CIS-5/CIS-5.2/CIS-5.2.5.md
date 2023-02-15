# CIS-5.2.5 - \[Pod Security Policies\] Minimize the admission of containers with allowPrivilegeEscalation

## Control Statement

Do not generally permit containers to be run with the `allowPrivilegeEscalation` flag set to `true`.

## Control rationale_statement

A container running with the `allowPrivilegeEscalation` flag set to `true` may have processes that can gain more privileges than their parent.

There should be at least one Security Context Constraint (SCC) defined which does not permit containers to allow privilege escalation. The option exists (and is defaulted to true) to permit setuid binaries to run.

If you have need to run containers which use setuid binaries or require privilege escalation, this should be defined in a separate SCC and you should carefully check RBAC controls to ensure that only limited service accounts and users are given permission to access that SCC.

## Control impact_statement

Pods defined with `Allow Privilege Escalation: true` will not be permitted unless they are run under a specific SCC.

## Control remediation_procedure

Create a SCC as described in the OpenShift documentation, ensuring that the `Allow Privilege Escalation` field is set to `false`.

## Control audit_procedure

Get the set of SCCs with the following command:

```
oc get scc
```

For each SCC, check whether privileged is enabled:

```
# needs verification
for i in `oc get scc --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'`; do echo "$i"; oc describe scc $i | grep "Allow Privilege Escalation"; done
```

Verify that there is at least one SCC which does not return true.

## Control CIS_Controls

TITLE:Restrict Administrator Privileges to Dedicated Administrator Accounts CONTROL:v8 5.4 DESCRIPTION:Restrict administrator privileges to dedicated administrator accounts on enterprise assets. Conduct general computing activities, such as internet browsing, email, and productivity suite use, from the user’s primary, non-privileged account.;
