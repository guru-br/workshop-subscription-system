FROM ruby:2.7.1
MAINTAINER Guru-BR

ENV INSTALL_PATH /workshop

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends postgresql-client locales yarn nodejs

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
ENV LC_ALL en_US.utf8

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
dpkg-reconfigure -f noninteractive tzdata

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

ADD yarn.lock yarn.lock
ADD package.json packages.json
RUN yarn install --check-files

ADD . $INSTALL_PATH

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
