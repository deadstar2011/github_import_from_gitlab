FROM ruby:2.7

COPY . /data

RUN gem install fastlane
#&& \
#    cd /data/ && \
#    fastlane help && \
#    fastlane env && \
#    fastlane init && \
#    cat fastlane/Appfile

WORKDIR /data/