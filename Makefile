APP ?= ldap-ad-proxy
REPO ?= netaskd

.PHONY:  build start stop exec log

all: build

restart: stop start exec

build:
	@docker build -t ${APP} .
	

start:
	@docker run -d \
	--name ${APP} \
	-p 389:389 \
	-p 636:636 \
	${APP} \
	/run.sh
stop:
	@docker rm -fv ${APP}

exec:
	@docker exec -it ${APP} bash

log:
	@docker logs -f ${APP}
