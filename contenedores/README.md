# Contenedores

## **1. Instalación de Docker**

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04

## **2 Introducción**

### ¿Qué es Docker?**  

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
docker pull ubuntu
docker images
docker rmi <id-imagen>
```

### **Ejecutar un contenedor**

Ejecuta un contenedor interactivo de Ubuntu:

```bash
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
```

### **Eliminar un contenedor**

```bash
docker rm <ID_del_contenedor>
```

### **Eliminar una imagen**

```bash
docker rmi <ID_de_la_imagen>
```

### **Ver el contenido del log de un contenedor**

```bash
docker logs <id_contenedor>
```

## Redes y puertos.

- Podemos vincular puertos del contenedor con el anfitrión:

```bash
docker run -d -p 8080:80 nginx
docker run -d -p 8081:80 httpd
```
## Volúmenes.

```bash
docker run --rm -v /foo -v awesome:/bar busybox top
```

## **5. Crear una imagen con un Dockerfile**
 
1. Crea un directorio de prueba: `pruebaservidor`
2. Crea un archivo llamado `Dockerfile` dentro de él:

  ```dockerfile
  # Usa Ubuntu como imagen base
  FROM ubuntu:latest

  # Instala Apache2 de manera silenciosa
  RUN apt update && apt install -y apache2

  # Copia la carpeta "html" al directorio raíz de Apache
  COPY html/ /var/www/html/

  # Expone el puerto 80 para acceder al servidor
  EXPOSE 80

  # Comando para iniciar Apache en primer plano
  CMD ["apachectl", "-D", "FOREGROUND"]
  ```

3. Crea un fichero `html/index.html` con el texto "Hola Mundo"

4. Construye la imagen:

   ```bash
   docker build -t mi-servidor-apache .
   ```

5. Ejecuta la imagen:

   ```bash
   docker run -d -p 8000:80 --name servidor-web2 mi-servidor-apache
   ```


