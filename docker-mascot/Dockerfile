FROM ubuntu:xenial

RUN apt-get update
RUN apt-get -y install \
 build-essential \
 git wget \
 python-pip \
 yasm
RUN apt-get -y install m4

# Installing libsodium
RUN apt-get -y install libsodium-dev

# Installing MPIR
RUN wget http://mpir.org/mpir-3.0.0.tar.bz2
RUN tar -xjf mpir-3.0.0.tar.bz2
RUN cd mpir-3.0.0 && ./configure --enable-cxx && make && make install

# Install SPDZ-2
RUN git clone https://github.com/bristolcrypto/SPDZ-2 #1
WORKDIR SPDZ-2

# Installing Mascot dependencies
COPY .gitmodules .gitmodules
RUN git submodule update --init SimpleOT
RUN cd SimpleOT && make
# TODO: Patch SPDZ-2 so .gitmodules can be used without auth

# Build SPDZ-2
COPY CONFIG.mascot CONFIG
RUN make -j2
ENV LD_LIBRARY_PATH=/usr/local/lib

# Run tests by default
COPY HOSTS-docker ./HOSTS
RUN ./compile.py -p 256 tutorial
EXPOSE 10000-10003

CMD bash