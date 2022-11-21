XBUILD=/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild
ROOT=$(PWD)
PROJECT_PROXY_ROOT=$(ROOT)/../external/NukeProxy
PROJECT_ROOT=$(ROOT)/../external/Nuke
PROJECT=$(PROJECT_ROOT)/Nuke.xcodeproj
PROJECT_PROXY=$(PROJECT_PROXY_ROOT)/NukeProxy.xcodeproj
BUILD_ROOT=$(PROJECT_ROOT)/build
BUILD_PROXY_ROOT=$(PROJECT_PROXY_ROOT)/build
TARGET_NUKE=Nuke
TARGET_NUKEEXTENSIONS="Nuke Extensions"
TARGET_NUKEUI="NukeUI"
TARGET_NUKEPROXY=NukeProxy
PROJECTNAME=Nuke
OUTPUT=$(ROOT)/Build
FRAMEWORK_PATH=Products/Library/Frameworks/Nuke.framework
FRAMEWORK_EXTENSIONS_PATH=Products/Library/Frameworks/NukeExtensions.framework
FRAMEWORK_UI_PATH=Products/Library/Frameworks/NukeUI.framework
FRAMEWORK_PROXY_PATH=Products/Library/Frameworks/NukeProxy.framework
BINDING_PROJECT=$(ROOT)/Nuke.Binding/Nuke.Binding
FRAMEWORKS=$(ROOT)/Frameworks
FRAMEWORKS_IOS=$(ROOT)/Frameworks/ios
FRAMEWORKS_MAC=$(ROOT)/Frameworks/mac
FRAMEWORKS_TVOS=$(ROOT)/Frameworks/tvos

all: build_nuke build_nuke_extensions build_nuke_ui build_nuke_proxy

binding-mac:
	sharpie bind --sdk=macosx13.0 --output="$(BUILD_PROXY_ROOT)/XamarinApiDef" --namespace="Drastic.Nuke" --scope="$(BUILD_PROXY_ROOT)/mac_proxy.xcarchive/$(FRAMEWORK_PROXY_PATH)/Headers/" "$(BUILD_PROXY_ROOT)/mac_proxy.xcarchive/$(FRAMEWORK_PROXY_PATH)/Headers/NukeProxy-Swift.h"

binding-ios:
	sharpie bind --sdk=iphoneos16.1 --output="$(BUILD_PROXY_ROOT)/XamarinApiDef" --namespace="Drastic.Nuke" --scope="$(BUILD_PROXY_ROOT)/simulator_proxy.xcarchive/$(FRAMEWORK_PROXY_PATH)/Headers/" "$(BUILD_PROXY_ROOT)/simulator_proxy.xcarchive/$(FRAMEWORK_PROXY_PATH)/Headers/NukeProxy-Swift.h"

build_nuke: build_nuke_watchossimulator build_nuke_watchosdevice build_nuke_iossimulator build_nuke_iosdevice build_nuke_maccatalyst build_nuke_tvossimulator build_nuke_tvosdevice build_nuke_mac build_nuke_xcframework

build_nuke_extensions: build_nuke_extensions_watchossimulator build_nuke_extensions_watchosdevice build_nuke_extensions_iossimulator build_nuke_extensions_iosdevice build_nuke_extensions_maccatalyst build_nuke_extensions_tvossimulator build_nuke_extensions_tvosdevice build_nuke_extensions_mac build_nuke_extensions_xcframework

build_nuke_ui: build_nuke_ui_watchossimulator build_nuke_ui_watchosdevice build_nuke_ui_iossimulator build_nuke_ui_iosdevice build_nuke_ui_maccatalyst build_nuke_ui_tvossimulator build_nuke_ui_tvosdevice build_nuke_ui_mac build_nuke_ui_xcframework

build_nuke_proxy: build_nuke_proxy_iossimulator build_nuke_proxy_iosdevice build_nuke_proxy_maccatalyst build_nuke_proxy_tvossimulator build_nuke_proxy_tvosdevice build_nuke_proxy_mac build_nuke_proxy_xcframework

build_nuke_proxy_iossimulator:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT_PROXY) -scheme $(TARGET_NUKEPROXY) -destination "generic/platform=iOS Simulator" -archivePath $(BUILD_PROXY_ROOT)/simulator_proxy.xcarchive -sdk iphonesimulator SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_proxy_iosdevice:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT_PROXY) -scheme $(TARGET_NUKEPROXY) -destination "generic/platform=iOS" -archivePath $(BUILD_PROXY_ROOT)/iOS_proxy.xcarchive -sdk iphoneos SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_proxy_maccatalyst:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT_PROXY) -scheme $(TARGET_NUKEPROXY) -destination "generic/platform=macOS,variant=Mac Catalyst" -archivePath $(BUILD_PROXY_ROOT)/catalyst_proxy.xcarchive SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_proxy_tvossimulator:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT_PROXY) -scheme $(TARGET_NUKEPROXY) -archivePath $(BUILD_PROXY_ROOT)/tvsimulator_proxy.xcarchive -sdk appletvsimulator SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_proxy_tvosdevice:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT_PROXY) -scheme $(TARGET_NUKEPROXY) -archivePath $(BUILD_PROXY_ROOT)/tvos.xcarchive -sdk appletvos SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_proxy_mac:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT_PROXY) -scheme $(TARGET_NUKEPROXY) -destination "generic/platform=macOS,name=Any Mac" -archivePath $(BUILD_PROXY_ROOT)/mac_proxy.xcarchive SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_proxy_xcframework:
	rm -rf $(BUILD_PROXY_ROOT)/NukeProxy.xcframework
	$(XBUILD) -create-xcframework -framework $(BUILD_PROXY_ROOT)/simulator_proxy.xcarchive/$(FRAMEWORK_PROXY_PATH) -framework $(BUILD_PROXY_ROOT)/tvsimulator_proxy.xcarchive/$(FRAMEWORK_PROXY_PATH) -framework $(BUILD_PROXY_ROOT)/tvos.xcarchive/$(FRAMEWORK_PROXY_PATH) -framework $(BUILD_PROXY_ROOT)/mac_proxy.xcarchive/$(FRAMEWORK_PROXY_PATH) -framework $(BUILD_PROXY_ROOT)/iOS_proxy.xcarchive/$(FRAMEWORK_PROXY_PATH) -framework $(BUILD_PROXY_ROOT)/catalyst_proxy.xcarchive/$(FRAMEWORK_PROXY_PATH) -output $(BUILD_PROXY_ROOT)/NukeProxy.xcframework
	rm -rf $(FRAMEWORKS)/NukeProxy.xcframework
	mkdir -p $(FRAMEWORKS)
	mv $(BUILD_PROXY_ROOT)/NukeProxy.xcframework $(FRAMEWORKS)/NukeProxy.xcframework

build_nuke_watchossimulator:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKE) -destination "generic/platform=watchOS Simulator" -archivePath $(BUILD_ROOT)/watchsimulator.xcarchive -sdk watchsimulator SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_watchosdevice:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKE) -destination "generic/platform=watchOS" -archivePath $(BUILD_ROOT)/watchOS.xcarchive -sdk watchos SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_iossimulator:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKE) -destination "generic/platform=iOS Simulator" -archivePath $(BUILD_ROOT)/simulator.xcarchive -sdk iphonesimulator SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_iosdevice:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKE) -destination "generic/platform=iOS" -archivePath $(BUILD_ROOT)/iOS.xcarchive -sdk iphoneos SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_maccatalyst:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKE) -destination "generic/platform=macOS,variant=Mac Catalyst" -archivePath $(BUILD_ROOT)/catalyst.xcarchive SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_tvossimulator:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKE) -archivePath $(BUILD_ROOT)/tvsimulator.xcarchive -sdk appletvsimulator SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_tvosdevice:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKE) -archivePath $(BUILD_ROOT)/tvos.xcarchive -sdk appletvos SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_mac:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKE) -destination "generic/platform=macOS,name=Any Mac" -archivePath $(BUILD_ROOT)/mac.xcarchive SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_xcframework:
	rm -rf $(BUILD_ROOT)/Nuke.xcframework
	$(XBUILD) -create-xcframework -framework $(BUILD_ROOT)/watchsimulator.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/watchOS.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/simulator.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/tvsimulator.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/tvos.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/mac.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/iOS.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/catalyst.xcarchive/$(FRAMEWORK_PATH) -output $(BUILD_ROOT)/Nuke.xcframework
	rm -rf $(FRAMEWORKS)/Nuke.xcframework
	mkdir -p $(FRAMEWORKS)
	mv $(BUILD_ROOT)/Nuke.xcframework $(FRAMEWORKS)/Nuke.xcframework

build_nuke_extensions_watchossimulator:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEEXTENSIONS) -destination "generic/platform=watchOS Simulator" -archivePath $(BUILD_ROOT)/watchsimulator_extensions.xcarchive -sdk watchsimulator SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_extensions_watchosdevice:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEEXTENSIONS) -destination "generic/platform=watchOS" -archivePath $(BUILD_ROOT)/watchOS_extensions.xcarchive -sdk watchos SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_extensions_iossimulator:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEEXTENSIONS) -destination "generic/platform=iOS Simulator" -archivePath $(BUILD_ROOT)/simulator_extensions.xcarchive -sdk iphonesimulator SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_extensions_iosdevice:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEEXTENSIONS) -destination "generic/platform=iOS" -archivePath $(BUILD_ROOT)/iOS_extensions.xcarchive -sdk iphoneos SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_extensions_maccatalyst:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEEXTENSIONS) -destination "generic/platform=macOS,variant=Mac Catalyst" -archivePath $(BUILD_ROOT)/catalyst_extensions.xcarchive SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_extensions_tvossimulator:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEEXTENSIONS) -archivePath $(BUILD_ROOT)/tvsimulator_extensions.xcarchive -sdk appletvsimulator SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_extensions_tvosdevice:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEEXTENSIONS) -archivePath $(BUILD_ROOT)/tvos_extensions.xcarchive -sdk appletvos SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_extensions_mac:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEEXTENSIONS) -destination "generic/platform=macOS,name=Any Mac" -archivePath $(BUILD_ROOT)/mac_extensions.xcarchive SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_extensions_xcframework:
	rm -rf $(BUILD_ROOT)/NukeExtensions.xcframework
	$(XBUILD) -create-xcframework -framework $(BUILD_ROOT)/watchsimulator_extensions.xcarchive/$(FRAMEWORK_EXTENSIONS_PATH) -framework $(BUILD_ROOT)/watchOS_extensions.xcarchive/$(FRAMEWORK_EXTENSIONS_PATH) -framework $(BUILD_ROOT)/simulator_extensions.xcarchive/$(FRAMEWORK_EXTENSIONS_PATH) -framework $(BUILD_ROOT)/tvsimulator_extensions.xcarchive/$(FRAMEWORK_EXTENSIONS_PATH) -framework $(BUILD_ROOT)/tvos_extensions.xcarchive/$(FRAMEWORK_EXTENSIONS_PATH) -framework $(BUILD_ROOT)/mac_extensions.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/iOS_extensions.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/catalyst_extensions.xcarchive/$(FRAMEWORK_PATH) -output $(BUILD_ROOT)/NukeExtensions.xcframework
	rm -rf $(FRAMEWORKS)/NukeExtensions.xcframework
	mkdir -p $(FRAMEWORKS)
	mv $(BUILD_ROOT)/NukeExtensions.xcframework $(FRAMEWORKS)/NukeExtensions.xcframework

build_nuke_ui_watchossimulator:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEUI) -destination "generic/platform=watchOS Simulator" -archivePath $(BUILD_ROOT)/watchsimulator_ui.xcarchive -sdk watchsimulator SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_ui_watchosdevice:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEUI) -destination "generic/platform=watchOS" -archivePath $(BUILD_ROOT)/watchOS_ui.xcarchive -sdk watchos SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_ui_iossimulator:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEUI) -destination "generic/platform=iOS Simulator" -archivePath $(BUILD_ROOT)/simulator_ui.xcarchive -sdk iphonesimulator SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_ui_iosdevice:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEUI) -destination "generic/platform=iOS" -archivePath $(BUILD_ROOT)/iOS_ui.xcarchive -sdk iphoneos SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_ui_maccatalyst:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEUI) -destination "generic/platform=macOS,variant=Mac Catalyst" -archivePath $(BUILD_ROOT)/catalyst_ui.xcarchive SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_ui_tvossimulator:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEUI) -archivePath $(BUILD_ROOT)/tvsimulator_ui.xcarchive -sdk appletvsimulator SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_ui_tvosdevice:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEUI) -archivePath $(BUILD_ROOT)/tvos_ui.xcarchive -sdk appletvos SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_ui_mac:
	$(XBUILD) archive ONLY_ACTIVE_ARCH=NO -project $(PROJECT) -scheme $(TARGET_NUKEUI) -destination "generic/platform=macOS,name=Any Mac" -archivePath $(BUILD_ROOT)/mac_ui.xcarchive SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

build_nuke_ui_xcframework:
	rm -rf $(BUILD_ROOT)/NukeUI.xcframework
	$(XBUILD) -create-xcframework -framework $(BUILD_ROOT)/watchsimulator_ui.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/watchOS_ui.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/simulator_ui.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/tvsimulator_ui.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/tvos.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/mac_ui.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/iOS_ui.xcarchive/$(FRAMEWORK_PATH) -framework $(BUILD_ROOT)/catalyst_ui.xcarchive/$(FRAMEWORK_PATH) -output $(BUILD_ROOT)/NukeUI.xcframework
	rm -rf $(FRAMEWORKS)/NukeUI.xcframework
	mkdir -p $(FRAMEWORKS)
	mv $(BUILD_ROOT)/NukeUI.xcframework $(FRAMEWORKS)/NukeUI.xcframework

