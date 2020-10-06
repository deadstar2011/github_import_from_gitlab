FROM ruby:2.7
RUN gem install fastlane
WORKDIR /data
COPY production/configs/fastlane/Fastfile /root/fastlane/Fastfile
COPY production/configs/sh/test.sh /root/fastlane/test.sh
COPY production/configs/sh/start.sh /usr/bin/
RUN chmod +x /usr/bin/start.sh
CMD ["start.sh"]