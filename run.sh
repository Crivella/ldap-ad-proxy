#!/bin/ash

LOG_LEVEL=$(($LOG_LEVEL & 4093))

# Set default suffix as basedn
[[ -z "${META_SUFFIX}" ]] && export META_SUFFIX=${AD_BASEDN}

if [[ ${ROOTPW} == "" ]]; then
	echo "ERROR: Must set the ROOTPW variable..."
	exit
fi

# make config from env
envsubst < /tmp/slapd.conf > slapd.conf

# test config and run openldap
mkdir -p slapd.test \
&& slaptest -d7 -f slapd.conf -F slapd.test -u \
&& rm -rf slapd.d \
&& mv slapd.test slapd.d \
&& chown -R ldap.ldap slapd.d

exec "$@"
