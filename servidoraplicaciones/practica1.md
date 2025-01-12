# Práctica 1

Configurar nuestro apache para que sirva aplicaciones web con PHP y MySql.

## Objetivos

- Instalar PHP
- Instalar los complementos necesarios de Apache2
- Instalar MySql y configurar su acceso
- Desplegar una aplicación que haga uso de ambos recursos
- Instalar PhpMyAdmin

## Punto de partida

- **Máquinas**. Vamos a usar máquinas definidas por el profesor mediante despliegues:
  - Server
  - Cliente Ubuntu
- Vamos a usar una pequeña aplicación web que use php y mysql.

## Configuración del Ubuntu Server

### Instalación:

Puedes revisar este tutorial: https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-20-04-es


#### Instalar MySql:

```bash
sudo apt install mysql-server
```

**Notas sobre la autenticación en las versiones actuales de MySql:**
- En versiones anteriores, en el proceso de instalación se asignaba una contraseña. Eso no ocurre actualmente.
- Actualmente, en linux, se puede acceder como root con las credenciales del usuario root del sistema operativo.
- También se crea un usuario especial y su contraseña. Dicho usuario está disponible en el fichero `/etc/mysql/debian.cnf`.


#### Instalar php y los complementos para apache y mysql:

```bash
sudo apt install php libapache2-mod-php php-mysql
```

  - Ojo, la versión instalada es la definida por defecto en los repositorios Ubuntu. Para hacer la instalación de otra versión debemos añadir nuevos repositorios. De forma orientativa, sería algo así:

```bash
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php7.2
```

  - Podemos ver la versión instalada.

```bash
php -v
```

### Configurar mysql

> [!INFO]
> Este enlace es muy interesante [https://josejuansanchez.org/bd/practica-01/index.html#mysql](https://josejuansanchez.org/bd/practica-01/index.html#mysql)


- Conectarse a mysql.

```bash
sudo mysql
//observa que la conexión es sin contraseña. Esta vía sólo es válida para el root.
```

- Para una situación real de producción se recomienda crear una base de datos por cada proyecto y un usuario exclusivo para dicha base de datos. veamos cómo hacer ambas cosas.
- Crear una base de datos.

```bash
mysql> CREATE DATABASE example_database;
```

- Crear usuario y darle permisos sobre la base de datos.

  - Varios ejemplos de creación de usuario:

```bash
//genérico
mysql> CREATE USER 'nombre_usuario'@'IP_MÁQUINA_CLIENTE' IDENTIFIED BY 'contraseña';
//conexión desde la máquina local
mysql> CREATE USER 'nombre_usuario'@'localhost' IDENTIFIED BY 'contraseña';
//conexión desde cualquier dirección de red
mysql> CREATE USER 'nombre_usuario'@'%' IDENTIFIED BY 'contraseña';

mysql> CREATE USER 'usuario'@'%' IDENTIFIED WITH mysql_native_password BY 'password';
mysql> CREATE USER 'usuario'@'%' IDENTIFIED WITH mysql_native_password BY 'password';

mysql> GRANT ALL PRIVILEGES ON 'base_de_datos'.* TO 'nombre_usuario'@'IP_MÁQUINA_CLIENTE';
```

- Para ver qué usuarios existen en el sistema:

```mysql
//usar la base de datos del sistema
use mysql;
//consultar la tabla de usuarios
SELECT 
```

- A continuación cierra sesión usando `exit` y prueba la conexión con el nuevo usuario:

### Instalar phpMyAdmin.

- Hay que instalar el paquete y algunos complementos:

```bash
sudo apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl

```

> [!IFNO]
> Ojo. En el proceso hay que indicar que se va a usar apache
> Además, se creará un usuario phpmyadmin en mysql para el que nos pedirá una contraseña.

- Activar el módulo `mbstring` y reiniciar apache.

```bash
sudo phpenmod mbstring
sudo systemctl restart apache2
```

- Podemos usar phpmyadmin accediendo a la dirección: http://ip-servidor/phpmyadmin
- La configuración del mismo está guardada en `/etc/phpmyadmin`

### Crea una tabla y muestra el contenido en una aplicación web.

- Crea un hostvirtual y actívalo ....
- Crea una carpeta `/var/www/web1` y descarga ahí un index de esta dirección. [https://github.com/rafacabeza/entornods/tree/master/data](https://github.com/rafacabeza/entornods/tree/master/data)
- Carga tu base de datos con una tabla y registros de prueba. Los tienes en la misma dirección.

