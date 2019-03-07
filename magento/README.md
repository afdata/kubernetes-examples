# Magento deployment

## Important notes

To build the images please start:

```bash
docker build nginx/. -t registry.example.local:5000/nginx && docker push registry.example.local:5000/nginx
docker build php-fpm/. -t registry.example.local:5000/php-fpm && docker push registry.example.local:5000/php-fpm
```

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