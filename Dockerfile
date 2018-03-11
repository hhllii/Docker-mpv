#Dockerfile for mpv
#https://github.com/mpv-player/mpv

FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:mc3man/mpv-tests
RUN apt-get update
RUN apt-get install mpv -y
RUN apt-get install linux-tools-common -y
RUN apt-get install linux-tools-4.13.0-36-generic -y
RUN apt-get install python -y
RUN apt-get install git -y

COPY qa_1.mp4 /root
COPY qa_4.mp4 /root
COPY qa_16.mp4 /root
COPY qa_64.mp4 /root
COPY qa_256.mp4 /root
COPY qa_test.mp4 /root

WORKDIR /root

RUN git clone https://github.com/andikleen/pmu-tools.git

