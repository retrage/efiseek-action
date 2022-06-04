FROM ghcr.io/blacktop/ghidra:latest

ARG EFISEEK_VERSION="v0.0.3"
ARG EFISEEK_ZIP="ghidra_10.1.4_PUBLIC_20220604_efiSeek.zip"
ARG EFISEEK_URL="https://github.com/retrage/efiSeek/releases/download/${EFISEEK_VERSION}/${EFISEEK_ZIP}"

# Install dependencies
RUN apt-get update \
  && apt-get -yq upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    python3 \
    python3-pip \
    wget \
    unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Download and extract efiSeek
RUN wget -P /ghidra/Ghidra/Extensions ${EFISEEK_URL} \
  && cd /ghidra/Ghidra/Extensions \
  && unzip -q ${EFISEEK_ZIP}

# Install Python dependencies
COPY requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt 

COPY entrypoint.sh /entrypoint.sh
COPY scripts/gen_report.py /gen_report.py

ENTRYPOINT [ "/entrypoint.sh" ]
