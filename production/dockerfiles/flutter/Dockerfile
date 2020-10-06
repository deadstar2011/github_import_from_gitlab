FROM cirrusci/flutter
RUN useradd -g root gitlab-runner
USER gitlab-runner
WORKDIR /data
COPY production/configs/sh/start.sh /usr/bin/
RUN chmod +x /usr/bin/start.sh
CMD ["start.sh"]

