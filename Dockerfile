FROM mhart/alpine-node

WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
COPY package.json /usr/src/app/
COPY npm-shrinkwrap.json /usr/src/app/

RUN apk --update add git ruby ruby-dev ruby-bundler python g++ make && \
    bundle install -j 4 && \
    npm install && \
    apk del make g++ && rm -fr /usr/share/ri

ENV PATH /usr/src/app/node_modules/.bin:$PATH"
RUN adduser -u 9000 -D app
COPY . /usr/src/app
RUN chown -R app:app /usr/src/app

COPY node_modules/clog-analysis/bin/clog /code/clog

USER app
CMD "ruby" "/usr/src/app/bin/clog"
