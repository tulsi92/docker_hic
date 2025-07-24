# Newer version of micromamba with lots of features
FROM mambaorg/micromamba:1.5.8
# Copy env file. must be chowned to the micromamba user
COPY --chown=micromamba:micromamba R.yaml /tmp/env.yaml
# Install the environment. This is done as the micromamba user so superuser commands will not work
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

# Install pairsamtools
RUN pip install git+https://github.com/mirnylab/pairsamtools


# Change user to root to make root directory and chown it to mamba user. Mamba env is not active here
USER root
RUN apt-get update && \
    apt-get install --no-install-recommends -qy curl unzip && \
    apt-get clean && \
    apt-get autoclean && \
    mkdir /magma && \
    cd /magma && \
    curl https://vu.data.surfsara.nl/index.php/s/lxDgt2dNdNr6DYt/download > magma.zip && \
    unzip magma.zip && \
    rm magma.zip && \
    chmod +x magma && \
    chown -R mambauser:mambauser /magma

# below is necessary for the env to work with shell sessions
ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "/magma/magma"]
