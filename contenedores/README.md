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
- Domandos:
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
```

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

### Variables de entorno.

- Algunas imágenes están configuradas para recibir algunas variables de entorno en la ejecución de contenedores.
- Puedes ver el ejemplo en Docker Hub, en Mysql. Allí puedes ver que existen variables como: MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD.

```bash
docker run -d -e MYSQL_ROOT_PASSWORD=password mysql
```

## **5. Crear una imagen con un Dockerfile**

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

1. Crea un fichero `html/index.html` con el texto "Hola Mundo"

2. Construye la imagen:

   ```bash
   docker build -t mi-servidor-apache .
   ```

3. Ejecuta la imagen:

   ```bash
   docker run -d -p 8000:80 --name server1 mi-servidor-apache
   docker run -d -P --name server2 mi-servidor-apache
   ```

> La opción -P usa la etiqueta EXPOSE  y en este caso equivale a `-p x:80` donde x es un puerto aleatorio

## **6. Volúmenes.**

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

## **7. Docker compose.**

- Variables de entorno
