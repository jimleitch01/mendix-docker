# Dockerfile
#
# VERSION               0.2

FROM debian:latest
MAINTAINER Pim van den Berg <pim.van.den.berg@mendix.com>

RUN apt-key adv --fetch-keys http://packages.mendix.com/mendix-debian-archive-key.asc
RUN echo "deb http://packages.mendix.com/platform/debian/ wheezy main" > /etc/apt/sources.list.d/mendix.list

RUN apt-get update && apt-get install -y --no-install-recommends m2ee-tools openjdk-7-jre-headless postgresql-client procps vim-nox curl && apt-get clean

RUN useradd -m mendix -b /srv && cd /srv/mendix; mkdir .m2ee data model runtimes web; cd data; mkdir database files model-upload log tmp

ADD m2ee.yaml /srv/mendix/.m2ee/m2ee.yaml

RUN chown -R mendix:mendix /srv/mendix

EXPOSE 8000
CMD ["/bin/su", "mendix", "-c", "/bin/bash"]
