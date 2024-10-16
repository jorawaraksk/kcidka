FROM python:3.9.7-slim-buster
RUN mkdir /bot && chmod 777 /bot
WORKDIR /bot
ENV DEBIAN_FRONTEND=noninteractive
RUN apt -qq update && apt -qq install -y git wget pv jq python3-dev mediainfo
# Install latest ffmpeg
COPY --from=mwader/static-ffmpeg:7.0 /ffmpeg /bin/ffmpeg
COPY --from=mwader/static-ffmpeg:7.0 /ffprobe /bin/ffprobe

COPY . .
RUN pip3 install -r requirements.txt
EXPOSE 8080

RUN sed -i 's/flask run/flask run --host=0.0.0.0 --port=8080/g' run.sh
CMD ["bash","run.sh"]
