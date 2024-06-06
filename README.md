
# Dynatrace + k6 Hands on Demo

This demo will run a k6 script and use the dynatrace output plugin to stream metrics to Dynatrace.

## Compatibility

| Deployment         | Tutorial Compatible |
|--------------------|---------------------|
| Dynatrace Managed  | ✔️                 |
| Dynatrace SaaS     | ✔️                 |
| Dynatrace Platform | ✔️                 |

## Gather Details: Tenant ID

You will need access to a Dynatrace tenant. If you do not have access, [sign up for a free 15 day trial](https://dt-url.net/trial).

Make a note of your Dynatrace tenant ID. It is the first bit of your URL (eg. `abc12345` in the following examples):

```
https://abc12345.live.dynatrace.com
https://abc12345.apps.dynatrace.com
```

Reformat the URL like this: `https://TENANT_ID.live.dynatrace.com` eg. `https://abc12345.live.dynatrace.com`

## Gather Details: Create API Token

k6 requires an API token to stream metrics to Dynatrace.

Create an API token with `metrics.ingest` permissions.

## Start Demo

1. Fork this repository into your Github account
1. Click the green "Code" button
1. Switch to the `Codespaces` tab
1. Click the three dots `...`
1. Choose `New with options...`
1. Enter your Tenant URL and API token (these will be encrypted and stored as secrets)
1. Wait for the demo to start

## Import Dynatrace Dashboad (Dynatrace platform only)

While you are waiting for the environment, add the dashboard to your Dynatrace environment.

1. Save the [k6 dashboard](dashboards/Grafana%20k6%20Dashboard.json) to your local machine.
1. In Dynatrace, navigate to `Dashboards` and click `Upload`
1. Upload the dashboard JSON file

## Start k6

In the codespace terminal, type `docker ps` and wait until Docker is running.
You should see this:

```
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

Now run k6 with the demo script. Copy and paste this as-is into the terminal window:

```
docker run \
    -e K6_DYNATRACE_URL=$DT_URL \
    -e K6_DYNATRACE_APITOKEN=$DT_K6_TOKEN \
    --mount type=bind,source=./k6scripts,target=/k6scripts hrexed/xk6-dynatrace-output:0.11 run /k6scripts/script.js \
    -o output-dynatrace
```

## View statistics

![dynatrace k6 dashboard](images/k6-dashboard.png)

Metrics should soon (with a minute or two) begin streaming into Dynatrace and the dashboard should populate.

To see the raw list of metrics, head to the `Metrics` screen (Ctrl + k and search for `metrics`) then type `k6`.

![dynatrace k6 metrics screen](images/k6-metrics.png)

## Cleanup

The demo environment is disposable. Head to [GitHub Codespaces](https://github.com/codespaces) and delete the running codespace. This will prevent any unexpected charges.