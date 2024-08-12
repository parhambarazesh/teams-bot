FROM python:3.9-slim

# Set environment variables to non-interactive to avoid prompts during build
ENV DEBIAN_FRONTEND=noninteractive \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

# Set the timezone to UTC
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Install only the necessary extra dependencies
RUN apt update && apt upgrade -y && apt install -y \
    curl \
    git \
    gunicorn \
    wget \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev && \
    # Clean up apt cache to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


COPY src /src

WORKDIR /src

ENV HNSWLIB_NO_NATIVE=1


RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 3978

ENV PYTHONPATH /
ENTRYPOINT ["python3"]
CMD ["app.py"]