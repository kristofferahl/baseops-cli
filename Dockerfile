ARG BASEOPS_VERSION
FROM kristofferahl/baseops:${BASEOPS_VERSION}

# General args
ARG TARGETARCH
ARG BASEOPS_CLI_VERSION
ARG BASEOPS_CLI_IMAGE

# Add more alpine packages
COPY packages.txt /etc/apk/packages.cli.txt

# Install packages based on packages.cli.txt
RUN apk --no-cache add --update $(grep -h -v '^#' /etc/apk/packages.cli.txt)

# go-centry
ARG GO_CENTRY_VERSION=1.4.0
RUN curl -L https://github.com/kristofferahl/go-centry/releases/download/v${GO_CENTRY_VERSION}/go-centry_${GO_CENTRY_VERSION}_Linux_${TARGETARCH}.tar.gz | tar -xzv -C /usr/local/bin \
  && mv /usr/local/bin/go-centry_v${GO_CENTRY_VERSION} /usr/local/bin/go-centry

# gomplate (https://docs.gomplate.ca/)
COPY --from=hairyhenderson/gomplate:stable /gomplate /bin/gomplate

# Copy filesystem
COPY rootfs/ /
RUN chmod +x /usr/local/bin/init

# Set env
ENV BASEOPS_CLI_VERSION=$BASEOPS_CLI_VERSION
ENV BASEOPS_CLI_IMAGE=$BASEOPS_CLI_IMAGE
