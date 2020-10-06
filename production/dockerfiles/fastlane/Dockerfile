FROM ruby:2.7
RUN gem install fastlane
WORKDIR /data
COPY production/configs/sh/start.sh /usr/bin/
RUN chmod +x /usr/bin/start.sh
CMD ["start.sh"]