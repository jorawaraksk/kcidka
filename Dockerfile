FROM python:3.9.7-bullseye

RUN mkdir /bot && chmod 777 /bot
WORKDIR /bot

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git wget pv jq python3-dev mediainfo ca-certificates gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=mwader/static-ffmpeg:7.0 /ffmpeg /bin/ffmpeg
COPY --from=mwader/static-ffmpeg:7.0 /ffprobe /bin/ffprobe

COPY . .
RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["bash", "run.sh"]
