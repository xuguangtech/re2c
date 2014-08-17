# Copyright (c) 2014 The re2c Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file. See the AUTHORS file for names of contributors.
###############################################################################

include ../build_config.mk

CC_bin= re2c

CC_bin_SRC_cc= \
	code.cc \
	dfa.cc \
	bootstrap/parser.cc \
	actions.cc \
	substr.cc \
	translate.cc \
	bootstrap/scanner.cc \
	mbo_getopt.cc \
	main.cc

RE2C_HEADER_DIR= .

MY_COMMON_FLAGS= -I $(RE2C_HEADER_DIR)
MY_CXXFLAGS= -DHAVE_CONFIG_H

RE2C_HEADERS= \
	$(RE2C_HEADER_DIR)/basics.h \
	$(RE2C_HEADER_DIR)/code_names.h \
	$(RE2C_HEADER_DIR)/config_w32.h \
	$(RE2C_HEADER_DIR)/globals.h \
	$(RE2C_HEADER_DIR)/mbo_getopt.h \
	$(RE2C_HEADER_DIR)/re.h \
	$(RE2C_HEADER_DIR)/stream_lc.h \
	$(RE2C_HEADER_DIR)/token.h \
	$(RE2C_HEADER_DIR)/code.h \
	$(RE2C_HEADER_DIR)/config.h \
	$(RE2C_HEADER_DIR)/dfa.h \
	$(RE2C_HEADER_DIR)/ins.h \
	$(RE2C_HEADER_DIR)/parser.h \
	$(RE2C_HEADER_DIR)/scanner.h \
	$(RE2C_HEADER_DIR)/substr.h \
	$(RE2C_HEADER_DIR)/bootstrap/y.tab.h


all $(CC_bin): cc_bin

check: test

top_srcdir = .
YACC       = yacc
YFLAGS     = -d
PACKAGE_VERSION = 0.13.6

parser.cc: $(top_srcdir)/parser.y
	@$(YACC) $(YFLAGS) $(top_srcdir)/parser.y || exit
	@cat y.tab.c | sed -e 's/"y\.tab\.c"/"parser.cc"/g' -e 's/"\.\/parser\.y"/"parser.y"/g' > $(top_srcdir)/parser.cc
	@rm -f y.tab.c
	@mv -f y.tab.h y.tab.c
	@cat y.tab.c | sed -e 's/"\.\/parser\.y"/"parser.y"/g' > y.tab.h
	@rm -f y.tab.c
	@if cmp -s $(top_srcdir)/parser.cc $(top_srcdir)/bootstrap/parser.cc; then :; else cp -f $(top_srcdir)/parser.cc $(top_srcdir)/bootstrap/parser.cc; fi
	@if cmp -s y.tab.h $(top_srcdir)/y.tab.h; then :; else mv -f y.tab.h $(top_srcdir)/y.tab.h; fi
	@if cmp -s $(top_srcdir)/y.tab.h $(top_srcdir)/bootstrap/y.tab.h; then :; else cp -f $(top_srcdir)/y.tab.h $(top_srcdir)/bootstrap/y.tab.h; fi

scanner.cc: $(top_srcdir)/scanner.re
	@if test -x ./re2c$(EXEEXT); then \
		echo "re2c $(RE2CFLAGS) -o $@ $(top_srcdir)/scanner.re"; \
		./re2c $(RE2CFLAGS) -o $@ $(top_srcdir)/scanner.re && cp $@ $(top_srcdir)/bootstrap/; \
	else \
		echo "cp -f $(top_srcdir)/bootstrap/$@ $@"; \
		cp -f $(top_srcdir)/bootstrap/$@ $@; \
	fi

version:
	echo "re2c $(PACKAGE_VERSION)" > ../VERSION

TESTS = ../tools/run_tests.sh

test: all $(TESTS)
	test -x $(TESTS) || chmod +x $(TESTS)
	./$(TESTS)

vtest: all $(TESTS)
	test -x $(TESTS) || chmod +x $(TESTS)
	./$(TESTS) --valgrind


.PHONY: install uninstall

install: $(CC_bin) 
	mkdir -p $(DESTDIR)/usr/local/bin
	install -p $(INSTALL_FLAGS) -m 0644 -o root $(CC_bin) $(DESTDIR)/usr/local/bin

uninstall:
	rm -rf $(DESTDIR)/usr/local/bin/$(CC_bin)

include ./Makefile.inc


