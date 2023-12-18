#!/bin/sh

# Set default values for environment variables if they are not set
ADMIN_PASS=${ADMIN_PASS:-admin}
DEFAULT_USERNAME=${DEFAULT_USERNAME:-default}
DEFAULT_PASSWORD=${DEFAULT_PASSWORD:-default}
BRANDING_NAME=${BRANDING_NAME:-"My file storage"}
AUTH_METHOD=${AUTH_METHOD:-json}
AUTH_HEADER=${AUTH_HEADER:-"X-My-Header"}

# Set default values for permission-related environment variables
PERM_ADMIN=${PERM_ADMIN:-false}
PERM_EXECUTE=${PERM_EXECUTE:-false}
PERM_CREATE=${PERM_CREATE:-false}
PERM_RENAME=${PERM_RENAME:-false}
PERM_MODIFY=${PERM_MODIFY:-false}
PERM_DELETE=${PERM_DELETE:-false}
PERM_SHARE=${PERM_SHARE:-false}
PERM_DOWNLOAD=${PERM_DOWNLOAD:-false}

# Initialize Filebrowser if it's the first run
if [ ! -f /database.db ]; then
    echo "Init the local database..."
    ./filebrowser config init
    ./filebrowser users add admin "$ADMIN_PASS" --perm.admin
fi

# Update the admin password in case it changes
echo "Update the admin user\'s password"
./filebrowser users update admin --password "$ADMIN_PASS"

# Check if DEFAULT_USERNAME is "admin" and error out if it is
if [ "$DEFAULT_USERNAME" = "admin" ]; then
    echo "Error: DEFAULT_USERNAME cannot be 'admin'. Please choose a different username."
    exit 1
fi

# Create the default user (assuming it does not exist)
./filebrowser users add "$DEFAULT_USERNAME" "$DEFAULT_PASSWORD" --perm.admin="$PERM_ADMIN" --perm.execute="$PERM_EXECUTE" --perm.create="$PERM_CREATE" --perm.rename="$PERM_RENAME" --perm.modify="$PERM_MODIFY" --perm.delete="$PERM_DELETE" --perm.share="$PERM_SHARE" --perm.download="$PERM_DOWNLOAD"


# Set branding name
echo "Set branding"
./filebrowser config set --branding.name "$BRANDING_NAME"

# Set authentication method
echo "Set authentication method"
case "$AUTH_METHOD" in
    "json")
        ./filebrowser config set --auth.method=json
        ;;
    "proxy")
        ./filebrowser config set --auth.method=proxy --auth.header="$AUTH_HEADER"
        ;;
    *)
        echo "Invalid AUTH_METHOD. Using default 'json'."
        ./filebrowser config set --auth.method=json
        ;;
esac

echo "--------- Configuration complete ----------"

echo "Configuration JSON:"
cat ./.filebrowswer.json

# Run Filebrowser
exec ./filebrowser -d /database.db
