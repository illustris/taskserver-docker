FROM alpine
RUN apk add git
RUN git clone https://github.com/GothenburgBitFactory/taskserver.git taskserver.git
WORKDIR taskserver.git
RUN git submodule init && git submodule update
RUN apk add cmake make gcc g++ gnutls-dev util-linux-dev
RUN cmake -DCMAKE_BUILD_TYPE=release .
RUN make -j
RUN make install
RUN apk add gnutls-utils
ADD run.sh /
ADD setup.sh /
CMD /run.sh
