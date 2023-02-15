# CIS-5.5.1 - \[Extensible Admission Control\] Configure Image Provenance using image controller configuration parameters

## Control Statement

Configure Image Provenance for your deployment.

## Control rationale_statement

Kubernetes supports plugging in provenance rules to accept or reject the images in your deployments. You could configure such rules to ensure that only approved images are deployed in the cluster.

You can control which images can be imported, tagged, and run in a cluster using the image controller. For additional information on the image controller, see [Image configuration resources](https://docs.openshift.com/container-platform/4.5/openshift_images/image-configuration.html)

## Control impact_statement

You need to regularly maintain your provenance configuration based on container image updates.

## Control remediation_procedure

Follow the OpenShift documentation: [Image configuration resources](https://docs.openshift.com/container-platform/4.5/openshift_images/image-configuration.html

## Control audit_procedure

Review the image controller parameters in your cluster and verify that image provenance is configured as appropriate.

## Control CIS_Controls

TITLE:Establish and Maintain a Secure Configuration Process CONTROL:v8 4.1 DESCRIPTION:Establish and maintain a secure configuration process for enterprise assets (end-user devices, including portable and mobile, non-computing/IoT devices, and servers) and software (operating systems and applications). Review and update documentation annually, or when significant enterprise changes occur that could impact this Safeguard.;TITLE:Deploy System Configuration Management Tools CONTROL:v7 5.4 DESCRIPTION:Deploy system configuration management tools that will automatically enforce and redeploy configuration settings to systems at regularly scheduled intervals.;
