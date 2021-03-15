ifdef SIMULATOR
TARGET = simulator:clang:11.2:8.0
ARCHS = x86_64
else
TARGET = iphone:clang:11.2:7.0
	ifeq ($(debug),0)
		ARCHS= armv7 arm64 arm64e
	else
		ARCHS= arm64 arm64e
	endif
endif

INSTALL_TARGET_PROCESSES = SpringBoard



TWEAK_NAME = NoKeyboardSettings

NoKeyboardSettings_FILES = Tweak.xm
NoKeyboardSettings_CFLAGS = -fobjc-arc -Wno-error=unused-variable -Wno-error=unused-function -include Prefix.pch

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
	
setup:: all
	@rm -f /opt/simject/$(TWEAK_NAME).dylib
	@cp -v $(THEOS_OBJ_DIR)/$(TWEAK_NAME).dylib /opt/simject/$(TWEAK_NAME).dylib
	@codesign -f -s - /opt/simject/$(TWEAK_NAME).dylib
	@cp -v $(PWD)/$(TWEAK_NAME).plist /opt/simject
	@resim

remove::
	@rm -f /opt/simject/$(TWEAK_NAME).dylib /opt/simject/$(TWEAK_NAME).plist
	@resim