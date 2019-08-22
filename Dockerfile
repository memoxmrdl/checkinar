FROM ruby:2.6.2

ENV BUILD_PACKAGES="curl bash software-properties-common apt-transport-https" \
    DEV_PACKAGES="libxml2-dev libxslt-dev tzdata postgresql-client imagemagick fontconfig" \
    RUBY_PACKAGES="nodejs yarn"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y $BUILD_PACKAGES && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
      apt-get update && \
      apt-get install -y build-essential \
      $DEV_PACKAGES \
      $RUBY_PACKAGES

# Install latest chrome dev package.
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb
