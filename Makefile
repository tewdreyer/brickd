DESTDIR=

PREFIX  = /usr
BINDIR  = ${PREFIX}/bin
DATADIR = ${PREFIX}/share

quiet-command    = $(if ${V},${1},$(if ${2},@echo ${2} && ${1}, @${1}))
quiet-install    = $(call quiet-command,install -m ${1} ${2} ${3},"INSTALL	${3}")
quiet-installdir = $(call quiet-command,install -m ${1} -d ${2},"MKDIR	${2}")

sed-rules = -e 's,@BRICKD_DIR@,${BRICKD_DIR},'

BRICKD_DIR = ${DATADIR}/brickd
BRICKD_LIBUSB_DIR = ${BRICKD_DIR}/libusb

BRICKD_SHELL += brickd

BRICKD_CORE += __init__.py
BRICKD_CORE += brick_protocol.py
BRICKD_CORE += brickd_linux.py
BRICKD_CORE += config.py
BRICKD_CORE += usb_device.py
BRICKD_CORE += usb_notifier.py

BRICKD_LIBUSB += __init__.py
BRICKD_LIBUSB += libusb1.py
BRICKD_LIBUSB += usb1.py



all: build

build: $(addsuffix .sh, ${BRICKD_SHELL})

%.sh: src/%.sh.in
	$(call quiet-command, sed ${sed-rules} $< > $@, "SED	$@")

install: build install-shell install-python

install-shell: $(addprefix ${DESTDIR}${BINDIR}/, ${BRICKD_SHELL})

install-python: install-python-core install-python-libusb

install-python-core: $(addprefix ${DESTDIR}${BRICKD_DIR}/, ${BRICKD_CORE})

install-python-libusb: $(addprefix ${DESTDIR}${BRICKD_LIBUSB_DIR}/, ${BRICKD_LIBUSB})

${DESTDIR}${BINDIR}/%: %.sh install-dir-bindir
	$(call quiet-install, 0755, $<, $@)

${DESTDIR}${BRICKD_DIR}/%: src/brickd/% install-dir-brickddir
	$(call quiet-install, 0755, $<, $@)

${DESTDIR}${BRICKD_LIBUSB_DIR}/%: src/brickd/libusb/% install-dir-brickdlibusbdir
	$(call quiet-install, 0755, $<, $@)

install-dir-bindir:
	$(call quiet-installdir, 0755, ${DESTDIR}${BINDIR})

install-dir-brickddir:
	$(call quiet-installdir, 0755, ${DESTDIR}${BRICKD_DIR})

install-dir-brickdlibusbdir:
	$(call quiet-installdir, 0755, ${DESTDIR}${BRICKD_LIBUSB_DIR})

clean:
	$(call quiet-command, rm -f $(addsuffix .sh, ${BRICKD_SHELL}), "CLEAN	$(addsuffix .sh, ${BRICKD_SHELL})")
