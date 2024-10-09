#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

. /opt/bitnami/scripts/odoo-env.sh

if [[ -f /opt/bitnami/scripts/postgresql-client-env.sh ]]; then
    . /opt/bitnami/scripts/postgresql-client-env.sh
elif [[ -f /opt/bitnami/scripts/postgresql-env.sh ]]; then
    . /opt/bitnami/scripts/postgresql-env.sh
fi

. /opt/bitnami/scripts/libodoo.sh

EXTRA_ADDONS_PATH="$ODOO_BASE_DIR/extraaddons"

for dir in $EXTRA_ADDONS_PATH/*/; do
  ODOO_ADDONS_DIR="$ODOO_ADDONS_DIR,${dir%/}"
done

if [ -n "$EXTRA_ADDONS_URLS_TO_PULL" ]; then
  EXTRA_ADDONS_PULLED_DIR=$ODOO_VOLUME_DIR/extraaddons
  mkdir -p $EXTRA_ADDONS_PULLED_DIR
  IFS=",";
  for addon_pull_url in $EXTRA_ADDONS_URLS_TO_PULL; do
    if [[ $addon_pull_url == "git://"* ]]; then
      package_value=${addon_pull_url#"git://"}
      branch_name=${package_value%%"//"*}
      git_address=${package_value#*"//"}
      repo_name=$(basename $git_address)
      repo_name=${repo_name%.*}

      if ! [ -d $EXTRA_ADDONS_PULLED_DIR/$repo_name ]; then
        git clone --depth 1 -b ${branch_name} ${git_address} $EXTRA_ADDONS_PULLED_DIR/$repo_name
      fi
      if [ -f $EXTRA_ADDONS_PULLED_DIR/$repo_name/requirements.txt ]; then
        source $ODOO_BASE_DIR/venv/bin/activate;
        pip install -f $EXTRA_ADDONS_PULLED_DIR/$repo_name/requirements.txt
        deactivate
      fi
    # elif [[ ${PACKAGES_VALUES[i]} == "file://"* ]]; then
    # TBD: Define other prefixes.
    fi
  done
  unset IFS
  for addon_dir in $EXTRA_ADDONS_PULLED_DIR/*/*/; do
    if ! [ -e $ODOO_VOLUME_DIR/addons/$(basename $addon_dir) ]; then
      ln -s ${addon_dir%/} $ODOO_VOLUME_DIR/addons/$(basename $addon_dir)
    fi
  done
fi

list_db="$(is_boolean_yes "${ODOO_LIST_DB:-no}" && echo 'True' || echo 'False')"
odoo_debug="$(is_boolean_yes "$BITNAMI_DEBUG" && echo 'True' || echo 'False')"

odoo_conf_set "db_host" "$ODOO_DATABASE_HOST"
odoo_conf_set "db_name" "$ODOO_DATABASE_NAME"
odoo_conf_set "db_password" "$ODOO_DATABASE_PASSWORD"
odoo_conf_set "db_port" "$ODOO_DATABASE_PORT_NUMBER"
odoo_conf_set "db_user" "$ODOO_DATABASE_USER"
odoo_conf_set "list_db" "$list_db"
odoo_conf_set "dbfilter" "$ODOO_DATABASE_FILTER"

odoo_conf_set "debug_mode" "$odoo_debug"
odoo_conf_set "email_from" "$ODOO_EMAIL"

odoo_conf_set "addons_path" "$ODOO_ADDONS_DIR"
odoo_conf_set "limit_time_real" "$LIMIT_TIME_REAL"
odoo_conf_set "log_db" "$LOG_DB"
odoo_conf_set "log_handler" "$LOG_HANDLER"
odoo_conf_set "server_wide_modules" "$SERVER_WIDE_MODULES"

if [ -n "$OPENG2P_SMTP_PORT" ] ; then
  odoo_conf_set "smtp_port" "$OPENG2P_SMTP_PORT"
fi

if [ -n "$OPENG2P_SMTP_HOST" ] ; then
  odoo_conf_set "smtp_server" "$OPENG2P_SMTP_HOST"
fi
