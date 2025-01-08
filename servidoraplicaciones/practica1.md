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