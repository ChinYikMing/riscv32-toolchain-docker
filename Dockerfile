FROM ubuntu:22.04
RUN apt-get update
RUN apt-get install git vim -y
RUN git clone https://github.com/riscv-collab/riscv-gnu-toolchain.git
RUN apt-get install autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev libslirp-dev -y
RUN cd riscv-gnu-toolchain && ./configure --prefix=/opt/riscv32 --with-arch=rv32imaf --with-abi=ilp32 && make -j`nproc`
RUN ln -s /opt/riscv32/bin/riscv32-unknown-elf-gcc /opt/riscv32/bin/rv32gcc
RUN ln -s /opt/riscv32/bin/riscv32-unknown-elf-objdump /opt/riscv32/bin/rv32objdump
RUN ln -s /opt/riscv32/bin/riscv32-unknown-elf-gdb /opt/riscv32/bin/rv32gdb
RUN ln -s /opt/riscv32/bin/riscv32-unknown-elf-readelf /opt/riscv32/bin/rv32readelf
RUN echo "export PATH=\"/opt/riscv32/bin:$PATH\"" >> ~/.bashrc
RUN cd -
RUN cd -
# Buildroot
RUN apt-get install libncurses5-dev wget cpio unzip rsync ripgrep -y
RUN git clone https://github.com/ChinYikMing/riscv32-toolchain-docker.git -b resources
RUN git clone https://github.com/buildroot/buildroot.git --depth=1
RUN cd buildroot && cp ../riscv32-toolchain-docker/buildroot.config .config && cp ../riscv32-toolchain-docker/busybox.config busybox.config && make olddefconfig && FORCE_UNSAFE_CONFIGURE=1 make && cd -
RUN echo "export PATH=\"`pwd`buildroot/output/host/bin:$PATH\"" >> ~/.bashrc
RUN echo "export CROSS_COMPILE=riscv32-buildroot-linux-gnu-" >> ~/.bashrc
RUN echo "export ARCH=riscv" >> ~/.bashrc
# Linux kernel
RUN git clone https://github.com/torvalds/linux.git --depth=1
RUN bash
