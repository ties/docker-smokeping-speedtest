FROM linuxserver/smokeping
ENV SMOKEPING_SPEEDTEST_DIR /opt/smokeping-speedtest/

ADD speedtest.Probe speedtest.Target /tmp/
RUN apk update \
	&& apk add --no-cache --virtual .setupdeps git \
	&& apk add --no-cache python3 \
	&& pip3 install speedtest-cli \
	&& git clone https://github.com/mad-ady/smokeping-speedtest.git ${SMOKEPING_SPEEDTEST_DIR} \
	&& cp ${SMOKEPING_SPEEDTEST_DIR}*.pm /usr/share/perl5/vendor_perl/Smokeping/probes/ \
	&& cat /tmp/speedtest.Probe >> /defaults/smoke-conf/Probes \
	&& cat /tmp/speedtest.Target >> /defaults/smoke-conf/Targets \
	&& apk del .setupdeps \
	&& sed -i -e 's/\(range = 10h\)$/\1\nmax_rtt = 1000000000/' /defaults/smoke-conf/Presentation
