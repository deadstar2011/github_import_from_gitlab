FROM cirrusci/flutter
#RUN cd /data && flutter clean && flutter pub get &&  flutter build appbundle
USER gitlab-runner
WORKDIR /data

COPY production/configs/sh/start.sh /usr/bin/
RUN chmod +x /usr/bin/start.sh
CMD ["start.sh"]

