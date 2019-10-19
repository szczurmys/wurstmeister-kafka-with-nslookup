ARG IMAGES=wurstmeister/kafka:latest
FROM ${IMAGES}

RUN if [[ -f /etc/alpine-release ]]; then \
        echo "Install alpine bind-tools"; \
        apk add --update bind-tools; \
    fi

RUN if [[ ! -f /etc/alpine-release ]]; then \
        echo "Install deb dnsutils"; \
        apt update; \
        apt -y install dnsutils; \
    fi

