# CIS-5.7.2 - \[General Policies\] Ensure that the seccomp profile is set to docker/default in your pod definitions

## Control Statement

Enable `default` seccomp profile in your pod definitions.

## Control rationale_statement

Seccomp (secure computing mode) is used to restrict the set of system calls applications can make, allowing cluster administrators greater control over the security of workloads running in the cluster. Kubernetes disables seccomp profiles by default for historical reasons. You should enable it to ensure that the workloads have restricted actions available within the container.

## Control impact_statement

If the `default` seccomp profile is too restrictive for you, you will need to create and manage your own seccomp profiles.

## Control remediation_procedure

To enable the `default` seccomp profile, use the reserved value `/runtime/default` that will make sure that the pod uses the default policy available on the host.

## Control audit_procedure

In OpenShift 4, CRI-O is the supported runtime. CRI-O runs unconfined by default in order to meet CRI conformance criteria. 

On RHEL CoreOS, the default seccomp policy is associated with CRI-O and stored in `/etc/crio/seccomp.json`. The default profile is applied when the user asks for the runtime/default profile via annotation to the pod and when the associated SCC allows use of the specified seccomp profile. 

Configuration of allowable seccomp profiles is managed through OpenShift Security Context Constraints.

## Control CIS_Controls

TITLE:Establish and Maintain a Secure Configuration Process CONTROL:v8 4.1 DESCRIPTION:Establish and maintain a secure configuration process for enterprise assets (end-user devices, including portable and mobile, non-computing/IoT devices, and servers) and software (operating systems and applications). Review and update documentation annually, or when significant enterprise changes occur that could impact this Safeguard.;TITLE:Maintain Secure Images CONTROL:v7 5.2 DESCRIPTION:Maintain secure images or templates for all systems in the enterprise based on the organization's approved configuration standards. Any new system deployment or existing system that becomes compromised should be imaged using one of those images or templates.;
