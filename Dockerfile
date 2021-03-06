FROM            larserdmann/ubuntu-for-manual-ppa:latest

MAINTAINER      Lars Erdmann <lars.erdmann@uni-greifswald.de>

COPY            config/veracrypt-ppa /etc/apt/sources.list.d/unit193-ubuntu-encryption-bionic.list

RUN             apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 03647209B58A653A && \
                apt-get update --no-install-recommends && \
                apt-get install veracrypt -y --no-install-recommends && \
                apt-get install nano -y && \
                apt-get install incron && \
                echo root >> /etc/incron.allow && \
                apt-get autoclean && \
                apt-get --purge -y autoremove && \
                groupadd -r veracrypt -g 433 && \
                useradd -u 431 -r -g veracrypt -s /bin/false -c "VeraCrypt user" veracrypt

COPY            config/run.sh /
COPY            config/executeJob.sh /
COPY            config/incron-command /var/spool/incron/root

RUN             chmod +x /executeJob.sh && \
                chmod +x /run.sh

ENTRYPOINT      ["./run.sh"]
