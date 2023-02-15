# CIS-1.2.26 - \[API Server\] Ensure that the --request-timeout argument is set as appropriate

## Control Statement

Set global request timeout for API server requests as appropriate.

## Control rationale_statement

Setting global request timeout allows extending the API server request timeout limit to a duration appropriate to the user's connection speed. By default, it is set to 60 seconds which might be problematic on slower connections making cluster resources inaccessible once the data volume for requests exceeds what can be transmitted in 60 seconds. But, setting this timeout limit to be too large can exhaust the API server resources making it prone to Denial-of-Service attack. Hence, it is recommended to set this limit as appropriate and change the default limit of 60 seconds only if needed.

## Control impact_statement

None

## Control remediation_procedure

TBD

## Control audit_procedure

OpenShift configures the `min-request-timeout` flag via `servingInfo.requestTimeoutSeconds`, which overrides `request-timeout` in certain scenarios and provides a more balanced timeout approach than a global request-timeout. 

Run the following command:

```
oc get configmap config -n openshift-kube-apiserver -ojson | \
 jq -r '.data["config.yaml"]' | \
 jq -r .servingInfo.requestTimeoutSeconds
```

Verify that the `servingInfo.requestTimeoutSeconds` argument is set to an appropriate value.

## Control CIS_Controls

TITLE:Establish and Maintain a Secure Configuration Process CONTROL:v8 4.1 DESCRIPTION:Establish and maintain a secure configuration process for enterprise assets (end-user devices, including portable and mobile, non-computing/IoT devices, and servers) and software (operating systems and applications). Review and update documentation annually, or when significant enterprise changes occur that could impact this Safeguard.;TITLE:Establish Secure Configurations CONTROL:v7 5.1 DESCRIPTION:Maintain documented, standard security configuration standards for all authorized operating systems and software.;
