# Helm Charts

This repository contains the Helm charts for the invididual components and the umbrella
chart for the full stack of components.

The deployed components are:

* GPP-App
* GPP-Burgerportaal
* GPP-Publicatiebank
* Open Zaak

## Requirements

The requirements listed here are not included in the charts and you're responsible for
provisioning them yourself.

* PostgreSQL database (version 13 or higher, 16 (latest) is recommended)
* An OpenID Connect identity provider for Single Sign On (optional)

## Cheat sheet

```bash
helm repo add gpp-woo https://GPP-Woo.github.io/charts
helm repo update
helm install \
    -f myvalues.yml \
    my-gpp-woo \
    gpp-woo/gpp-stack
```

Assuming a values file ``myvalues.yml`` was created.
