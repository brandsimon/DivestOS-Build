#!/bin/bash
#DivestOS: A privacy focused mobile distribution
#Copyright (c) 2017-2021 Divested Computing Group
#
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <https://www.gnu.org/licenses/>.
umask 0022;
set -euo pipefail;
source "$DOS_SCRIPTS_COMMON/Shell.sh";

echo "Post tweaks...";

#Workaround broken MSM_DLOAD_MODE=y+PANIC_ON_OOPS=y for devices that oops on shutdown
#MSM_DLOAD_MODE can't be disabled as it breaks compile
sed -i 's/set_dload_mode(in_panic)/set_dload_mode(0)/' kernel/*/*/arch/arm/mach-msm/restart.c &>/dev/null || true;

#Disable slub/slab merging
sed -i 's/static int slub_nomerge;/static int slub_nomerge = 1;/' kernel/*/*/mm/slub.c &>/dev/null || true; #2.6.22-3.17
sed -i 's/static int slab_nomerge;/static int slab_nomerge = 1;/' kernel/*/*/mm/slab_common.c &>/dev/null || true; #3.18-4.12
sed -i 's/static bool slab_nomerge = !IS_ENABLED(CONFIG_SLAB_MERGE_DEFAULT);/static bool slab_nomerge = true;/' kernel/*/*/mm/slab_common.c &>/dev/null || true; #4.13+
sed -i 's/static bool slab_nomerge __ro_after_init = !IS_ENABLED(CONFIG_SLAB_MERGE_DEFAULT);/static bool slab_nomerge __ro_after_init = true;/' kernel/*/*/mm/slab_common.c &>/dev/null || true; #4.13+

#Enable page poisoning
#Commented as set by defconfig
#sed -i 's/= IS_ENABLED(CONFIG_PAGE_POISONING_ENABLE_DEFAULT);/= true;/' kernel/*/*/mm/page_poison.c &>/dev/null || true; #4.4+ #XXX: shouldn't be enabled past 5.3

#Build speedup
sed -i 's/flags.Tidy = true/flags.Tidy = false/' build/soong/cc/tidy.go &>/dev/null || true; #Disable clang-tidy (kdrag0n)

cd "$DOS_BUILD_BASE";
echo -e "\e[0;32m[SCRIPT COMPLETE] Post tweaks complete\e[0m";
