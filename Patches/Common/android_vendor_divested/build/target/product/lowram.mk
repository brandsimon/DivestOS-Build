#
# Copyright (C) 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Changes various properties to reduce memory usage

# Set lowram options
PRODUCT_PROPERTY_OVERRIDES += \
     ro.config.low_ram=true \
     ro.lmk.critical_upgrade=true \
     ro.lmk.upgrade_pressure=40 \
     ro.lmk.downgrade_pressure=60 \
     ro.lmk.kill_heaviest_task=false \
     config.disable_atlas=true \
     dalvik.vm.madvise-random=true
#     dalvik.vm.heapgrowthlimit=128m \
#     dalvik.vm.heapsize=256m

# Speed profile services and wifi-service to reduce RAM and storage.
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile

# Always preopt extracted APKs to prevent extracting out of the APK for gms
# modules.
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true

# Do not generate libartd.
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
