# Use the Nvidia CUDA 12.1.1 development image (Ubuntu 22.04)
FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

# Avoid interactive prompts during package installs
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    libssl-dev \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libsqlite3-dev \
    libreadline-dev \
    libtk8.6 \
    tcl-dev \
    libgdbm-dev \
    curl \
    unzip \
    git \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Set Python version
ENV PYTHON_VERSION=3.10.15

# Download and build Python from source
RUN wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz && \
    tar xzf Python-$PYTHON_VERSION.tgz && \
    cd Python-$PYTHON_VERSION && \
    ./configure --enable-optimizations && \
    make -j"$(nproc)" && \
    make altinstall && \
    ln -s /usr/local/bin/python3.10 /usr/local/bin/python && \
    cd .. && \
    rm -rf Python-$PYTHON_VERSION.tgz Python-$PYTHON_VERSION

# Upgrade pip
RUN python -m pip install --upgrade pip setuptools wheel

# (Optional) Set Python 3.10 as the default python in the container
# You could do something like:
# RUN ln -s /usr/local/bin/python3.10 /usr/local/bin/python && ln -s /usr/local/bin/pip3.10 /usr/local/bin/pip



