FROM adelmofilho/r-base:4.0.0

RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    xauth \
    xfonts-base

WORKDIR /Realth
COPY . .

RUN R -e 'renv::consent(provided = TRUE)'
RUN R -e 'renv::init()'
RUN R -e 'renv::restore()'

ENTRYPOINT ["Rscript", "app.R"] 