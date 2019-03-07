# Magento deployment

## Important notes

Before you will start, please check parameters in magento-install.sh and NFS share.

Such as:

- admin-password
- base-url
- DB username and password
- In yaml files NFS server and path
- In nginx/default.conf and in `ingresse/nginx.yaml` need to check url for magento

After nginx pod start we can check folowing:

```bash
# kubectl get pods -n magento2 | grep nginx
nginx-225482062-wccpn    1/1       Running   0          43s

# kubectl exec -ti -n magento2 nginx-225482062-wccpn -- /tmp/magento-install.sh
```

If you had passed the admin url in logs, you can find it in `app/etc/env.php`:

```bash
    'backend' => [
        'frontName' => 'admin_1kfjvb'
    ],
```