# Filebrowser

An specfic contianer build of [filebrowser](https://filebrowser.org) that allows for some configuration using environment variables.
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

## Run the container

Find instructions on pulling the container [here](https://git.clortox.com/Infrastructure/-/packages/container/filebrowser/latest).
You can also build the container locally by running the docker compose included with this repository

```bash
docker compose up
# Older docker compose
docker-compose up
```

## Run as a sidecar in k8s

I use this container as a k3s/k8s sidecar container, to provide a nice interface to the contents of specific longhorn
volumes (such as plex, or minecraft servers). Below I have included a sample deployment definition. Be sure to place
secrets in a [kubernetes secret](https://kubernetes.io/docs/concepts/configuration/secret/)!


```yaml
containers:
  - name: filebrowser
    image: git.clortox.com/infrastructure/filebrowser:latest
    securityContext:
      runAsUser: 1000
      runAsGroup: 1000
    env:
      - name: ADMIN_PASS
        value: "admin"
      - name: DEFAULT_USERNAME
        value: "user"
      - name: DEFAULT_PASSWORD
        value: "password"
      - name: BRANDING_NAME
        value: "My File Storage"
      - name: AUTH_METHOD
        value: "json"
      - name: AUTH_HEADER
        value: "X-My-Header"
      - name: PERM_ADMIN
        value: "false"
      - name: PERM_EXECUTE
        value: "false"
      - name: PERM_CREATE
        value: "false"
      - name: PERM_RENAME
        value: "false"
      - name: PERM_MODIFY
        value: "false"
      - name: PERM_DELETE
        value: "false"
      - name: PERM_SHARE
        value: "false"
      - name: PERM_DOWNLOAD
        value: "false"
    volumeMounts:
      - name: volume-name
        mountPath: /path/to/mount
```

Note however that if you want to use a reverse proxy like [Authentik](https://goauthentik.io) for your authentication,
you will need to update the [auth method](https://filebrowser.org/configuration/authentication-method#proxy-header)

## Mirrors

This repository is activly maintained on my [gitea](https://git.clortox.com/Infrastructure/Filebrowser).
However you can find a [github mirror](https://github.com/Clortox/Filebrowser) as well.
