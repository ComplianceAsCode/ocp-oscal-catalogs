# CIS-5.7.3 - \[General Policies\] Apply Security Context to Your Pods and Containers

## Control Statement

Apply Security Context to Your Pods and Containers

## Control rationale_statement

A security context defines the operating system security settings (uid, gid, capabilities, SELinux role, etc..) applied to a container. When designing your containers and pods, make sure that you configure the security context for your pods, containers, and volumes. A security context is a property defined in the deployment yaml. It controls the security parameters that will be assigned to the pod/container/volume. There are two levels of security context: pod level security context, and container level security context.

## Control impact_statement

If you incorrectly apply security contexts, you may have trouble running the pods.

## Control remediation_procedure

Follow the Kubernetes documentation and apply security contexts to your pods. For a suggested list of security contexts, you may refer to the CIS Security Benchmark for Docker Containers.

## Control audit_procedure

Review the pod definitions in your cluster and verify that you have security contexts defined as appropriate.

OpenShift's Security Context Constraint feature is on by default in OpenShift 4 and applied to all pods deployed. SCC selection is determined by a combination of the values in the securityContext and the rolebindings for the account deploying the pod.

## Control CIS_Controls

TITLE:Perform Automated Operating System Patch Management CONTROL:v8 7.3 DESCRIPTION:Perform operating system updates on enterprise assets through automated patch management on a monthly, or more frequent, basis.;TITLE:Enable Operating System Anti-Exploitation Features/ Deploy Anti-Exploit Technologies CONTROL:v7 8.3 DESCRIPTION:Enable anti-exploitation features such as Data Execution Prevention (DEP) or Address Space Layout Randomization (ASLR) that are available in an operating system or deploy appropriate toolkits that can be configured to apply protection to a broader set of applications and executables.;
