ANDROID_LETTER := s
PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 12
PRODUCT_VERSION_MAINTENANCE := 2
PRODUCT_PRERELEASE_STRING = ""

ifdef PRODUCT_PRERELEASE
    ifdef PRODUCT_PRERELEASE_VERSION
        PRODUCT_PRERELEASE_STRING = -$(PRODUCT_PRERELEASE).$(PRODUCT_PRERELEASE_VERSION)
    else
        PRODUCT_PRERELEASE_STRING = -$(PRODUCT_PRERELEASE)
    endif
endif

ifeq ($(LINEAGE_VERSION_APPEND_TIME_OF_DAY),true)
    LINEAGE_BUILD_DATE := $(shell date -u +%Y%m%d_%H%M%S)
else
    LINEAGE_BUILD_DATE := $(shell date -u +%Y%m%d)
endif

# Set LINEAGE_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef LINEAGE_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "LINEAGE_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^LINEAGE_||g')
        LINEAGE_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter test dev stable,$(LINEAGE_BUILDTYPE)),)
    LINEAGE_BUILDTYPE := UNOFFICIAL
    LINEAGE_EXTRAVERSION :=
endif

ifeq ($(LINEAGE_BUILDTYPE), UNOFFICIAL)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        LINEAGE_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

LINEAGE_VERSION_SUFFIX := $(LINEAGE_BUILD_DATE)$(CI_PIPELINE_ID)-$(LINEAGE_BUILDTYPE)$(LINEAGE_EXTRAVERSION)-$(LINEAGE_BUILD)

# Internal version
ifeq ($(PRODUCT_VERSION_MAINTENANCE),0)
    LINEAGE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)$(PRODUCT_PRERELEASE_STRING)-$(ANDROID_LETTER)-$(LINEAGE_VERSION_SUFFIX)
else
    LINEAGE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_PRERELEASE_STRING)-$(ANDROID_LETTER)-$(LINEAGE_VERSION_SUFFIX)
endif

# Display version
LINEAGE_DISPLAY_VERSION := $(LINEAGE_VERSION)
