# Dockerfile - Development workspace
FROM ruby:2.7

LABEL maintainer="yusuke.sato@ys-office.me"

ARG USER_ID
ARG GROUP_ID
ARG USER_NAME
ARG GROUP_NAME

ENV INSTALL_PATH /opt/app

RUN addgroup --gid ${GROUP_ID} ${GROUP_NAME} \
    &&  adduser --disabled-password --gecos '' --uid ${USER_ID} --gid ${GROUP_ID} ${USER_NAME}

# Install Nodejs and Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg \
    &&  apt-key add /root/yarn-pubkey.gpg \
    &&  echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
    &&  apt-get update \
    &&  apt-get install -y --no-install-recommends \
        nodejs \
        yarn

# Install Rails and bundle
RUN gem install \
    bundler \
    rails

RUN mkdir -p ${INSTALL_PATH}

COPY api/Gemfile Gemfile
# COPY sidekiq/config/initializers/sidekiq.rb config/initializers/sidekiq.rb 

WORKDIR ${INSTALL_PATH}
RUN bundle install \
    &&  chown -R ${USER_NAME}:${GROUP_NAME} ${INSTALL_PATH}

USER $USER_ID
VOLUME ["$INSTALL_PATH/public"]
CMD bundle exec unicorn -c config/unicorn.rb
