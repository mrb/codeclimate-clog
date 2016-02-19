FROM mhart/alpine-node:4

WORKDIR /usr/src/app

# ruby
RUN apk --update add ruby ruby-dev ruby-io-console g++ make git \
    && rm -fr /usr/share/ri

RUN gem install bundler --no-ri --no-rdoc \
    && rm -r /root/.gem \
    && find / -name '*.gem' | xargs rm

# npm dependencies
COPY package.json /usr/src/app/
COPY npm-shrinkwrap.json /usr/src/app/
RUN npm install --production

# gem dependencies
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install --deployment --without 'test development' --clean

# application
ENV PATH /usr/src/app/node_modules/.bin:$PATH"
COPY . /usr/src/app

ENTRYPOINT ["bundle", "exec"]
CMD ruby /usr/src/app/bin/clog
