# CIS-4.2.5 - \[Kubelet\] Ensure that the --streaming-connection-idle-timeout argument is not set to 0

## Control Statement

Do not disable timeouts on streaming connections.

## Control rationale_statement

Setting idle timeouts ensures that you are protected against Denial-of-Service attacks, inactive connections and running out of ephemeral ports. 

**Note:** By default, `--streaming-connection-idle-timeout` is set to 4 hours which might be too high for your environment. Setting this as appropriate would additionally ensure that such streaming connections are timed out after serving legitimate use cases.

## Control impact_statement

Long-lived connections could be interrupted.

## Control remediation_procedure

Follow the instructions in the documentation to create a Kubelet config CRD and set the `--streaming-connection-idle-timeout` to the desired value. Do not set the value to `0`.

## Control audit_procedure

OpenShift uses the kubernetes default of 4 hours for the streaming-connection-idle-timeout argument. Unless the cluster administrator has added the value to the node configuration, the default will be used. The value is a timeout for HTTP streaming sessions going through a kubelet, like the port-forward, exec, or attach pod operations. The `streaming-connection-idle-timeout` should not be disabled by setting it to `zero`, but it can be lowered. Note that if the value is set too low, then users using those features may experience a service interruption due to the timeout. 

The kubelet configuration is currently serialized as an ignition configuration, so it can be directly edited. However, there is also a new `kubelet-config-controller` added to the Machine Config Controller (MCC). This allows you to create a `KubeletConfig` custom resource (CR) to edit the kubelet parameters.

Run the following command on each node:

```

# Should return 1 for each node
for node in $(oc get nodes -o jsonpath='{.items[*].metadata.name}')
do
 oc debug node/${node} -- chroot /host ps -ef | grep kubelet | grep streaming-connection-idle-timeout
 echo $?
done

# Should return 1 for each node
for node in $(oc get nodes -o jsonpath='{.items[*].metadata.name}')
do
 oc debug node/${node} -- chroot /host grep streamingConnectionIdleTimeout /etc/kubernetes/kubelet.conf
 echo $?
done
```

Verify that the `--streaming-connection-idle-timeout` argument is not set to `0`.
If the argument is not present, and there is a Kubelet config file specified by `--config`, check that it does not set `streamingConnectionIdleTimeout` to `0`.

## Control CIS_Controls

TITLE:Uninstall or Disable Unnecessary Services on Enterprise Assets and Software CONTROL:v8 4.8 DESCRIPTION:Uninstall or disable unnecessary services on enterprise assets and software, such as an unused file sharing service, web application module, or service function.;TITLE:Ensure Only Approved Ports, Protocols and Services Are Running CONTROL:v7 9.2 DESCRIPTION:Ensure that only network ports, protocols, and services listening on a system with validated business needs, are running on each system.;
