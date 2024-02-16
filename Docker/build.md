builda a imagem localmente
docker build --no-cache -t name_image .

faz o login no docker
docker login

Cria o nome do pacote com a tag
docker tag name_image name_user/pacote:versao

Envia a imagem para o docker
docker push name_user/pacote:versao