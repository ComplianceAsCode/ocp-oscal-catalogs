# CIS-5.7.4 - \[General Policies\] The default namespace should not be used

## Control Statement

Kubernetes provides a default namespace, where objects are placed if no namespace is specified for them. Placing objects in this namespace makes application of RBAC and other controls more difficult.

## Control rationale_statement

Resources in a Kubernetes cluster should be segregated by namespace, to allow for security controls to be applied at that level and to make it easier to manage resources.

## Control impact_statement

None

## Control remediation_procedure

Ensure that namespaces are created to allow for appropriate segregation of Kubernetes resources and that all new resources are created in a specific namespace.

## Control audit_procedure

In OpenShift, projects (namespaces) are used to group and isolate related objects. When a request is made to create a new project using the web console or oc new-project command, an endpoint in OpenShift Container Platform is used to provision the project according to a template, which can be customized. 

The cluster administrator can allow and configure how developers and service accounts can create, or self-provision, their own projects. Regular users do not have access to the default project. 

Projects starting with openshift- and kube- host cluster components that run as Pods and other infrastructure components. As such, OpenShift does not allow you to create Projects starting with openshift- or kube- using the oc new-project command.

For more information, see 
[Working with projects](https://docs.openshift.com/container-platform/4.4/applications/projects/working-with-projects.html) and 
[Configuring project creation](https://docs.openshift.com/containerplatform/4.4/applications/projects/configuring-project-creation.html)

Run this command to list objects in default namespace

```
oc project default
oc get all 
```

The only entries there should be system managed resources such as the `kubernetes` and `openshift` service

## Control CIS_Controls

TITLE:Configure Trusted DNS Servers on Enterprise Assets CONTROL:v8 4.9 DESCRIPTION:Configure trusted DNS servers on enterprise assets. Example implementations include: configuring assets to use enterprise-controlled DNS servers and/or reputable externally accessible DNS servers. ;TITLE:Secure Configuration for Hardware and Software on Mobile Devices, Laptops, Workstations and Servers CONTROL:v7 5 DESCRIPTION:Secure Configuration for Hardware and Software on Mobile Devices, Laptops, Workstations and Servers;
