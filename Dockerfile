FROM erlio/docker-vernemq 
RUN apt-get update && apt-get install -y expect 
COPY dogfish/ /usr/share/dogfish
COPY shell-migrations/ /usr/share/dogfish/shell-migrations
RUN ln -s /usr/share/dogfish/dogfish /usr/bin/dogfish
RUN touch /etc/vernemq/migrations.log
RUN mkdir /var/lib/dogfish/ 
RUN ln -s /etc/vernemq/migrations.log /var/lib/dogfish/migrations.log 
COPY vernemq.conf /etc/vernemq.conf
RUN ln -s /etc/vernemq.confg /etc/vernemq/vernemq.conf.local
CMD dogfish migrate & start_vernemq