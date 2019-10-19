FROM alpine:3.10.2
RUN apk update && apk upgrade && apk add bash
RUN apk add jq
COPY mibig.sh /
CMD bash