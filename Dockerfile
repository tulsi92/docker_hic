# Newer version of micromamba with lots of features
FROM mambaorg/micromamba:1.5.8
# Copy env file. must be chowned to the micromamba user
COPY --chown=micromamba:micromamba R.yaml /tmp/env.yaml
# Install the environment. This is done as the micromamba user so superuser commands will not work
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

# Install pairsamtools
# RUN pip install git+https://github.com/mirnylab/pairsamtools

# Below is necessary for the env to work with shell sessions
# ENTRYPOINT [pairsamtools]
ENV PATH "$MAMBA_ROOT_PREFIX/bin:$PATH"
