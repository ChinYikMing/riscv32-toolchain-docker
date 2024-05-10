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
RUN export PATH="/opt/riscv32/bin:$PATH"
