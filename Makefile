# Copyright (c) 2014 The re2c Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file. See the AUTHORS file for names of contributors.
###############################################################################

all test check sample clean install uninstall: platform-deps
	cd src && $(MAKE) $@

platform-deps:
	sh ./tools/configure.sh build_config.mk .

distclean:
	rm -f src/*.o src/re2c src/re2c_*
	find . -name \*.o -type f |xargs rm -f
	find . -name \*~ -type f |xargs rm -f
	find . -name \*.bak -type f |xargs rm -f


