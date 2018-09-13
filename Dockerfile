FROM ruby:2.4.1
RUN apt-get update
# RUN apt-get install curl -y
RUN wget http://curl.haxx.se/download/curl-7.50.3.tar.gz && \
    tar -xvf curl-7.50.3.tar.gz && \
    cd curl-7.50.3/ && \
    ./configure && \
    make && \
    make install
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get -y install nodejs && apt-get -y install cron
# RUN gem install rails -v 5.1.6
RUN mkdir -p /home/rada_reporter
ADD . /home/rada_reporter
WORKDIR /home/rada_reporter
# RUN gem install bundler
RUN bundle install
RUN export RAILS_ENV=production; bundle exec rake assets:precompile
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true
ENV TZ Asia/Ho_Chi_Minh
# ENV COMMIT_UNIQUE CI_BUILD_REF
CMD ["puma", "-C", "config/puma.rb"]
