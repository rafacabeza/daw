## **Crear una imagen con un Dockerfile (ej01)**

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