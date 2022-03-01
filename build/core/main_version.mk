# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_BUILD_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# LineageOS System Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.version=$(LINEAGE_VERSION) \
    ro.lineage.releasetype=$(LINEAGE_BUILDTYPE) \
    ro.lineage.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(LINEAGE_VERSION) \
    ro.lineagelegal.url=https://lineageos.org/legal \
    ro.elegal.url=https://e.foundation/legal

ifdef CI_PIPELINE_ID
    ADDITIONAL_BUILD_PROPERTIES += \
        ro.cm.build.pipeline.id=$(CI_PIPELINE_ID)
endif

ifdef CI_PIPELINE_IID
    ADDITIONAL_BUILD_PROPERTIES += \
        ro.cm.build.pipeline.iid=$(CI_PIPELINE_IID)
endif

# LineageOS Platform Display Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.display.version=$(LINEAGE_DISPLAY_VERSION)

# LineageOS Platform SDK Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.sdk=$(LINEAGE_PLATFORM_SDK_VERSION)

# LineageOS Platform Internal Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.rev=$(LINEAGE_PLATFORM_REV)

# Allow disabling debugging flags set by the build system
# for 3rd party apps support.
ifeq ($(TARGET_BUILD_VARIANT),userdebug)
  ifeq ($(DISABLE_TARGET_DEBUGGING),true)
    ADDITIONAL_BUILD_PROPERTIES += ro.debuggable=0
    ADDITIONAL_BUILD_PROPERTIES += dalvik.vm.lockprof.threshold=0
  endif
endif

