FROM {{ .Env.BASEOPS_CLI_IMAGE }}:{{ .Env.BASEOPS_CLI_VERSION }}

# General args
ARG TARGETARCH

# Add more alpine packages
COPY packages.txt /etc/apk/packages.cli.txt

# Install packages based on packages.cli.txt
RUN apk --no-cache add --update $(grep -h -v '^#' /etc/apk/packages.cli.txt)

# Set go-centry as entrypoint
ENTRYPOINT ["go-centry"]
