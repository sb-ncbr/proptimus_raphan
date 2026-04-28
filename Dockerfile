FROM python:3.13-slim

WORKDIR /opt/proptimus

# Setup OS
RUN apt-get update \ 
    && apt-get install -y --no-install-recommends wget bzip2 procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --create-home --shell /bin/bash user \
    && chown -R user:user /opt/proptimus

# Switch to non-root user
USER user

# Setup Miniconda
ENV PATH="/home/user/miniconda3/bin:${PATH}"

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
    && bash miniconda.sh -b -p $HOME/miniconda3 \
    && rm miniconda.sh \
    && conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main \
    && conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r \
    && conda install -y -c conda-forge \
        libgfortran=3.0.0 \
        xtb=6.6.1 \
        biopython=1.85 \
        rdkit=2025.09.1 \
        tqdm=4.67.1 \
    && conda clean -afy

# Copy application
COPY raphan.py .

CMD ["python", "raphan.py"]
