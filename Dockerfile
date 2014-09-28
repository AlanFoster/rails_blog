from ubuntu:14.04

# Core Dependencies
RUN sed -i.bak 's/main$/main universe/' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -qy install \
    git \
    vim \
    curl \
    man

# Install Node Dependencies
RUN \curl https://raw.githubusercontent.com/creationix/nvm/v0.17.1/install.sh | bash
RUN echo '[[ -s /.nvm/nvm.sh ]] && . /.nvm/nvm.sh' >> /etc/profile
RUN bash -lc 'nvm install 0.10'
RUN bash -lc 'nvm use 0.10'

# Ruby Dependencies
RUN \curl -sSL https://get.rvm.io | bash
RUN bash -lc 'rvm install ruby-2.1.1'

# Application Dependencies
WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bash -lc 'bundle install'

EXPOSE 3000

WORKDIR /website
add . .
RUN bash -lc 'nvm alias default 0.10'
RUN bash -lc 'rake db:migrate && rake db:seed'
ENTRYPOINT bash -lc 'rails s'
