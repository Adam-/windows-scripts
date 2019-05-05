FROM debian:jessie
ADD * /windows-scripts/
RUN apt-get update -qq && apt-get install -y sudo
RUN cd /windows-scripts && ./init.sh && ./all.sh
