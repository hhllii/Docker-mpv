#clone the Dockerfile from my github
git clone https://github.com/hhllii/Docker-mpv.git
#go to the dockerfile
cd Docker-mpv
#create the docker locally
sudo docker build -t local/mpv .
#pull my docker image from docker hub 
sudo docker pull hhllii/mpv
