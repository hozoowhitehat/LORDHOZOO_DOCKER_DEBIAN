# LORDHOZOO_DOCKER_DEBIAN

💀 install desktop by hozoo no counter ☠️

cd

rm -rf LORDHOZOO_DOCKER_DEBIAN

git clone https://github.com/hozoowhitehat/LORDHOZOO_DOCKER_DEBIAN

cd LORDHOZOO_DOCKER_DEBIAN

bash start.sh

docker build -t debian-novnc .

docker run -d -p 8080:8080 --name debian-novnc debian-novnc
