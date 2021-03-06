FROM ubuntu-debootstrap:14.04.1
MAINTAINER Ryan J. McDonough "ryan@damnhandy.com"

# Install python, pip, awscli and the Oracle Java Server JRE
RUN  dpkg-reconfigure -f noninteractive locales && locale-gen en_US.UTF-8 && \
echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list && \
apt-get -y update && \
apt-get install -y curl python-pip && \
pip --no-input install awscli && \
apt-get clean && \
curl -kLH "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/8u45-b14/server-jre-8u45-linux-x64.tar.gz" \
-o /tmp/server-jre-8u45-linux-x64.tar.gz && \
mkdir -p /usr/lib/jvm && \
tar -xzf /tmp/server-jre-8u45-linux-x64.tar.gz -C /usr/lib/jvm && \
rm /tmp/server-jre-8u45-linux-x64.tar.gz && \
ln -s /usr/lib/jvm/jdk1.8.0_45 /usr/lib/jvm/java-8-oracle

# Set the locale to UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_COLLATE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH ${PATH}:${JAVA_HOME}/bin

CMD ["bash"]
