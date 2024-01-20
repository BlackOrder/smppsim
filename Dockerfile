FROM openjdk:7-jre-alpine

MAINTAINER wahome <kevowahome@gmail.com>

RUN apk add --update bash && rm -rf /var/cache/apk/*

COPY SMPPSim /app

RUN chmod +x /app/startsmppsim.sh

ENV SMPP_PORT 2775
ENV SMPP_CONNECTION_HANDLERS 1
ENV MESSAGE_STATE_CHECK_FREQUENCY 5000
ENV MAX_TIME_ENROUTE 10000
ENV DELAY_DELIVERY_RECEIPTS_BY 3000
ENV PERCENTAGE_THAT_TRANSITION 75
ENV PERCENTAGE_DELIVERED 90
ENV PERCENTAGE_UNDELIVERABLE 6
ENV PERCENTAGE_ACCEPTED 2
ENV PERCENTAGE_REJECTED 2
ENV DISCARD_FROM_QUEUE_AFTER 6000
ENV HTTP_PORT 8884
ENV HTTP_THREADS 1
ENV SYSTEM_IDS smppclient1,smppclient2,smppclient3
ENV SYSTEM_PASSWORDS password,password,password
ENV OUTBIND_ENABLED false
ENV OUTBIND_ESME_IP_ADDRESS 127.0.0.1
ENV OUTBIND_ESME_PORT 2776
ENV OUTBIND_ESME_SYSTEMID smppclient1
ENV OUTBIND_ESME_PASSWORD password
ENV MO_DELIVERY_MESSAGES_PER_MINUTE 0
ENV OUTBOUND_QUEUE_MAX_SIZE 5000000
ENV INBOUND_QUEUE_MAX_SIZE 5000000
ENV DELAYED_INBOUND_QUEUE_PROCESSING_PERIOD 60
ENV DELAYED_INBOUND_QUEUE_MAX_ATTEMPTS 100

EXPOSE 8884

EXPOSE 2775

WORKDIR /app

COPY docker-entrypoint.sh /

VOLUME ["/app/conf", "/app/mo"]

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/app/startsmppsim.sh"]
