## **6. Redes.**

- Los contenedores se construyen con una tarjeta de red llamada `eth0`.
- Si queresmos que dos contenedores se comuniquen entre sí debemos decir que están conectados a la misma red.
- Primero debemos crear la red: `docker network create red-de-prueba`
- Después debemos crear los contenedores conectados a dicha red: `docker run -d -p 8001:80 --network=red-de-prueba httpd`
- Vamos a ver un ejemplo real donde dos contenedores albergan un servicio mysql y otro con apache+php.

- Crear la red:

```bash
docker network create mi-red
```

- Crear la base de datos. Vamos a definir en una orden todos los parámetros: nombre del contenedor, volumen de los datos, red y las variables de entorno para la demo. Usamos la contrabarra ("\") para escribir el comando en varias líneas. 

```bash

docker run -d \
  --name mi-db \
  -e MYSQL_ROOT_PASSWORD=password \
  -e MYSQL_DATABASE=demo \
  -e MYSQL_USER=demo \
  -e MYSQL_PASSWORD=demo \
  -v ./mysql_data:/var/lib/mysql \
  --network mi-red \
  mysql:5.7
```

> Nota: el contenedor mysql es lento en su configuración inicial. Estará en servicio cuando el comando "docker logs <id-contenedor> muestre la versión de Mysql el puerto usado, el 3306

- Construir la imagen del servidor. Vamos a usar un Apache con php. Es una imagen oficial de php pero no tiene complementos y debemos instalarle el complemento para conectarse a mysql:

```docker
# Contenido del Dockerfile
FROM php:7.2-apache
RUN docker-php-ext-install mysqli
```

- Construimos la imagen

```bash
docker build -t mi-servidor-apache .
```

- Correr el contenedor apache

```bash
docker run -d \
  -p 8000:80  \
  -v ./app:/var/www/html \
  --network mi-red\
  mi-servidor-apache
```
