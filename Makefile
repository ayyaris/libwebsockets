# Copyright (C) 2013 Ayyari Abdennaby <info@ayyari.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk

PKG_NAME:=libwebsockets
PKG_VERSION:=5b479ac2f1cb7d8a9ded478b99c8257852317ab2
PKG_RELEASE=$(PKG_SOURCE_VERSION)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://git.warmcat.com/libwebsockets
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
CMAKE_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/libwebsockets
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=libwebsockets
  DEPENDS:= +zlib +libopenssl
endef

TARGET_CFLAGS += -I$(STAGING_DIR)/usr/include

define Package/libwebsockets/description
  C Websockets Server Library, this package only installs the library and a test application.
endef


define Build/InstallDev
  $(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/lib/libwebsockets.h $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_BUILD_DIR)/lib/libwebsockets.{a,so*} $(1)/usr/lib/	
endef

define Package/libwebsockets/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/share/libwebsockets-test-server
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/libwebsockets-test-server $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libwebsockets.{a,so*} $(1)/usr/lib/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/share/libwebsockets-test-server/test.html $(1)/usr/share/libwebsockets-test-server
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/share/libwebsockets-test-server/favicon.ico $(1)/usr/share/libwebsockets-test-server
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/share/libwebsockets-test-server/libwebsockets-test-server.key.pem $(1)/usr/share/libwebsockets-test-server
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/share/libwebsockets-test-server/libwebsockets-test-server.pem $(1)/usr/share/libwebsockets-test-server
endef

$(eval $(call BuildPackage,libwebsockets))
