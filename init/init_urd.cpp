/*
   Copyright (c) 2013, The Linux Foundation. All rights reserved.
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>

#include <android-base/file.h>
#include <android-base/logging.h>
#include <android-base/properties.h>
#include <android-base/strings.h>

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

#include "vendor_init.h"
#include "property_service.h"
#include "util.h"

#define FINGERPRINT_HW "/sys/module/zte_misc/parameters/fingerprint_hw"

using android::base::Trim;
using android::base::GetProperty;
using android::base::ReadFileToString;
using android::init::property_set;

void property_override(char const prop[], char const value[]) {
    prop_info *pi;

    pi = (prop_info*) __system_property_find(prop);
    if (pi)
        __system_property_update(pi, value, strlen(value));
    else
        __system_property_add(prop, strlen(prop), value, strlen(value));
}

void init_fingerprint_properties()
{
    std::string sensor_version;

    if (ReadFileToString(FINGERPRINT_HW, &sensor_version)) {
        LOG(INFO) << "Loading Fingerprint HAL for sensor version " << sensor_version;
        if (Trim(sensor_version) == "0") {
            property_set("ro.hardware.fingerprint", "goodix");
            property_set("ro.build.fingerprint_hw", "goodix_fp");
        }
        else if (Trim(sensor_version) == "1") {
            property_set("ro.hardware.fingerprint", "synafp");
            property_set("ro.build.fingerprint_hw", "synafp");
        }
        else {
            LOG(ERROR) << "Unsupported fingerprint sensor: " << sensor_version;
        }
    }
    else {
        LOG(ERROR) << "Failed to detect sensor version";
    }
}

void vendor_load_properties() {
    LOG(INFO) << "Loading vendor specific properties";
    init_fingerprint_properties();
}
