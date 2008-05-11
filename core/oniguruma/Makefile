ONIGURUMA_VERSION=onig-5.9.1
OS_VERSION=$(shell uname -r)
BUILD_DIR=universal
BUILD_CONFIGURE_FLAGS=--disable-dependency-tracking --host=i686-apple-darwin$(OS_VERSION) --build=i686-apple-darwin$(OS_VERSION)
BUILD_SDK=/Developer/SDKs/MacOSX10.4u.sdk
BUILD_CC=gcc
ONIG_TARGET=libonig.la
LIBS_DIR=.libs
ONIGURUMA=libonig.a

all: $(BUILD_DIR)/$(ONIGURUMA)

$(BUILD_DIR)/$(ONIGURUMA): $(BUILD_DIR)/$(ONIG_TARGET)
	lipo -create $(BUILD_DIR)/$(LIBS_DIR)/$(@F) -output $(BUILD_DIR)/$(@F)

$(BUILD_DIR)/$(ONIG_TARGET): $(BUILD_DIR)
	cd $(@D);\
	CC="$(BUILD_CC)" ./configure $(BUILD_CONFIGURE_FLAGS);\
	perl -pi -e 's@CFLAGS =@CFLAGS = -isysroot $(BUILD_SDK) -arch i386 -arch ppc -arch x86_64 -arch ppc64@' Makefile;\
	perl -pi -e 's@-dynamiclib@-dynamiclib -arch i386 -arch ppc -arch x86_64 -arch ppc64@g' libtool;\
	make $(@F)

$(BUILD_DIR):
	tar xzvf $(ONIGURUMA_VERSION).tar.gz
	mv $(ONIGURUMA_VERSION) $@

clean:
	rm -rf $(BUILD_DIR)
