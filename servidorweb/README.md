# Servidor web

Un **servidor web** es un tipo de servidor que almacena, procesa y entrega contenido web a los usuarios a través de Internet. Su función principal es servir páginas web a los navegadores cuando estos envían una solicitud, como cuando escribimos una dirección web en la barra de direcciones de un navegador.

### ¿Cómo funciona un servidor web?

1. **Solicitud HTTP**: Cuando un usuario quiere ver una página web, su navegador (como Google Chrome, Firefox o Safari) envía una solicitud HTTP (o HTTPS, que es la versión segura) a un servidor web. Esta solicitud incluye la URL (dirección web) de la página que el usuario quiere cargar.

2. **Procesamiento**: El servidor web recibe la solicitud, la procesa y busca los archivos solicitados. Si la página es dinámica, el servidor también puede ejecutar algún tipo de procesamiento, como ejecutar código en un lenguaje de programación (PHP, Python, etc.) o consultar una base de datos para obtener el contenido adecuado.

3. **Respuesta HTTP**: Una vez procesada la solicitud, el servidor devuelve una respuesta. Esto puede incluir el HTML de la página solicitada, imágenes, hojas de estilo (CSS), archivos JavaScript, o cualquier otro recurso necesario para que la página se muestre correctamente en el navegador.

4. **Entrega de contenido**: El navegador recibe la respuesta y presenta la página al usuario.

### Tipos de servidores web

Existen diferentes tipos de servidores web, dependiendo del software que utilicen. Algunos de los más populares son:

- **Apache HTTP Server**: Uno de los servidores web más conocidos y ampliamente usados en el mundo.
- **Nginx**: Es muy popular por su eficiencia y capacidad para manejar muchas solicitudes concurrentes.
- **Microsoft IIS** (Internet Information Services): Utilizado principalmente en entornos Windows.
- **LiteSpeed**: Conocido por su velocidad y por ser utilizado en sitios de alto tráfico.

### Funciones adicionales de un servidor web

- **Seguridad**: Los servidores web pueden implementar medidas de seguridad, como el uso de HTTPS (que cifra la comunicación entre el navegador y el servidor), autenticación de usuarios, y protección contra ataques.
- **Almacenamiento de contenido estático y dinámico**: Los servidores pueden entregar contenido estático (archivos que no cambian, como imágenes o documentos) y dinámico (páginas que se generan sobre la marcha, como las de un foro o una tienda en línea).
- **Control de tráfico**: Pueden gestionar la cantidad de tráfico que reciben y distribuir las solicitudes de manera eficiente, especialmente en grandes sitios web.


### Características del servicio HTTP:

1. **Protocolo sin estado**: Esto significa que cada solicitud HTTP es independiente de las anteriores. No se guarda ningún estado entre las interacciones, lo que hace que cada solicitud sea tratada de manera aislada.

2. **Basado en texto**: Las solicitudes y respuestas HTTP son enviadas en formato de texto plano, lo que facilita su comprensión y depuración.

3. **Modelo cliente-servidor**: El cliente (generalmente un navegador) realiza una solicitud, y el servidor responde con los datos solicitados.

4. **Puertos**: El protocolo HTTP utiliza el puerto 80 por defecto, mientras que HTTPS (su versión segura) utiliza el puerto 443.

### El servidor Apache HTTP

**Apache HTTP Server**, comúnmente conocido como **Apache**, es uno de los servidores web más populares para servir contenido en la web. Es un servidor que implementa el protocolo HTTP (y HTTPS) y es capaz de manejar las solicitudes que provienen de los navegadores web para servir páginas y otros recursos.

#### Características clave de Apache:

- **Servidor de código abierto**: Apache es gratuito y de código abierto, lo que significa que se puede modificar y personalizar.
- **Configurabilidad**: Apache es muy configurable a través de sus archivos de configuración, como `httpd.conf` y `.htaccess`.
- **Módulos**: Apache utiliza módulos para extender su funcionalidad, como la compresión de archivos, redirección, autenticación, entre otros.
- **Compatibilidad con otros protocolos**: Aunque principalmente es un servidor HTTP, Apache también puede manejar otros protocolos como HTTPS (a través de mod_ssl), FTP y más.

### Configuración básica de un servidor Apache HTTP

#### 1. Instalación de Apache

Dependiendo del sistema operativo, el proceso de instalación puede variar.

- En **Ubuntu/Debian**:
  ```bash
  sudo apt update
  sudo apt install apache2
  ```

Una vez instalado, puedes verificar que el servidor Apache esté funcionando visitando `http://localhost` desde un navegador. Si está correctamente configurado, verás la página predeterminada de Apache.

También puedes hacer otras verificaciones:

1. Comprobar que el puerto 80 (y/o el 443) están en escucha: 

```bash
netstat -ltn
```

1. Y puedes comprobar si el servicio está corriendo con uno de estos comandos (son equivalentes):

```bash
sudo sytemctl status apache2
sudo service apache2 status 
```

#### 2. Archivos de configuración

**Archivo principal de configuración**: 
En Ubuntu, el archivo principal de configuración es `/etc/apache2/apache2.conf`. En otras distrubiciones se llama `httpd.conf`. Aquí se definen aspectos importantes como el puerto de escucha, la ubicación de los archivos del sitio web, y la carga de módulos.

Por ejemplo:
```apache
Listen 80
DocumentRoot "/var/www/html"
```

En este caso, Apache escuchará las solicitudes en el puerto 80 y servirá archivos desde el directorio `/var/www/html`.

En el propio documento hay una amplia explicación, en inglés, de lo que significa cada parte. Además, por facilidad de uso, en Debian y Ubuntu la configuración se reparte en varios ficheros que son incluidos en este principal.

**Configuración de los hosts virtuales (Virtual Hosts)**:
HTTP/1.1 incluyó una cabecera _Host_ lo que permitió que un servidor pudiera servir múltiples sitios web. Para hacer uso de esta funcionalidad debemos definir _host virtuales_.
Un host virtual permite que un servidor web maneje múltiples sitios web en el mismo servidor físico, diferenciándolos por el nombre de dominio.

En el archivo de configuración, puedes definir un host virtual:
```apache
<VirtualHost *:80>
    ServerAdmin webmaster@tusitio.com
    DocumentRoot "/var/www/tusitio"
    ServerName www.tusitio.com
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

En este ejemplo, Apache:

- Desde cualquiera de las IP de la máquina y a través del puerto 80
- Servirá el contenido desde `/var/www/tusitio` 
- Cuando se acceda a `www.tusitio.com`.

**Habilitación de sitios**:
En muchas distribuciones de Apache, como en Ubuntu, se utilizan directorios como `/etc/apache2/sites-available/` y `/etc/apache2/sites-enabled/` para organizar los sitios. Un archivo de configuración de sitio puede ser habilitado con:

```bash
sudo a2ensite tusitio.conf
sudo systemctl reload apache2
```

Para deshabilitar un sitio usaremos `a2dissite tusitio.conf`

#### 3. Configuración de seguridad

Puedes seguir este tutorial: https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-20-04-es

Una parte importante de la configuración de Apache es asegurar la comunicación a través de **HTTPS**, para lo cual se necesita configurar un certificado SSL. Esto se puede hacer instalando el módulo `mod_ssl` y configurando los archivos correspondientes en Apache.

Para habilitar SSL en Apache y añadire el módulo correspondiente:

```bash
sudo apt install openssl
sudo a2enmod ssl
```

Luego, debes configurar el archivo de host virtual para HTTPS:

```apache
<VirtualHost *:443>
    ServerAdmin webmaster@tusitio.com
    DocumentRoot "/var/www/tusitio"
    ServerName www.tusitio.com
    SSLCertificateFile /etc/ssl/certs/tu-certificado.crt
    SSLCertificateKeyFile /etc/ssl/private/tu-clave-privada.key
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

Cada vez que realices cambios en la configuración, es necesario reiniciar Apache para que los cambios surtan efecto:
```bash
sudo systemctl restart apache2
```

#### 4. Forzar HTTPS

Para nuestro sitio web debemos tener dos etiquetas, una para el puerto 80 y otra para el 443.

<VirtualHost *:80>
  (...)
	Redirect permanent / https://localhost
</VirtualHost>

<VirtualHost *:443>
  (...)
</VirtualHost>


#### 5. Archivos de registro

Apache genera archivos de registro para ayudar a monitorear el tráfico y solucionar problemas. Los archivos de registro se encuentran típicamente en:

- **Access log**: Registra las solicitudes HTTP recibidas por el servidor.
- **Error log**: Registra los errores que ocurren en el servidor.

Por defecto, los registros se encuentran en `/var/log/apache2/` en sistemas basados en Debian y `/var/log/httpd/` en sistemas RedHat/CentOS.


### ¿Qué versión usamos HTTP en nuestro servidor Apache?

- Por defecto, Apache usa HTTP/1.1. La versión creada en 1997.
- Podemos usar la versión HTTP/2 creada en 2015 y que permite multiples peticiones en una misma conexión TCP de forma eficiente. Comprueba qué versión se usa en tu servidor antes de habilitar esta versión.
- Para hacerlo debes:
  - Usar HTTPS. No es obligado estrictamente pero los navegadores actuales sólo soportan HTTP/2 si hay cifrado HTTPS.
  - Activa el módulo HTTP/2: `sudo a2enmod http2`
  - Reinicia `systemctl restart apache2`
  - Para activar HTTP/2 añade la directiva _Protocols_ a tu configuración global de Apache o dentro de un host virtual concreto.

    ```apache
    Protocols h2 http/1.1
    ```
