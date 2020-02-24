FROM oraclelinux:7-slim as instantclient

ENV VERSION="2.6.5"

RUN yum install -y oracle-release-el7
RUN yum update -y
RUN yum install -y --enablerepo=ol7_oracle_instantclient oracle-instantclient18.3-basic oracle-instantclient18.3-devel oracle-instantclient18.3-sqlplus && \
    yum clean all

# install ruby
RUN yum -y install git openssl-devel readline-devel zlib-devel libcurl-devel bzip2 gcc make
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
RUN echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

RUN source /etc/profile.d/rbenv.sh; rbenv install ${VERSION} && rbenv global ${VERSION}
RUN source /etc/profile.d/rbenv.sh; gem update --system && gem install bundler

RUN echo 'export LD_LIBRARY_PATH=/usr/lib/oracle/18.3/client64/lib/' >> /etc/profile.d/oracle.sh
