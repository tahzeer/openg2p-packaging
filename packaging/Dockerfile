ARG BASE_VERSION="17.0-20250807"
FROM odoo:$BASE_VERSION

ARG PACKAGES_TMPDIR=tmpdir
ARG EXTRA_ADDONS_DIR=/opt/odoo/extraaddons
ARG MODULES_TO_REMOVE
ARG MODULES_TO_REMOVE_PATHS=/usr/lib/python3/dist-packages/odoo/addons,${EXTRA_ADDONS_DIR}/*

USER root

RUN ln -s $(which python3) /usr/bin/python

ADD ${PACKAGES_TMPDIR} ${EXTRA_ADDONS_DIR}
ADD odoo.conf.tpl /etc/odoo

ADD docker-build.sh /
ADD docker-build.d /docker-build.d
RUN /docker-build.sh
RUN rm -rf /docker-build.sh /docker-build.d

ADD docker-entrypoint.sh /entrypoint.sh
ADD docker-entrypoint.d /docker-entrypoint.d

USER odoo
