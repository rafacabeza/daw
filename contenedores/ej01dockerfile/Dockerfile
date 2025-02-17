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
