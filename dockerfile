FROM alpine:3.10.2
RUN apk update && apk upgrade && apk add bash
RUN apk add jq
RUN apk add gawk
RUN apk add coreutils
COPY mibig.sh /
COPY LICENSE /
COPY README.md /
CMD /bin/bash mibig.sh $PERC_ID $PERC_COV $DATADIR $RESULTDIR $MIBIG