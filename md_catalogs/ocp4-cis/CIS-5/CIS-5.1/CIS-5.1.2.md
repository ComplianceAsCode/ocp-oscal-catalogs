# CIS-5.1.2 - \[RBAC and Service Accounts\] Minimize access to secrets

## Control Statement

The Kubernetes API stores secrets, which may be service account tokens for the Kubernetes API or credentials used by workloads in the cluster. Access to these secrets should be restricted to the smallest possible group of users to reduce the risk of privilege escalation.

## Control rationale_statement

Inappropriate access to secrets stored within the Kubernetes cluster can allow for an attacker to gain additional access to the Kubernetes cluster or external resources whose credentials are stored as secrets.

## Control impact_statement

Care should be taken not to remove access to secrets to system components which require this for their operation

## Control remediation_procedure

Where possible, remove `get`, `list` and `watch` access to `secret` objects in the cluster.

## Control audit_procedure

Review the users who have `get`, `list` or `watch` access to `secrets` objects in the Kubernetes API.

## Control CIS_Controls

TITLE:Segment Data Processing and Storage Based on Sensitivity CONTROL:v8 3.12 DESCRIPTION:Segment data processing and storage based on the sensitivity of the data. Do not process sensitive data on enterprise assets intended for lower sensitivity data.;TITLE:Only Allow Access to Authorized Cloud Storage or Email Providers CONTROL:v7 13.4 DESCRIPTION:Only allow access to authorized cloud storage or email providers.;
