FROM erlio/docker-vernemq 

COPY vernemq.conf /etc/vernemq.conf
RUN ln -s /etc/vernemq.confg /etc/vernemq/vernemq.conf.local