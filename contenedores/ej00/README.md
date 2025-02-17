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





































## Comandos básicos:

### **Con imágenes**

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




```bash
# No vale: no comparte puertos:
docker run -d httpd
docker run -d -P httpd
docker run -d -p 80:80 httpd
docker run -d -p 80:80 httpd
docker run -d -p 8000:80 nginx

# Esto funcioa pero si queremos que dentro de 2 años nuestro apache se idéntico a hoy:
docker run -d -p 80:80 httpd:2.4
docker run -d -p 8000:80 nginx:1.27.4


# Vamos a listar todos, parar todos, borrar todos...
docker ps 
docker ps -a
docker ps -aq
docker stop $(docker ps -aq)
docker rm $(docker ps -aq) 
#este para y borra (-f es forzar)
docker rm -f $(docker ps -aq)
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

- Algunas imágenes están configuradas para recibir algunas variables de entorno en la ejecución de contenedores.
- Puedes ver el ejemplo en Docker Hub, en Mysql. Allí puedes ver que existen variables como: MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD.

```bash
docker run -d -e MYSQL_ROOT_PASSWORD=password mysql
```