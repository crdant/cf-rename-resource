# Cloud Foundry Route Resource

An output only resource (at the moment) that will create/map/unmap routes for cloud foundry.

## Source Configuration

* `api`: *Required.* The address of the Cloud Controller in the Cloud Foundry
  deployment.
* `username`: *Required.* The username used to authenticate.
* `password`: *Required.* The password used to authenticate.
* `organization`: *Required.* The organization to push the application to.
* `space`: *Required.* The space to push the application to.
* `skip_cert_check`: *Optional.* Check the validity of the CF SSL cert.
  Defaults to `false`.

## Behaviour

### `out`: Create, Map, or Unmap Routes

Creates, maps, or unmaps routes in Cloud Foundry. Mapping and unmapping require an application to be specified. Routes can be created without mapping them to an application as well.

#### Parameters

*N.B. one of `map`, `create`, or `unmap` must be provided*

* `create`: *Required.* One or more routes to create, in the same format as a  route specified in a [Cloud Foundry manifest](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest.html).
* `map`: *Optional.* One or more routes to map to an application, in the same format as a  route specified in a [Cloud Foundry manifest](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest.html). Requires that `application` be specified.
* `unmap`: *Optional.* One or more routes to unmap from an application, in the same format as a  route specified in a [Cloud Foundry manifest](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest.html). Requires that `application` be specified.
* `application`: *Optional.* The name of an application for which to map/unmap the route. Required if `map` or `unmap` is provided.
* `randomPort`: *Optional.* Use a random port when creating a TCP route. Specify only the domain for `create` when using this option.
