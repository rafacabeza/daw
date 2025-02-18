# Contenedores

## **1. Instalación de Docker**

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04

## **2 Introducción**

### **¿Qué es Docker?**  

Docker es una **plataforma de virtualización** que permite empaquetar, distribuir y ejecutar aplicaciones junto con todas sus dependencias en un entorno aislado llamado **contenedor**. Esto facilita la portabilidad, escalabilidad y despliegue de aplicaciones en diferentes entornos sin preocuparse por configuraciones específicas del sistema operativo o conflictos de dependencias.

### **¿Qué es un contenedor en Docker?**

Un **contenedor** es una **unidad de software ligera y portable** que incluye todo lo necesario para ejecutar una aplicación:  

- Código de la aplicación  
- Dependencias y librerías  
- Variables de entorno  
- Configuración del sistema  

Los contenedores se ejecutan de manera **aislada**, lo que significa que pueden compartir el mismo núcleo del sistema operativo pero sin interferir entre sí. Esto los hace más eficientes que las máquinas virtuales, ya que **consumen menos recursos** y se inician rápidamente.

![Comparación contenedor-máquina virtual](/assets/contenedores/comparacion.png)

---

💡 **Ejemplo simple de uso de Docker:**  

```bash
docker run -d -p 8080:80 nginx
```

Esto descarga y ejecuta un contenedor con el servidor web Nginx, accesible en `http://localhost:8080`. 🚀

### **Conceptos clave**

- **Imagen**: Es una plantilla inmutable que contiene todo lo necesario para ejecutar una aplicación (código, dependencias, sistema operativo, etc.).
- **Contenedor**: Es una instancia en ejecución de una imagen.
- **Dockerfile**: Archivo donde defines cómo construir tu imagen.
- **Docker Hub**: Repositorio público de imágenes preconstruidas.

## **3. Comandos básicos**

### **Iniciar Docker**

Asegúrate de que Docker esté corriendo:
```bash
sudo systemctl start docker
sudo systemctl enable docker  # Para iniciar Docker al arrancar el sistema
```

### **Imágenes**

#### ¿Dónde están las imágenes?

- Docker Hub
- Comandos:
  - docker pull
  - docker images
  - docker rmi
  - Etiquetas. Ver Docker Hub y en los comandos


Ejemplo: Descargar la imagen de Ubuntu:

```bash
# descargar una imagen
docker pull ubuntu  
# ver lista de imágenes
docker images
# borrar una imagen
docker rmi <id-imagen>
# borrar todas las imagenes
docker rmi $(docker images -aq)
```

### **Ejecutar un contenedor**

Para ejecutar un contenedor debemos usar `docker run`:

```bash
# comando base
docker run ubuntu
# ejecución interactiva (-i), y con terminal (-t)
docker run -it ubuntu
```****

### **Listar contenedores**

- Contenedores activos:

  ```bash
  docker ps
  ```

- Todos los contenedores (activos e inactivos):

  ```bash
  docker ps -a
  ```

### **Detener un contenedor e iniciar uno parado**

```bash
docker stop <ID_del_contenedor>
docker start <ID_del_contenedor>
# ID_del_contenedor puede ser su nombre o el hash numérico.
# Podemos poner sólo unos pocos caracteres del hash
# Si optamos por el nombre, podemos usar el tabulador
```

### **Eliminar un contenedor**

```bash
docker rm <ID_del_contenedor>
# borrado forzado, incluso si el contenedor está corriendo
docker rm -f <ID_del_contenedor>
# para borrar todos los contenedores:
docker rm $(docker ps -aq)
docker rm -f $(docker ps -aq)
# esto se basa en este comando que lista los contenedores por su hash
docker ps -aq
```

### **Ver el contenido del log de un contenedor**

```bash
docker logs <id_contenedor>
```

### Puertos.

- Aunque un contenedor tenga un servicio abierto, está dentro de un _sandbox_. Es un cajón de arena aislado del host anfitrión.
- Podemos vincular puertos del contenedor con el anfitrión con la opción `-p`:

```bash
docker run -d -p 8080:80 nginx
docker run -d -p 8081:80 httpd
```

- Prueba esos comandos y accede a tu navegador web: http://localhost:8000 y http://localhost:8001

### Ejecución de comandos:

- Cuando un contenedor está en ejecución permite ejecutar comandos dentro del mismo:

```bash
docker exec <id-contenedor> <comando>
#ejemplo
docker exec mi-contenedor ls -la
```

- Además este comando puede ser interactivo con los parámetros `it`. Y el caso más típico es usar `bash` o `sh` que son los intérpretes de comandos

```bash
docker exec -i <id-contenedor> bash
docker exec -i <id-contenedor> sh
```

### Variables de entorno.

- Em el fichero de configuración de una imagen, en el Dockerfile, podemos usar las etiquetas `ENV` y `ARG`. Estas etiquetas definen variables de entorno que están disponibles dentro del contenedor y pueden usarse para realizar tareas en la construcción o configuración del mismo.
- Las etiquetas `ARG` sólo en existen durante la construcción del contenedor.
- Las etiquetas `ENV` son más habituales. Están disponibles en la ejecución del mismo.
- Puedes ver el ejemplo en Docker Hub, en Mysql. Allí puedes ver que existen variables como: MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD.

```bash
docker run --name=mi-mysql -d -e MYSQL_ROOT_PASSWORD=password mysql
```


```bash
docker exec -it mi-mysql sh
echo ${MYSQL_ROOT_PASSWORD}
```




## 4 **Crear una imagen con un Dockerfile (ej01)**

Podemos crear nuestra propias imágenes. Para hacerlo:

- Se recomienda tomar un directorio de trabajo
- Crear en el un fichero llamado `Dockerfile`. El nombre podría cambiarse pero complica algunas cosas. No lo vamos a hacer.
- Seguir una sintáxis y un orden determiados que vamos a ver con un ejemplo:

1. Crea un directorio de prueba: `ubuntuapache`
2. Crea un archivo llamado `Dockerfile` dentro de él:

  ```dockerfile
  # Usa Ubuntu como imagen base
  # FROM es la primera línea, necesaria simpre
  # FROM ubuntu:latest esta opción no es recomendable
  FROM ubuntu:24.04

  # Instala Apache2 de manera silenciosa
  # Permite instalar y/o modificar el estado original de la imagen
  # En este caso instala apache2 en Ubuntu
  RUN apt update && apt install -y apache2

  # Copia la carpeta "html" al directorio raíz de Apache
  # COPY permite copiar ficheros dentro de la imagen que serán inmutables
  # Siempre estarán igual cada vez que usemos el docker run
  # Permite añadir el código de nuestra aplicación o ficheros de configuración  
  COPY html/ /var/www/html/

  # Expone el puerto 80 para acceder al servidor
  # No es obligatorio su uso. Tiene una función de documentación principalmente
  EXPOSE 80

  # Comando para iniciar Apache en primer plano
  # Puede usarde ENTRYPOINT  o CMD, o una combinación de ambos.
  CMD ["apachectl", "-D", "FOREGROUND"]
  ```

3. Crea un fichero `html/index.html` con el texto "Hola Mundo"

4. Construye la imagen:

  ```bash
  docker build -t mi-servidor-apache .
  ```

5. Ejecuta la imagen:

  ```bash
  docker run -d -p 8000:80 --name server1 mi-servidor-apache
  ```

> Esta imagen acaba montando un servicio. Si no incluimos "-d" dejaremos la consola bloqueada y posiblemente mostrnao información de la actividad de dicho servicio.
> Otra opción menos práctica
>   docker run -d -P --name server2 mi-servidor-apache
> La opción -P usa la etiqueta EXPOSE  y en este caso equivale a `-p x:80` donde x es un puerto aleatorio

6. Para reconstruir una imagen:
   - La borramos: `docker rmi <nombre-imagen>`
   - La volvemos a construir: `docker build -t mi-servidor-apache .`
   - Revisa el tiempo de creación. Si quieres que sea reconstruida sin basarse en las capas que hay en caché: `docker build -t mi-servidor-apache . --no-cache`

## **5. Volúmenes.**

- El contenido de un contenedor no es persistente. Si es un contenido cambiante como una base de datos, cada vez que recreemos el contenedor, sus cambios se perderán.
- El uso de `COPY` permite incluir nuestro código en la imagen pero esa vía lo hace de forma estática. No podemos cambiarlo e ir probando. Imagina que estamos editando un sitio o aplicación web.
- Para solucionar ambos problemas disponemos de los volúmenes.
- Podemos crear el volumen de forma explícita en la ubicación que queramos

```bash
docker run -d -v ./html:/var/www/html  -p 80:80 mi-servidor-apache
docker run -d -v ./mysqldata:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password mysql
```

- O podemos dejar que lo gestione docker:

```bash
docker run -d -v mysqldata:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password mysql
#para saber dónde están ubicados los datos de mysqldata:
docker inspect mysqldata
docker volume inspect mysqldata
```

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

## **7. Docker compose.**

### ** ¿Qué es Docker Compose?**  

Docker Compose es una herramienta que permite definir y ejecutar aplicaciones Docker que constan de múltiples contenedores. Usando un archivo YAML (`docker-compose.yml`), se pueden configurar los servicios, redes y volúmenes de una aplicación y desplegarlos con un solo comando.

### ** Estructura del archivo `docker-compose.yml`**  

El archivo `docker-compose.yml` define cómo se orquestan los contenedores.  

#### **Ejemplo básico de `docker-compose.yml`**  
```yaml
version: "3.8"
services:
  web:
    image: nginx
    ports:
      - "8080:80"
  db:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: example
    volumes:
      - db_data:/var/lib/mysql
volumes:
  db_data:
```

#### **Secciones principales del archivo**  

- `version`: Define la versión de Docker Compose (obsoleta a día de hoy).  
- `services`: Lista los contenedores de la aplicación.  
- `volumes`: Define volúmenes persistentes.  
- `networks`: Configura redes personalizadas.  
- `configs` y `secrets`: Gestionan configuración y credenciales sensibles.


### **Elementos dentro de `services`**  

Dentro de `services`, cada contenedor puede tener múltiples opciones. Aquí tienes una lista completa:

#### **Configuración básica**

- `image`: Imagen a usar, por ejemplo, `nginx:latest`.
- `container_name`: Nombre personalizado del contenedor.
- `hostname`: Define un hostname para el contenedor (visible sólo desde dentro del mismo).
- `command`: Sobrescribe el comando por defecto de la imagen.
- `entrypoint`: Define un punto de entrada personalizado.

#### **Redes y conectividad**

- `ports`: Expone puertos en formato `"host:contenedor"`, ej. `"8080:80"`.
- `networks`: Define en qué redes estará el contenedor.
- `depends_on`: Indica dependencia de otros servicios.
- `links`: Conecta contenedores dentro de una red de Docker (obsoleto en favor de `networks`).

#### **Almacenamiento y volúmenes**

- `volumes`: Monta volúmenes en el contenedor.
- `tmpfs`: Usa almacenamiento en memoria.
- `configs`: Monta archivos de configuración gestionados por Docker.
- `secrets`: Monta secretos de forma segura.

#### **Variables de entorno**

- `environment`: Lista de variables en formato clave-valor.
- `env_file`: Carga variables desde un archivo `.env`.

#### **Recursos y limitaciones**

- `deploy`: Define configuración avanzada de despliegue (solo para Swarm).
- `restart`: Política de reinicio (`always`, `unless-stopped`, `on-failure`, `no`).
- `cpu_shares`, `mem_limit`: Controla recursos asignados.

#### **Ejemplo completo**

```yaml
version: "3.8"
services:
  app:
    image: node:18
    container_name: mi_app
    command: ["node", "server.js"]
    environment:
      NODE_ENV: production
    ports:
      - "3000:3000"
    networks:
      - frontend
    volumes:
      - ./app:/usr/src/app
    depends_on:
      - db
    restart: always

  db:
    image: mysql:8
    container_name: mi_db
    environment:
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: mydb
    volumes:
      - db_data:/var/lib/mysql
    networks:
      - backend

networks:
  frontend:
  backend:

volumes:
  db_data:
```

### **Comandos útiles de Docker Compose**  

#### **Arrancar y detener servicios**

```bash
docker compose up        # Inicia en primer plano
docker compose up -d     # Inicia en segundo plano
docker compose down      # Detiene y elimina contenedores
docker compose restart   # Reinicia los contenedores
```

#### **Administrar contenedores**

```bash
docker compose ps        # Lista los contenedores en ejecución
docker compose logs      # Muestra los logs
docker compose logs -f   # Sigue los logs en tiempo real
```

#### **Ejecutar comandos en un servicio**

```bash
docker compose exec app bash   # Accede al contenedor
docker compose exec app ls     # Ejecuta un comando dentro
```

#### **Gestionar volúmenes y redes**

```bash
docker compose volume ls    # Lista volúmenes
docker compose network ls   # Lista redes
```


### Ejemplos de entornos de desarrollo:

- https://github.com/rafacabeza/demoappphp
- https://github.com/rafacabeza/demoapinode
- https://github.com/rafacabeza/entornods