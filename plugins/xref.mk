# Copyright (c) 2015, Euen Lopez <euen@inakanetworks.com>
# This file is part of erlang.mk and subject to the terms of the ISC License.

.PHONY: xref distclean-xref

# Configuration.

ifeq ($(XREF_CONFIG),)
	XREF_ARGS :=
else
	XREF_ARGS := -c $(XREF_CONFIG)
endif

XREFR ?= $(CURDIR)/xrefr
export XREFR

XREFR_URL ?= https://github.com/inaka/xref_runner/releases/download/0.2.0/xrefr

# Core targets.

help::
	@printf "%s\n" "" \
		"Xref targets:" \
		"	xref				Run Xrefr using $XREF_CONFIG as config file if defined"

distclean:: distclean-xref

# Plugin-specific targets.

$(XREFR):
	@$(call core_http_get,$(XREFR),$(XREFR_URL))
	@chmod +x $(XREFR)

xref: deps app $(XREFR)
	$(gen_verbose) $(XREFR) $(XREFR_ARGS)

distclean-xref:
	$(gen_verbose) rm -rf $(XREFR)
