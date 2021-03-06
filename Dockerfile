FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections

RUN set -ex; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        ubuntu-desktop \
        unity-lens-applications \
        gnome-panel \
        metacity \
        nautilus \
        gedit \
        xterm \
        sudo \
	    firefox \
        bash \
        net-tools \
        python3-pip \
        ffmpeg \
        novnc \
        socat \
        x11vnc \
        gnome-panel \
        gnome-terminal \
        xvfb \
        supervisor \
        net-tools \
        curl \
        git \
	    wget \
        python3-setuptools \
        screen \
        python3-dev \
        libtasn1-3-bin \
        libglu1-mesa \
        libqt5webkit5 \
        libqt5x11extras5 \
        apt-transport-https \
        ca-certificates \
        snapd \
        qml-module-qtquick-controls \
        qml-module-qtquick-dialogs \
        openjdk-8-jdk \
        openjdk-8-jre \
        fakeroot \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    JAVA_HOME=/usr/lib/jvm/java-8-oracle \
    DISPLAY_HEIGHT=600 \
    RUN_XTERM=yes \
    RUN_UNITY=yes

RUN sudo add-apt-repository ppa:openjdk-r/ppa \
    && sudo apt-get update && sudo apt install -y openjdk-11-jdk

RUN sudo add-apt-repository ppa:dawidd0811/neofetch \
    && sudo apt update && sudo apt install -y neofetch

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

RUN sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && sudo apt-get update && sudo apt-get install -y docker-ce

RUN curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - \
    && echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

RUN sudo apt update && sudo apt install -y brave-browser

RUN sudo add-apt-repository ppa:maarten-fonville/android-studio \
    && sudo apt update && sudo apt install -y android-studio

RUN adduser ubuntu

RUN echo "ubuntu:ubuntu" | chpasswd && \
    adduser ubuntu sudo && \
    sudo usermod -a -G sudo ubuntu

COPY . /app

RUN chmod +x /app/conf.d/websockify.sh
RUN chmod +x /app/run.sh
USER ubuntu


CMD ["/app/run.sh"]
