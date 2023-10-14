FROM ruby:3.1
WORKDIR /backend
RUN set -eux && \
    apt-get update -qq && \
    apt-get install -y \
      postgresql-client


COPY Gemfile Gemfile.lock* /backend/

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
