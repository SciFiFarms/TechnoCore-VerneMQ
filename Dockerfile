FROM erlio/docker-vernemq 

COPY dogfish/ /usr/share/dogfish
COPY shell-migrations/ /usr/share/dogfish/shell-migrations
RUN ln -s /usr/share/dogfish/dogfish /usr/bin/dogfish
RUN ln -s /var/lib/dogfish/migrations.log /etc/vernemq/migrations.log

COPY vernemq.conf /etc/vernemq.conf
RUN ln -s /etc/vernemq.confg /etc/vernemq/vernemq.conf.local