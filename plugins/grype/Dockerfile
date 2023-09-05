FROM alpine:3.18.3
RUN apk --no-cache add curl
RUN curl -svSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | /bin/sh -s -- -b /bin
RUN apk del curl --quiet
ADD ./plugins/grype/script.sh /bin/
RUN chmod +x /bin/script.sh
ENTRYPOINT /bin/script.sh
