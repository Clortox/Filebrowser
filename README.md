# Filebrowser

An extension of [filebrowser](https://filebrowser.org) that allows for some configuration using environment variables.
Intended to be used as a sidecar for kubernetes pods.

## Configuration

| Variable          | Description                                                                        | Default         |
|-------------------|------------------------------------------------------------------------------------|-----------------|
| `ADMIN_PASS`      | `admin` user password                                                              | `admin`         |
| `DEFAULT_USERNAME`| The username for the newly created user                                            | `default`       |
| `DEFAULT_PASSWORD`| The password for the newly created user                                            | `default`       |
| `BRANDING_NAME`   | Name shown on the home screen                                                      | `My file storage`|
| `AUTH_METHOD`     | What [auth method](https://filebrowser.org/configuration/authentication-method) should be used? | `json` |
| `AUTH_HEADER`     | What header should be used for [proxy authentication](https://filebrowser.org/configuration/authentication-method#proxy-header)? | `X-My-Header` |
| `PERM_ADMIN`      | Allow user admin privileges                                                        | `false`         |
| `PERM_EXECUTE`    | Allow user to execute commands                                                     | `false`         |
| `PERM_CREATE`     | Allow user to create files and directories                                         | `false`         |
| `PERM_RENAME`     | Allow user to rename files and directories                                         | `false`         |
| `PERM_MODIFY`     | Allow user to modify files                                                         | `false`         |
| `PERM_DELETE`     | Allow user to delete files                                                         | `false`         |
| `PERM_SHARE`      | Allow user to share files and directories                                          | `false`         |
| `PERM_DOWNLOAD`   | Allow user to download files                                                       | `false`         |
