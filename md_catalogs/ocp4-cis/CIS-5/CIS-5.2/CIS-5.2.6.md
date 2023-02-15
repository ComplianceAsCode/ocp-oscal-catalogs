# CIS-5.2.6 - \[Pod Security Policies\] Minimize the admission of root containers

## Control Statement

Do not generally permit containers to be run as the root user.

## Control rationale_statement

Containers may run as any Linux user. Containers which run as the root user, whilst constrained by Container Runtime security features still have an escalated likelihood of container breakout.

Ideally, all containers should run as a defined non-UID 0 user.

There should be at least one Security Context Constraint (SCC) defined which does not permit root users in a container.

If you need to run root containers, this should be defined in a separate SCC and you should carefully check RBAC controls to ensure that only limited service accounts and users are given permission to access that SCC.

## Control impact_statement

Pods with containers which run as the root user will not be permitted.

## Control remediation_procedure

None required. By default, OpenShift includes the non-root SCC with the the `Run As User Strategy` is set to either `MustRunAsNonRoot`. If additional SCCs are appropriate, follow the OpenShift documentation to create custom SCCs.

## Control audit_procedure

Get the set of SCCs with the following command:

```
oc get scc
```

For each SCC, check whether running containers as root is enabled:

```
# needs verification

for i in `oc get scc --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'`; do echo "$i"; oc describe scc $i | grep "Run As User Strategy"; done

#For SCCs with MustRunAs verify that the range of UIDs does not include 0

for i in `oc get scc --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'`; do echo "$i"; oc describe scc $i | grep "\sUID"; done
```

Verify that there is at least one SCC which returns `MustRunAsNonRoot` or one SCC which returns `MustRunAs` with the range of UIDs not including 0.

## Control CIS_Controls

TITLE:Restrict Administrator Privileges to Dedicated Administrator Accounts CONTROL:v8 5.4 DESCRIPTION:Restrict administrator privileges to dedicated administrator accounts on enterprise assets. Conduct general computing activities, such as internet browsing, email, and productivity suite use, from the user’s primary, non-privileged account.;
