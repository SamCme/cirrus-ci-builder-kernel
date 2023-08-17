#!/usr/bin/env bash

# Helper function for cloning: gsc = git shallow clone
gsc() {
	git clone --depth=1 -q $@
}

# Toolchains directory
mkdir toolchains

# Clone GCC
#gsc https://github.com/cyberknight777/gcc-arm64.git -b master toolchains/gcc64
#gsc https://github.com/mvaisakh/gcc-arm.git -b gcc-master toolchains/gcc32

# Clone CLANG
mkdir toolchains/clang && cd toolchains/clang
bash <(curl -s https://raw.githubusercontent.com/Neutron-Toolchains/antman/main/antman) -S
cd ../..

# Clone AnyKernel3
gsc https://github.com/Tashar02/AnyKernel3.git AnyKernel3

# Clone Kernel Source
gsc https://github.com/Maanush2004/android_kernel_realme_RMX1821.git -b lineage-18.1-rmui Kernel

# Setup Scripts
mv scarlet.sh Kernel/scarlet.sh
cd Kernel
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -

# Compile the kernel using CLANG
bash scarlet.sh --clang --osscam --qti --non-dynamic --non-lto
