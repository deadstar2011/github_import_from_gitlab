FROM ruby:2.7
RUN gem install fastlane
WORKDIR /data/android
COPY production/configs/fastlane/Fastfile /data/android/fastlane/Fastfile
COPY production/configs/sh/test.sh /data/android/fastlane/test.sh
COPY production/configs/sh/start.sh /usr/bin/
RUN chmod +x /usr/bin/start.sh
CMD ["start.sh"]