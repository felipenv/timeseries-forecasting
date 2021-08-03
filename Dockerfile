FROM ubuntu:18.04

RUN apt-get update                                                                          \
    && apt-get install -y git                                                               \
    && export DEBIAN_FRONTEND=noninteractive                                                \
    && apt-get update -y                                                                    \
    && apt-get -y install tmux                                                              \
    && apt-get install -y --no-install-recommends python                                    \
    && apt-get install software-properties-common -y                                        \
############
            build-essential python-dev python3-dev curl wget                                \
            libssl-dev                                                                      \
            libffi-dev                                                                      \
            libkrb5-dev                                                                     \
            liblzma-dev                                                                     \
            jq                                                                              \
            vim
############

#install python 3 in the image
RUN apt-get -y install python3-pip
RUN pip3 install --upgrade pip
# fix encoding issues
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# install python specific packages
COPY requirements.txt .
RUN pip3 install --user -r requirements.txt

# making stdout unbuffered (any non empty string works)
ENV PYTHONUNBUFFERED="thisistheway"

# install zsh
RUN apt install zsh -y
RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# COPY src src