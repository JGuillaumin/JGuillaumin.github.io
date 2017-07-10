FROM ruby:2.1
MAINTAINER Julien Guillaumin <julien.guillaumin@imt-atlantique.net>

RUN apt-get update && \
    apt-get install -y build-essential patch make node python-pygments zlib1g-dev liblzma-dev && \
    gem install nokogiri:1.6.8 && \
    gem install bundler

#Copy over the gemfile to a temporary directory and run the install command. 

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock 
RUN bundle install


RUN mkdir /src
WORKDIR "/src"

EXPOSE 4000

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


CMD bundle exec jekyll serve --host=0.0.0.0 --watch --force_polling




