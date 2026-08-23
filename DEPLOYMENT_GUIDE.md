## Deployment Guide
After the very first deployment, you need to paste the following commands into `medusa` container:
```sh
cd apps/backend && pnpm medusa user -e uremail@mail.com -p urpassword
```

After running this command, log into the `medusa` container (not `storefront`) by navigating to it's interface and using your credentials to it.

After that do the following:
* Go to Settings > Developer > Publishable API Keys
* Go to `medusa` logs and find the api key (`apk_xxxxxxxxxxxx`) in the request logs
* Paste that sh8 into the Storefront's `NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY` env entry
* Redeploy