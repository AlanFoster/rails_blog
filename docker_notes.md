vim Dockerfile && sudo docker build -t alan/rails .
sudo docker run -i -t alan/rails /bin/bash
sudo docker run -d -p 80:3000 alan/rails
sudo docker ps
sudo docker kill ${Id}
