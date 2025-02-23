FROM node:lts
RUN npm install -g jscpd
ADD ./plugins/jscpd/script.sh /bin/
RUN chmod +x /bin/script.sh
ENTRYPOINT /bin/script.sh
