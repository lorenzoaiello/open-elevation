# https://github.com/OSGeo/gdal/tree/master/docker
FROM ghcr.io/osgeo/gdal:ubuntu-small-latest 

ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV CINCLUDE_PATH=/usr/include/gdal

ENV TZ=Australia/Melbourne
# Allows the packages to install without a prompt
# Something is asking for timezone because we don't have one.
RUN \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# Install OS dependencies
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf
# https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/reference.md#example-cache-apt-packages
RUN \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && \
    apt-get install -y \
    libspatialindex-dev unar bc python3-pip wget libgdal-dev gdal-bin

# Install python dependencies
ADD ./requirements.txt .
RUN pip install -r requirements.txt

ADD . /code/
WORKDIR /code
CMD python3 server.py

VOLUME [ "/code/data" ]

EXPOSE 8080
EXPOSE 8443
