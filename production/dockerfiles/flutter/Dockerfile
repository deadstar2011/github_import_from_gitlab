FROM cirrusci/flutter

RUN gem install fastlane -NV && apt update && apt install -y mc nano
WORKDIR /data
COPY production/configs/sh/start.sh /usr/bin/
RUN chmod +x /usr/bin/start.sh
RUN useradd gitlab-runner
CMD ["start.sh"]

