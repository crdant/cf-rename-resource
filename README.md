# Cloud Foundry Rename Resource

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

### `out`: Rename an application

Renames an application in Cloud Foundry.

#### Parameters

* `currentName`: *Required.* The current name of the application.
* `newName`: *Required.* The name you'd like to give the application.
