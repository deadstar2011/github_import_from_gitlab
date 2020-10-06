FROM cirrusci/flutter
#RUN cd /data && flutter clean && flutter pub get &&  flutter build appbundle
WORKDIR /data

COPY production/configs/sh/start.sh /usr/bin/

CMD ["start.sh"]

