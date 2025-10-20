FROM grafana/k6:0.49.0
USER 0
RUN mkdir -p /nail/var && chmod 0755 /nail /nail/var \
 && mkdir -p /run && chmod 0755 /run \
 && mkdir -p /tmp && chmod 1777 /tmp
# Switch back to the k6 user if the base image uses one (often 12345)
USER 12345

