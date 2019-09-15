FROM ruby:2.6.4

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qqy && apt-get install  -qqyy yarn nodejs postgresql postgresql-contrib libpq-dev cmake

# Install Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
    apt-get update -yqqq && \
    apt-get install -y google-chrome-stable > /dev/null 2>&1 && \
    sed -i 's/"$@"/--no-sandbox "$@"/g' /opt/google/chrome/google-chrome

# Install chromedriver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/2.35/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver.zip chromedriver -d /usr/bin/ && \
    rm /tmp/chromedriver.zip && \
    chmod ugo+rx /usr/bin/chromedriver

RUN rm -rf /var/lib/apt/lists/*

# heroku
RUN apt-get update -yq && \
    apt-get install apt-transport-https software-properties-common -y && \
    add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./" && \
    curl -L https://cli-assets.heroku.com/apt/release.key | apt-key add - && \
    apt-get update -yq && \
    apt-get install heroku -y && \
    gem install dpl
