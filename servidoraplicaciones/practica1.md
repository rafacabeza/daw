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

- Instalar MySql:

```bash
sudo apt install mysql-server
```

- Instalar php y los complementos para apache y mysql:

```bash
sudo apt install php libapache2-mod-php php-mysql
```

  - Ojo, podríamos haber especificado la versión de php

```bash
sudo apt install php7.2
```

  - Podemos ver la versión instalada.

```bash
php -v
```

### Configurar mysql

- Conectarse a mysql

```bash
sudo mysql
```

- Crear una base de datos.

```bash
mysql> CREATE DATABASE example_database;
```

- Crear usuario y darle permisos sobre la base de datos.

```bash
mysql> CREATE USER 'usuario'@'%' IDENTIFIED WITH mysql_native_password BY 'password';

mysql> GRANT ALL ON example_database.* TO 'example_user'@'%';
```

- A continuación cierra sesión usando `exit` y prueba la conexión con el nuevo usuario:

### Instalar phpMyAdmin.

- Hay que instalar el paquete y algunos complementos:

```bash
sudo apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl

```

- Activar el módulo `mbstring` y reiniciar apache.

```bash
sudo phpenmod mbstring
sudo systemctl restart apache2
```

### Crea una tabla y muestra el contenido en una aplicación web.

- Crea un hostvirtual y actívalo ....
- Crea una carpeta `/var/www/web1` y descarga ahí un index de esta dirección. [https://github.com/rafacabeza/entornods/tree/master/data](https://github.com/rafacabeza/entornods/tree/master/data)
- Carga tu base de datos con una tabla y registros de prueba. Los tienes en la misma dirección.

