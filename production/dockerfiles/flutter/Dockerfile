FROM cirrusci/flutter
WORKDIR /data
COPY production/configs/sh/start.sh /usr/bin/
RUN chmod +x /usr/bin/start.sh
RUN useradd -g root gitlab-runner
USER gitlab-runner
CMD ["start.sh"]

