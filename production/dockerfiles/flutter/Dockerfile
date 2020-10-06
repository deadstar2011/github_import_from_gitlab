FROM cirrusci/flutter
#RUN cd /data && flutter clean && flutter pub get &&  flutter build appbundle
WORKDIR /data

COPY start.sh /usr/bin/

CMD ["start.sh"]

