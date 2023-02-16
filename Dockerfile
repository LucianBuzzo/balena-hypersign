FROM balenalib/raspberrypi3-golang

# Set up dependencies
ENV PACKAGES curl make git libc-dev bash gcc python3 jq

# Set working directory for the git clone
WORKDIR /usr/local

RUN git clone https://github.com/hypersign-protocol/hid-node.git app

# Set working directory for the build
WORKDIR /usr/local/app

# Install minimum necessary dependencies and build hid-node
RUN apt-get update
RUN apt-get install ${PACKAGES} -y
RUN make install 

# Setup the node
RUN sh ./scripts/localnet-single-node/setup.sh

# Expose Ports
EXPOSE 26657 1317 9090 9091 26656

CMD ["hid-noded", "start"]