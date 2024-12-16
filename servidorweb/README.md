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


### Instalación y configuración de Nginx

#### 1. **Instalar Nginx**

Instalación en Debian y Ubuntu:

```bash
sudo apt update
sudo apt install nginx
```

#### 2. **Iniciar y habilitar Nginx**

Después de la instalación, debes iniciar el servicio Nginx y asegurarte de que se inicie automáticamente en el arranque del sistema:

```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

#### 3. **Verificar que Nginx está corriendo**

Para asegurarte de que Nginx está funcionando correctamente, abre un navegador web y escribe la dirección IP de tu servidor. Si todo está bien, deberías ver la página predeterminada de Nginx que dice "Welcome to nginx!".

También puedes verificar el estado de Nginx con el siguiente comando:

```bash
sudo systemctl status nginx
```

#### 4. **Configuración básica de Nginx**

El archivo de configuración principal de Nginx se encuentra en `/etc/nginx/nginx.conf`, pero lo más común es trabajar con la configuración de los bloques de servidor (server blocks), que funcionan como los **virtual hosts** en Apache.

Los archivos de configuración de los bloques de servidor se encuentran dentro de la carpeta `/etc/nginx/sites-available/` y `/etc/nginx/sites-enabled/`.

##### Crear un nuevo sitio web

1. **Crear un archivo de configuración para tu sitio web** en el directorio `sites-available`:

```bash
sudo nano /etc/nginx/sites-available/mi_sitio
```

2. **Configurar el bloque de servidor** con algo básico como el siguiente ejemplo:

```nginx
server {
    listen 80;  # Escuchar en el puerto 80 (HTTP)
    server_name  mi_sitio.com www.mi_sitio.com;  # Nombre de dominio

    root /var/www/mi_sitio;  # Ruta del sitio web
    index index.html index.htm;  # Archivos predeterminados

    location / {
        try_files $uri $uri/ =404;  # Manejo de errores 404
    }

    access_log /var/log/nginx/mi_sitio_access.log;  # Log de acceso
    error_log /var/log/nginx/mi_sitio_error.log;    # Log de errores
}
```

3. **Crear un enlace simbólico** en `sites-enabled` para activar la configuración:

```bash
sudo ln -s /etc/nginx/sites-available/mi_sitio /etc/nginx/sites-enabled/
```

4. **Verificar la configuración de Nginx** para asegurarte de que no hay errores de sintaxis:

```bash
sudo nginx -t
```

Si todo está correcto, deberías ver un mensaje que diga que la configuración es exitosa.

#### 5. **Crear la carpeta del sitio web**

Asegúrate de que la carpeta `mi_sitio` exista y tenga los archivos que deseas servir, por ejemplo, un archivo `index.html`:

```bash
sudo mkdir -p /var/www/mi_sitio
echo "¡Hola, mundo!" | sudo tee /var/www/mi_sitio/index.html
```

#### 6. **Reiniciar Nginx para aplicar la configuración**

Finalmente, reinicia Nginx para aplicar los cambios:

```bash
sudo systemctl restart nginx
```

#### 7. **Verificar en el navegador**

Abre tu navegador y escribe la dirección de tu servidor (por ejemplo, `http://mi_sitio.com`) o la dirección IP del servidor. Deberías ver la página "¡Hola, mundo!" que acabas de crear.

#### 8. **Configuración básica de Nginx**

Configurar un **proxy inverso** con **Nginx** implica configurar Nginx para que actúe como un intermediario entre el cliente (usuario) y uno o varios servidores de backend. El cliente se conecta a Nginx, y Nginx redirige las solicitudes a los servidores de backend según sea necesario. Este tipo de configuración es comúnmente usado para distribuir la carga de trabajo, mejorar la seguridad y ocultar la infraestructura interna.

##### Pasos para configurar un proxy inverso con Nginx

1. **Configurar el archivo de configuración de Nginx**

   El archivo de configuración principal de Nginx suele encontrarse en `/etc/nginx/nginx.conf` o en archivos dentro de `/etc/nginx/sites-available/` (si usas una estructura de servidor).

   Edita el archivo de configuración para definir el proxy inverso:

   ```bash
   sudo nano /etc/nginx/sites-available/default
   ```

   O en `/etc/nginx/nginx.conf` dependiendo de tu distribución.

2. **Ejemplo de configuración de Proxy Inverso**

   Supongamos que tienes un servidor de backend corriendo en `http://backend_server:8080` y quieres que Nginx reciba las solicitudes en el puerto 80 (HTTP) y las redirija a este backend.

   La configuración sería algo así:

   ```nginx
   server {
       listen 80;

       server_name midominio.com;  # El dominio o IP de tu servidor

       location / {
           proxy_pass http://backend_server:8080;  # Dirección de tu servidor backend
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Forwarded-Proto $scheme;
       }
   }
   ```

   - **proxy_pass**: Dirección del servidor de backend al que Nginx redirigirá las solicitudes.
   - **proxy_set_header**: Estas directivas permiten que Nginx pase encabezados adicionales que ayudan al servidor backend a recibir información sobre el cliente original, como su dirección IP o el protocolo utilizado.

3. **Verificar la configuración de Nginx**

   Antes de reiniciar Nginx, es recomendable verificar que la configuración no tenga errores:

   ```bash
   sudo nginx -t
   ```

   Si todo está correcto, deberías ver un mensaje como:

   ```
   nginx: configuration file /etc/nginx/nginx.conf test is successful
   ```

4. **Reiniciar Nginx**

   Si no hay errores, reinicia Nginx para aplicar la nueva configuración:

   ```bash
   sudo systemctl restart nginx
   ```

7. **Comprobar el funcionamiento**

   Ahora, si accedes a `http://midominio.com`, Nginx debería actuar como un proxy inverso y redirigir las solicitudes al servidor backend en `http://backend_server:8080`.

##### Configuración adicional

- **Reparto o equilibrado de carga**: Si tienes múltiples servidores backend, puedes configurarlos en un bloque `upstream`:

   ```nginx
   upstream backend_servers {
       server backend1.example.com:8080;
       server backend2.example.com:8080;
   }

   server {
       listen 80;

       location / {
           proxy_pass http://backend_servers;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Forwarded-Proto $scheme;
       }
   }
   ```

##### Otras posibilidades:

- Se pueden anidar servicios web dentro de un servicio original.

```nginx
server {
    listen 80;  # Escuchar en el puerto 80 (HTTP)
    server_name  mi_sitio.com www.mi_sitio.com;  # Nombre de dominio

    root /var/www/mi_sitio;  # Ruta del sitio web
    index index.html index.htm;  # Archivos predeterminados

    location / {
        try_files $uri $uri/ =404;  # Manejo de errores 404
    }

    location /app1 {
        proxy_pass http://backend_server1:8080;  # Dirección de tu servidor backend
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /app2 {
        proxy_pass http://backend_server2:8080;  # Dirección de tu servidor backend
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    access_log /var/log/nginx/mi_sitio_access.log;  # Log de acceso
    error_log /var/log/nginx/mi_sitio_error.log;    # Log de errores
}
```