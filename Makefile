DC=docker-compose run --rm app sh

abuild:
	$(DC) -c "cd /home/builder/aports/$(PKG) && abuild -r"

dev:
	$(DC) -c "cd /home/builder/aports/$(PKG) && abuild -K deps && sh -i"

build:
	mkdir -p .cache/ .distfiles/ packages/
	docker-compose build

checksum:
	$(DC) -c "cd /home/builder/aports/$(PKG) && abuild checksum"

clean:
	rm -rf packages/*

clean-all: clean
	rm -rf .cache/* .distfiles/*

shell:
	$(DC)

update:
	$(DC) -c "apk update"

PKGNAME ?= NAME
PKGDESC ?= DESCRIPTION
PKGLIC  ?= LICENSE
PKGURL  ?= URL
PKGSRC  ?= SOURCE

new:
	$(DC) -c "cd /home/builder/aports/testing \
	  && newapkbuild -n $(PKGNAME) -d \"$(PKGDESC)\" -l $(PKGLIC) \
		   -u $(PKGURL) $(PKGSRC)"
