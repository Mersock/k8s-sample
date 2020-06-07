
## How to Run On Local.

## Declare Postgres password
````
kubectl create secret generic pgpassword --from-literal=PGPASSWORD=postgres_password
````

````
 kubectl apply -f k8s/
````

## Install nginx ingress controller
````
https://kubernetes.github.io/ingress-nginx/deploy/#provider-specific-steps

````
Run with http://localhost

## Docker Desktop's Kubernetes Dashboard

This note is for using Docker Desktop's built-in Kubernetes. If you are using Minikube, the setup here does not apply to you and can be skipped.

If you are using Docker Desktop's built-in Kubernetes, setting up the admin dashboard is going to take a little more work.

1. Grab the kubectl script we need to apply from the GitHub repository: https://github.com/kubernetes/dashboard

2. We will need to download the config file locally so we can edit it (make sure you are copying the most current version from the repo).

If on Mac or using GitBash on Windows enter the following:
```
curl -O https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
```
If using PowerShell:
```
Invoke-RestMethod -Uri https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml -Outfile kubernetes-dashboard.yaml
```

3. Open up the downloaded file in your code editor and find line 116. Add the following two lines underneath --auto-generate-certificates:
```
args:
  - --auto-generate-certificates
  - --enable-skip-login
  - --disable-settings-authorizer
```

4. Run the following command inside the directory where you downloaded the dashboard yaml file a few steps ago:

```
kubectl apply -f kubernetes-dashboard.yaml
```

5. Start the server by running the following command:
````
kubectl proxy
````

6. You can now access the dashboard by visiting:
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

7. You will be presented with a login screen:

![Screenshot](https://i.udemycdn.com/redactor/raw/2019-07-25_23-26-22-05c379f98fb2ad996fc8b0d35c36c7a3.png)

8. Click the "SKIP" link next to the SIGN IN button.

9. You should now be redirected to the Kubernetes Dashboard:
![Screenshot](https://i.udemycdn.com/redactor/raw/2019-07-16_18-08-24-437b0f50882f516c9d169df04e5d24c4.png)

Important! The only reason we are bypassing RBAC Authorization to access the Kubernetes Dashboard is because we are running our cluster locally. You would never do this on a public facing server like Digital Ocean and would need to refer to the official docs to get the dashboard setup:
https://github.com/kubernetes/dashboard/wiki/Access-control
