#!/bin/bash
cd "$DOS_BUILD_BASE""kernel/google/msm-4.9"
git apply $DOS_PATCHES_LINUX_CVES/0001-LinuxIncrementals/4.9/4.9.0242-0243.patch --exclude=Makefile
git apply $DOS_PATCHES_LINUX_CVES/0001-LinuxIncrementals/4.9/4.9.0286-0287.patch --exclude=Makefile
git apply $DOS_PATCHES_LINUX_CVES/0001-LinuxIncrementals/4.9/4.9.0300-0301.patch --exclude=Makefile
git apply $DOS_PATCHES_LINUX_CVES/0002-Misc_Fixes/4.9/0010.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0025.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0026.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0027.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0028.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0029.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0030.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0031.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0032.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0033.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0034.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0035.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0036.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0037.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0038.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0039.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0041.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0042.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0043.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0044.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0045.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0046.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0047.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0048.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0049.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0050.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0051.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0052.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0053.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0054.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0055.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/4.9/0056.patch
git apply $DOS_PATCHES_LINUX_CVES/0008-Graphene-Kernel_Hardening/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2015-7837/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2016-3695/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2017-16USB/ANY/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2017-16USB/ANY/0008.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2017-16USB/ANY/0009.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2017-0605/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2017-7477/4.9/0003.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2017-13693/^4.12.9/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2017-13694/^4.12.9/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2017-1000252/^4.13/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2018-5897/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2018-8043/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2018-9415/ANY/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2018-9462/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2018-9519/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2018-10323/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2018-13094/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2018-13899/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2018-13899/ANY/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2018-20855/^4.18/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2018-21008/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-0145/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-0148/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-8912/^5.0/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-9453/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-10503/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-12378/^5.1.5/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-12455/^5.1.5/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-12456/^5.1.5/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-14040/ANY/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-14896/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-14901/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-15217/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-16233/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-16234/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-16921/^4.16/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-16994/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-18808/4.9/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19051/4.9/0013.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19051/4.9/0014.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19051/^5.3/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19054/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19060/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19061/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19073/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19074/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19318/4.9/0004.patch
#git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19319/4.9/0021.patch
#git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19319/4.9/0022.patch
#git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19319/4.9/0023.patch
#git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19319/4.9/0024.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19448/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19462/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19813/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19815/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19816/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-19947/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-20096/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-20806/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-20810/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2019-20908/^5.2/0001.patch
#git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0067/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0404/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0423/^5.9/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0427/4.9/0003.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0429/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0429/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0432/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0433/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0433/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0433/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0444/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0465/4.9/0011.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0466/4.9/0012.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0543/4.9/0026.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0543/4.9/0027.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0543/4.9/0028.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0543/4.9/0029.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0543/4.9/0030.patch
#git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-1749/4.9/0011.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-2732/4.9/0016.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-3674/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-3693/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-3696/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-3702/4.9/0031.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-3702/4.9/0032.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-3702/4.9/0033.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-3702/4.9/0034.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-3702/4.9/0035.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-4788/4.9/0015.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-4788/4.9/0016.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-4788/4.9/0017.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-4788/4.9/0018.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-4788/4.9/0019.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-4788/4.9/0020.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-4788/4.9/0021.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-4788/4.9/0022.patch
#git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-8992/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-9383/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-10135/4.9/0013.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-10135/4.9/0014.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-10135/4.9/0015.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-10711/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-10732/4.9/0008.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-10757/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-10766/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-10942/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-11160/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-11174/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-11234/ANY/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-11239/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-11261/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-11262/ANY/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-11267/ANY/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-11282/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-11290/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-11494/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-11565/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-11608/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-11609/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-11668/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-12351/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-12352/3.6-^5.10/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-12352/ANY/0009.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-12652/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-12653/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-12654/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-12655/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-12656/4.9/0010.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-12656/4.9/0011.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-12769/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-12770/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-12771/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-12826/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-13143/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-13974/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-14305/4.9/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-14314/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-14331/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-14351/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-14356/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-14381/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-14386/4.9/0003.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-14390/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-14416/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-15393/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-15436/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-15437/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-16119/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-16119/^5.10/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-16166/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-24394/^5.8/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-24490/4.9/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-24588/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25211/4.9/0003.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25212/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25220/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25284/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25285/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25641/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25643/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25645/4.9/0003.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25668/4.9/0003.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25669/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25670/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25671/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25672/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25673/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-25705/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-26088/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-26139/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-26147/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-26555/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-27066/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-27068/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-27815/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-27825/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-28915/4.9/0016.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-28915/4.9/0017.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-28915/4.9/0018.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-28974/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-29368/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-29368/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-29370/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-29371/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-29568/4.9/0031.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-29568/4.9/0032.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-29568/4.9/0033.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-29568/4.9/0034.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-29568/4.9/0035.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-29569/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-29661/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-35508/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-35519/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-36158/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-36312/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-36516/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-UNKNOWN/ANY/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-0512/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-0605/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-0929/ANY/0003.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-0935/^4.16/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-0936/ANY/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-0936/ANY/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-0936/ANY/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-0936/ANY/0008.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-0936/ANY/0011.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-0936/ANY/0012.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-0937/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-0941/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-0961/ANY/0003.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-1048/4.1-^5.9/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-1939/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-1963/ANY/0003.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3178/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3347/4.9/0036.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3347/4.9/0037.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3347/4.9/0038.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3347/4.9/0039.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3347/4.9/0040.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3347/4.9/0041.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3347/4.9/0042.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3347/4.9/0043.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3347/4.9/0044.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3347/4.9/0045.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3428/4.9/0016.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3483/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3564/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3573/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3609/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3612/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3640/4.9/0012.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3640/4.9/0013.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3640/4.9/0014.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3653/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3655/4.9/0012.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3655/4.9/0013.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3655/4.9/0014.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3655/4.9/0015.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3659/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3679/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3715/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3732/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3752/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3753/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3760/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3772/4.9/0022.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3772/4.9/0023.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-3896/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-4002/4.9/0008.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-4149/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-4155/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-4157/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-4202/4.9/0009.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-4202/4.9/0010.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-20292/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-20320/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-20320/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-20322/4.9/0010.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-21781/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-23133/4.9/0010.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-23134/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-26930/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-26931/4.9/0013.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-26931/4.9/0014.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-26931/4.9/0015.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-26932/4.9/0021.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-26932/4.9/0022.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-26932/4.9/0023.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-26932/4.9/0024.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-26932/4.9/0025.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-27363/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-27365/4.9/0009.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-27365/4.9/0010.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-28038/4.9/0009.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-28038/4.9/0010.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-28660/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-28688/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-28713/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-28964/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-28971/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-28972/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-29154/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-29647/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-29650/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-30002/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-30262/ANY/0001.patch
#git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-30324/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-30335/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-31916/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-32399/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-33033/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-33034/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-33098/^5.12/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-33909/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-34693/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-34981/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-37576/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-37576/4.9/0008.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-38160/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-38199/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-38204/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-38205/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-38208/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-38209/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-39633/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-39634/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-39636/ANY/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-39636/ANY/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-39636/ANY/0003.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-39636/ANY/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-39636/ANY/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-39648/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-39656/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-39685/4.9/0013.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-39685/4.9/0015.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-39714/4.9/0002.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-40490/3.9-^5.14/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-42008/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-42739/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-43976/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-44879/^5.16/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-45095/4.9/0005.patch
#git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-45469/4.9-^5.16/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-45485/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-45868/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-0330/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-0617/4.9/0009.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-0617/4.9/0010.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-0644/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-0847/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-0850/4.9/0006.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-1016/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-23039/4.9/0003.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-23042/4.9/0003.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-23960/4.9/0050.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-23960/4.9/0051.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-23960/4.9/0052.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-23960/4.9/0053.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-23960/4.9/0054.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-24448/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-24958/4.9/0007.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-24958/4.9/0008.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-25258/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-25375/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-26966/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-27223/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-27950/^5.16/0001.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2022-28356/4.9/0004.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-0466/4.9/0011.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-24586/4.9/0009.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2020-29660/4.9/0005.patch
git apply $DOS_PATCHES_LINUX_CVES/CVE-2021-37159/4.9/0007.patch
editKernelLocalversion "-dos.p389"
cd "$DOS_BUILD_BASE"
