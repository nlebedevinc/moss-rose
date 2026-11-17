# Build the themes in a small image
FROM python:3.12-slim AS build
ARG VARIANT=dark
ENV PYTHONDONTWRITEBYTECODE=1 \
    THEME_VARIANT=${VARIANT}
WORKDIR /src
COPY build.py gallery.py ./
COPY samples/ samples/
RUN pip install --no-cache-dir pygments==2.19.2 \
 && python3 build.py

FROM scratch AS out
COPY --from=build /src/ghostty /ghostty
LABEL org.opencontainers.image.title="moss-rose"
