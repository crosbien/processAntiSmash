FROM alpine:3.10.2
RUN apk update && apk upgrade && apk add bash
RUN apk add jq
COPY mibig /processAntiSmash/mibig
COPY output /processAntiSmash/output
COPY testData /processAntiSmash/testData/
COPY README.md /processAntiSmash
CMD bash