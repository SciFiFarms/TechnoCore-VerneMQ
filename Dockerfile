FROM erlio/docker-vernemq:1.6.1
RUN apt-get update && apt-get install -y expect mosquitto-clients 

# Add dogfish
COPY dogfish/ /usr/share/dogfish
RUN ln -s /usr/share/dogfish/dogfish /usr/bin/dogfish
COPY shell-migrations/ /usr/share/dogfish/shell-migrations
COPY dogfish/shell-migrations-shared/ /usr/share/dogfish/shell-migrations-shared

# Create log file.
RUN touch /etc/vernemq/migrations.log

# Symlink log file.
RUN mkdir /var/lib/dogfish
RUN ln -s /etc/vernemq/migrations.log /var/lib/dogfish/migrations.log 

COPY vernemq.conf /etc/vernemq.conf
WORKDIR /etc/vernemq

# Set up the CMD as well as the pre and post hooks.
COPY go-init /bin/go-init
COPY entrypoint.sh /usr/bin/entrypoint.sh
COPY exitpoint.sh /usr/bin/exitpoint.sh
ENTRYPOINT ["go-init"]
CMD ["-pre", "entrypoint.sh", "-main", "start_vernemq", "-post", "exitpoint.sh"]

COPY mqtt-scripts/ /usr/share/mqtt-scripts
RUN chmod +x /usr/share/mqtt-scripts/*
