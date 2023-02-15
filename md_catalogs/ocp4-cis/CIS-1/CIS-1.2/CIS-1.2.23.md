# CIS-1.2.23 - \[API Server\] Ensure that the audit logs are forwarded off the cluster for retention

## Control Statement

Retain the logs for at least 30 days or as appropriate.

## Control rationale_statement

Retaining logs for at least 30 days ensures that you can go back in time and investigate or correlate any events. Set your audit log retention period to 30 days or as per your business requirements.

## Control impact_statement

None

## Control remediation_procedure

Follow the documentation for log forwarding. [Forwarding logs to third party systems](https://docs.openshift.com/container-platform/4.5/logging/cluster-logging-external.html)

## Control audit_procedure

OpenShift audit works at the API server level, logging all requests coming to the server. Audit is on by default. Best practice is to ship audit logs off the cluster for retention. 

OpenShift includes the optional Cluster Logging operator and the `ElasticSearch` operator. OpenShift cluster logging can be configured to send logs to destinations outside of your OpenShift Container Platform cluster instead of the default `Elasticsearc`h log store using the following methods:

- Sending logs using the `Fluentd` forward protocol. You can create a `Configmap` to use the `Fluentd` forward protocol to securely send logs to an external logging aggregator that accepts the Fluent forward protocol.
- Sending logs using syslog. You can create a `Configmap` to use the syslog protocol to send logs to an external syslog (RFC 3164) server.

Alternatively, you can use the Log Forwarding API, currently in Technology Preview. The Log Forwarding API, which is easier to configure than the `Fluentd` protocol and syslog, exposes configuration for sending logs to the internal `lasticsearch` log store and to external `Fluentd` log aggregation solutions.

You cannot use the ConfigMap methods and the Log Forwarding API in the same cluster.

Verify that audit log forwarding is configured as appropriate.

## Control CIS_Controls

TITLE:Establish and Maintain an Audit Log Management Process CONTROL:v8 8.1 DESCRIPTION:Establish and maintain an audit log management process that defines the enterprise’s logging requirements. At a minimum, address the collection, review, and retention of audit logs for enterprise assets. Review and update documentation annually, or when significant enterprise changes occur that could impact this Safeguard.;TITLE:Ensure adequate storage for logs CONTROL:v7 6.4 DESCRIPTION:Ensure that all systems that store logs have adequate storage space for the logs generated.;
