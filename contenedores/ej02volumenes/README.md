## **6. Volúmenes.**

- El contenido de un contenedor no es persistente. Si es un contenido cambiante como una base de datos, cada vez que recreemos el contenedor, sus cambios se perderán.
- El uso de `COPY` permite incluir nuestro código en la imagen pero esa vía lo hace de forma estática. No podemos cambiarlo e ir probando. Imagina que estamos editando un sitio o aplicación web.
- Para solucionar ambos problemas disponemos de los volúmenes.
- Podemos crear el volumen de forma explícita en la ubicación que queramos

```bash
docker run -d -v ./html:/var/www/html  -p 80:80 mi-servidor-apache
docker run -d -v ./mysqldata:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password mysql
```
> Tras ejecutar esos dos comandos:
> Accede a tu navegador para ver el funcionamiento
> Comprueba si se ha creado algún directorio en la carpeta de trabajo

- O podemos dejar que lo gestione docker:

```bash
docker run -d -v mysqldata:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password mysql
# también se ha creado un volumen pero está escondido:
# para saber dónde están ubicados los datos de mysqldata:
docker inspect mysqldata
docker volume inspect mysqldata
```
