#FROM cemmersb/centos-jdk8:8u191
FROM artifacts.iflytek.com/docker-private/cti_mea_pub/centos-jdk:7.4-8u191
WORKDIR /home/data-access-api/
RUN mkdir /tmp/file
COPY data-access-api-1.0.0-SNAPSHOT.jar ./
ENV TZ=Asia/Shanghai LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ENV NACOS_ADDR 10.40.7.50:8848
ENV NACOS_NAMESPACE dev_data_access_api
ENV NACOS_USER nacos
ENV NACOS_PASS admin!123123.
ENV JAVA_OPS -Xms2g -Xmx2g -Xmn512m -XX:+UseG1GC -XX:G1HeapRegionSize=2m -XX:MaxGCPauseMillis=200 -Djava.security.egd=file:/dev/./urandom
ENV SERVER_PORT 28899
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ >/etc/timezone
ENTRYPOINT java ${JAVA_OPS} \
    -Dserver.port=${SERVER_PORT} \
    -Dnacos.addr=${NACOS_ADDR} \
    -Dnacos.namespace=${NACOS_NAMESPACE} \
    -jar data-access-api-1.0.0-SNAPSHOT.jar
EXPOSE 28899