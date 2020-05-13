sudo docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.6 bundle install
sudo docker-compose -f ./docker/docker-compose.build-image.yml build
