# Arquitectura web

## Conceptos básicos de redes TCP/IP


Antes de entrar en la arquitectura web es conveniente un repaso de algunos conceptos de redes TCP/IP. Es un contenido visto en el módulo de Sistemas Informáticos de primero pero es conveniente una revisión del mismo.

[https://www.educatica.es/redes](https://www.educatica.es/redes)

### Capas TCP/IP

Las arquitectura que permite las conexiones de red es muy compleja. Como en tantos ámbitos de la vida y de la ingeniería es mucho mejor dividir un problema grande en muchos pequeños.

Por otra parte, es conveniente que esta división siga un criterio secuencial, desde lo más físico a lo más abstracto que usa el usuario final. 

Por ese motivo las arquitectura de redes tiene una estructura de capas. Las redes que usamos diariamente siguen el estándar TCP/IP. En él existen las siguientes capas:

- Aplicación
- Transporte
- Red
- Acceso a la red

Vamos a ver brevemente qué nos encontramos en cada una de ellas.

#### La capa de aplicación

Aquí están las necesidades de las aplicaciones que usamos en nuestros equipos. Estas aplicaciones pueden ser de usuario, como un navegador web o un cliente de correo electrónico, o no como un servidor web o de bases de datos.

En esta capa se definen los protocolos que usan dichas aplicaciones: HTTP, SSH, DNS, 

#### La capa de transporte

Todos los protocolos de aplicación requieren enviar y recibir cosas. Cosas grandes como ficheros, o pequeñas como un nombre de dominio que debe ser traducido. 

- TCP. El protocolo TCP sirve para enviar esas cosa grandes. Se ocupa de:
  - En origen, trocear esos envíos grandes en bloques pequeños que pueda usar la siguiente capa. Para cada bloque usamos el término segmento.
  - Además debe enviarlos en orden y debidamente etiquetados.
  - En destino debe recibirlos, reordenarlos y recomponer el paquete original.
  - Finalmente debe entregarlos a la aplicación que corresponda.
- UDP. El protocolo UDP sirve para las cosas pequeñas. 
  - Como son cosas pequeñas y sencillas es muy sencillo.
  - Es necesario porque la estructura de capas no permite que la capa de aplicación hable con una capa de nivel inferior.
- Tanto TCP como UDP usan el concepto de puerto. 
  - Una conexión TCP o un envío UDP requieren una IP de origen y otra de destino, además un número de puerto de origen y otro de destino.
  - Hay números reservados.

Las dos capas citadas están en cualquiera de los host finales. Los ordenadores, servidores, móviles, ...

#### La capa de red

- Esta capa es la responsable de enviar los segmentos recibidos de la capa de transporte.
- Usa un sistema de direcciones llamado IP (Internet Protocol)
- Los segmentos son "metidos en un sobre" con la información que requiere este IP. Lo más importante es indicar la dirección IP destino y la de origen.
- Esta capa la encontramos en:
  - Los ordenadores (móviles, servidores)
  - En los equipos de interconexión llamados routers. Reciben este nombre porque se ocupan de *enrutar* los paquetes que deben viajar de una red a otra. Ellos deciden cuál es el camino que deben seguir hasta alcanzar el destino.
  - En realidad están asociados a un hardware presente en todos ellos: la tarjeta de red o NIC (Network Interface Card). 

#### Capa de acceso a la red

- En el estándar académico se divide en dos capas porque se ocupa de:
  - Emitir las señales eléctricas, lumínicas o electromagnéticas que requiere la tecnología en cuestión.
  - El acceso al medio, es decir como se organizan los turnos para que ese medio (aire, cable, ...) pueda usarse por todos de forma ordenada y sin colisiones.
  - Además debe identificar físicamente a todos los elementos que hay en el entorno físico. Para hacerlo se usa una dirección que da el fabricante al hardware. Se usa el término de dirección hardware o MAC (Medium Access Control).
  - Hardware
    - Las citadas tarjetas de red implementan la lógica de este nivel.
    - Hay distintas tecnologías de acceso a la red:
      - Ethernet. En realidad es el estándar 802.3 y todas sus variantes, según el tipo de cableado y velocidad soportada.
      - Wifi. Nombre coloquial que se refiere al estándar 802.11 y todas sus variantes.
    - Hay distinto hardware que lo soporta:
      - A nivel de host y router lo soportan las tarjetas de red (ethernet, wifi).
      - Switch o conmutador ethernet que permite interconectar equipos usando este sistema.
      - Punto de acceso wifi. Permite interconectar equipos usando tecnología wifi. Además los puntos de acceso tienen función de puente que permite interconectar la red ethernet con la citada wifi.

#### Hardware

- Tarjeta de red. Capas de acceso y de red.
- Hub. Capa de acceso.
- Switch. Capa de acceso.
- Punto de acceso. Capa de acceso.
- Router. Capa de red. Tiene 2 o más tarjas de red. Al menos, una al exterior y una al interior. Por tanto, al menos dos direccioens IP.
- Dispositivos híbridos. Es habitual que los routers se fabrique como un combo que dos o más tipos de hardware: une hardware 
  - Un router propiamente dicho, con 2 o más tarjetas de de red
  - Un switch con varios puertos para conectar equipos dentro de la red interna.
  - Además los equipos domésticos suelen incorporar un punto de acceso que permite conectar también equipos de forma inalámbrica.

### Direccionamiento IP

- En los apuntes enlazados arriba tenemos:  
  - [Direccionamiento IP](https://www.educatica.es/redes/6-direccionamiento-ip/)
  - [Funcionamiento](https://www.educatica.es/redes/7-funcionamiento-de-la-comunicacion-en-redes-ip/). Vídeo muy ilustrativo.
  - [Subredes](https://www.educatica.es/redes/8-direccionamiento-ip-subredes/)

#### Resumen del direccionamiento IP

- Las direcciones IP son 32 bits (ceros y unos). Representados como 4 decimales separados por puntos. Por ejemplo 192.168.5.3. Cada decimal representa 8b por lo que va desde 0 a 255.
- La primera parte de esos 32 bits representa una red, un conjunto de equipos conectados entre sí directamente. Todos los equipos de la red tienen esa primera parte de su dirección idéntica.
- La segunda parte identifica a cada miembro o *host* de la red.
- La dirección de host que usa sólo 0's es especial y se usa para referirse a la red en conjunto.
- La dirección de host que usa sólo 1's es especial también. Se usa para enviar algo a todos los miembros de la red. Es un comodín.
- Quien administra las direcciones es un organismo global de internet, el IANA. Este organismo dividió las direcciones en varias clases.


| Clase | Intervalo (*)                  | Red y Host | Máscara de red |
| ----- | ------------------------------ | ---------- | -------------- |
| A     | 0.0.0.0 (**) – 127.255.255.254 | 8b + 24b   | 255.0.0.0      |
| B     | 128.0.0.0 – 191.255.255.254    | 16b + 16b  | 255.255.0.0    |
| C     | 192.0.0.0 – 223.255.255.254    | 24b + 8b   | 255.255.255.0  |
| D     | 224.0.0.0 – 239.255.255.254    |            |                |
| E     | 240.0.0.0 – 255.255.255.254    |            |                |

- Clase A. Pocas redes, muy grandes. Clase C, muchas redes pequeñas. Clase B, situación intermedia.

#### Direcciones dinámicas y estáticas

- Dinámicas si se asignan al encender el equipo y cambian periódicamente. 
  - Caso de nuestro router doméstico que recibe una IP pública cambiante.
  - Los ordenadores de una red local (LAN) configurados por DHCP

- Estáticas
  - Si nuestro router pudiera *comprar* o *alquilar* una IP fija. Hoy inviable para usuarios domésticos.

#### Direcciones privadas


- Las direcciones públicas son únicas en el mundo. No puede haber dos redes iguales o dos host iguales en la misma red.
- Las direcciones públicas son escasas por eso a los equipos domésticos dentro de una LAN se les asignan unas direcciones llamadas privadas. 
  - Las direcciones privadas se repiten en multitud de ubicaciones.
  - Los routers usan un mecanismo llamado NAT (traducción de direcciones de red) para reemplazar la IP del host cuando sus paquetes salen al exterior.
  - Las direcciones privadas son las siguientes:

| Clase   | Inicio     | Fin            | Estructura                 | nº de redes |
| ------- | ---------- | -------------- | -------------------------- | ----------- |
| Clase A | 10.0.0.0   | 10.255.255.255 | 8 bits red, 24 bits hosts  | 1 red       |
| Clase B | 172.16.0.0 | 172.31.255.255 | 16 bits red, 16 bits hosts | 16 redes    |
  - Si un equipo en la red local tiene una dirección fija: router, impresora, servidor, .reservadas o especiales..

Clase C |	192.168.0.0 |	192.168.255.255 | 	24 bits red, 8 bits hosts | 256 redes

#### Direcciones reservadas o especiales

| Inicio      | Fin             | Explicación                                |
| ----------- | --------------- | ------------------------------------------ |
| 0.0.0.0     | 0.0.0.255       | Uso interno para los routers               |
| 127.0.0.0   | 127.255.255.255 | Loopback o bucle interno, el propio equipo |
| 169.254.0.0 | 169.254.255.255 | Configuración DCHP fallida                 |

#### Representación de una dirección

- Una IP son 32 bits y se representan así: 172.18.5.1 (host), o 172.18.0.0 (red)
- En muchas ocasiones interesa acompañarla de su máscara de red en tal caso, la máscara puede representarse en decimal: 255.255.0.0
- Es muy habitual representar la IP y su máscara en una sola línea. Tras la IP se pone una barra (/) y el número de bits de la máscara: 172.18.5.1/24, 172.18.0.0/24, 192.168.5.31/24, ....

#### Subredes

- Para organizar de forma más flexible las direcciones disponibles se define un mecanismo de máscara variable. De esta manera se pueden usar máscaras de longitu distinta a 8, 16 o 24 bits. 
- Según cómo usemos esto hablamos de crear subredes o superredes al dividir o agrupar las redes existentes previamente.
- No vamos a explicar este mecanismo en detalle por no extendernos. Está en el enlace de arriba.

### Configuración de red

- Configurar una tarjeta de red implica:
  - Asignar una IP y una máscara. Se puede escribir en cualquiera de las dos notaciones explicadas
  - Ejemplo 1: 192.168.0.1/255.255.255.0
  - Ejemplo 2: 192.168.0.1/24
  - Una tarjeta puede tener varias IP (y sus correspondientes máscaras).
- Puerta de enlace
  - Opcionalmente se puede añadir una puerta de enlace. Es una IP de la misma red que la tarjeta configurada y que nos conecta con el exterior.
  - Si sólo hay una tarjeta es obligatorio configurarla para poder salir al exterior (Internet).
- DNS
  - La configuración DNS se refiere a todo el Sistema Operativo pero Windows lo asocia a una tarjeta.
  - Es una o varias direcciones IP de equipos que resuelven nombres de acuerdo al sistema DNS. Es decir que traducen un nombre por su IP.
- La configuración completa de un equipo y su tarjeta de red implica: IP con máscara, puerta de enlace, direccion(es) DNS.
- Todos esos parámetros pueden ser configurados manualmente o mediante DHCP. 
- Todos esos parámetros pueden ser configurados mediante CUI o GUI, es decir por consola o por entorno gráfico.

[https://asir.readthedocs.io/es/latest/TEMA_2_Dhcp/configuracion.html](https://asir.readthedocs.io/es/latest/TEMA_2_Dhcp/configuracion.html)

### Ejercicios sobre IP

1. Tienes que montar una red de pruebas donde alojar 20 clientes y un servidor.
   1. Dime cuál será tu dirección de red. Considera que tienes 
   2. afdsaf


## La Arquitectura Web.

Si buscas información sobre arquitectura web vas a encontrar informaciones  muy distintas que hacen referencia al mismo término.

- Cómo se organizan los contenidos en la web. Esto tiene que ver con el deseño de la aplicación, con su posicionamiento o SEO y su estructura lógica. Dejamos esto para otros módulos: servidor o interfaces principalmente.
- Cómo se organizan los equipos hardware y software para brindar el servicio web. Es ahí donde nos interesa profundizar.


<!-- https://aitor-medrano.github.io/dwes2122/01arquitecturas.html#arquitectura-de-3-capas

https://apuntes-daw.javiergutierrez.trade/despliegue-de-aplicaciones/ut1/recopila.html

https://raul-profesor.github.io/DEAW/debian_teoria/

https://kinsta.com/es/blog/arquitectura-aplicaciones-web/#por-qu-es-importante-la-arquitectura-de-las-aplicaciones-web


HTTP Y HTTP2
https://platzi.com/clases/1638-api-rest/21614-que-es-y-como-funciona-el-protocolo-http/

 -->



## Modelos de ejecución de código en servidores y clientes web


El desarrollo de aplicaciones web se apoya en la  arquitectura cliente-servidor. En esta arquitectura, existen dos actores, cliente y servidor.

![Cliente Servidor](/assets/arquitectura/Modelo_cliente-servidor.png)

![Cliente Servidor](/assets/arquitectura/cliente_servidor.png)


- El cliente se conecta al servidor para solicitar algun servicio. **Petición *.
- El servidor se encuentra en ejecución de forma ininterrumpida a la espera de que los diferentes clientes realicen una solicitud. **Respuesta *.
- Se suele tratar de obtener el contenido de una página web. También podemos hablar de servicios web donde no se generan páginas web sino contenido en XML o JSON para ser consumido por una aplicación cliente.


- La solicitud que hacen los clientes al servidor se le llama petición (__request__) 
- Lo que el servidor devuelve a dicho cliente le llamamos respuesta (__response__).
- Estos términos son los usados por el protocolo HTTP y los encontrarés en cualquier lenguaje DWS.


- También hay que tener en cuenta que esta arquitectura cliente-servidor plantea la posibilidad de numerosos clientes atendidos por un mismo servidor. El servidor será un software multitarea capaz de atender peticiones simultáneas de numerosos clientes. 
- Cuando una aplicación o servicio web tiene muchas solicitudes por unidad de tiempo puede ser que un conjunto de servidores o _cluster_ desempeñen este servicio en equipo. 



## Páginas estáticas y dinámicas

- Antes de empezar a hablar de distintas tecnologías para la programación en el entorno servidor, debemos comentar algunas cuestiones:

1. Páginas web
2. Dinamismo del lado cliente y del lado servidor


### Páginas estáticas.

- Decimos que una página es estática cuando está construida enteramente con código HTML y CSS, código escrito directamente en ficheros y que con cambia.

- Para visualizar una página estática sólo es preciso un navegador web. No hace falta ningún otro software.


### Páginas dinámicas.

- Decimos que una página es dinámica cuando el contenido y aspecto es cambiante.
- Estos cambios pueden ser fruto de que el servidor modifica el HTML entre peticionees. En este caso hablamos de páginas dinámicas del **lado del servidor**.
- También pueden ocurrir si ejecutamos código en el navegador, javascript. En este caso podemos hablar de páginas dinámicas del **lado del cliente**.


- La tecnología **AJAX**(_Asynchronous JavaScript And XML _) realiza una combinación de ambos dinamisms.
- Permite actualizar el contenido de una página sin recargarla completamente.
- Javascript solicita datos al servidor 
- Los datos recibidos son usados para renovar el contenido de la página web.


## Desarrollo en capas

- Podemos separar funcionalidades.
- Seguimos trabajando con filosofía cliente-servidor.
- Separamos el servidor en dos máquinas.


![](/assets/arquitectura/software3capas.png)


- Capa de presentación: Es la capa donde la aplicación se muestra al usuario. Básicamente es la GUI (Graphical User Interface, Interfaz Gráfica de Usuario). En el caso de una aplicación web sería el código HTML que se carga directamente en el navegador web. En cualquier caso, se ejecuta directamente en el equipo del cliente.

- Capa de negocio: Es la capa intermedia donde se lleva a cabo toda la lógica de la aplicación. Siempre se ejecutará en el lado servidor. Esta capa, tras realizar todos los cálculos y/o operaciones sobre los datos, genera el código HTML que será presentado al usuario en la capa siguiente.

- Capa de datos: Es la capa que almacena los datos. Básicamente, en condiciones normales, hace referencia al propio SGBD que es el encargado de almacenar los datos. Dependiendo de la arquitectura de la aplicación, esta capa y la de negocio se pueden encontrar fisicamente en el mismo equipo, aunque también es posible que se tengan que separar por cuestiones de rendimiento. La capa de datos sirve todas la información necesaria a la capa de negocio para llevar a cabo sus operaciones.


Esta estructura podría complicarse un poco más separando el servidor propiamente dicho del servidor de aplicaciones, es decir, de la máquina que ejecuta el código del lado del servidor:

- Puede estar en una misma máquina:
![](/assets/arquitectura/Modelo_servidor_aplicaciones_1.png)

- Puede estar en máquinas separadas:
![](/assets/arquitectura/Modelo_servidor_aplicaciones_externo.png)

- O incluso puede haber varios servidores de aplicaciones.
![](/assets/arquitectura/Modelo_servidor_aplicaciones_varios.png)

## Equilibrado de cargas

Hay dos conceptos relacionados con la posibilidad de que nuestra aplicación crezca. La capacidad de nuestra arquitectura se adapte al crecimiento de nuestra aplicación se denomina escalabilidad. Este crecimiento hace referencia al aumento de usuarios y de peticiones simultáneas así como la posibilidad de dar servicio de forma global a usuarios más allá de nuestra región geográfica o país.

El segundo concepto es el equilibrado de cargas. En vez de escribir largo y tendido sobre este concepto vamos a ver algunos dibujos esquemáticos de cómo puede aparecer un equilibrador de carga en nuestra arquitectura.

Un equilibrador de caraga puede estar situado de distintas maneras:

- Repartiendo las peticiones http entre varios servidores.

![](/assets/arquitectura/load-balancing.png)

- Repartiendo las peticiones http entre regiones para después aplicar un nuevo equilibrado.

![](/assets/arquitectura/load-balancing2.png)

- O incluso de formas más complejas

![](/assets/arquitectura/load-balancer.png)


> **NOTA**. _Balance_ en inglés es uno de esos _false friends_ que se traducen habitualmente de forma tan intuitiva como equívoca. Balancear algo es moverlo arriba y abajo como los platillos de una balanca o un balancín infantil.
> La traducción correcta es equilibrio o equilibrar. Equilibrar la carga es repartirla para que se reparta de forma equitativa y equilibrada. 
> Balancear la carga de un camión implica accidente seguro y es lo peor que le puede pasar a un caminoero. Equilibrar la carga hace que el camión circule seguro y sin sobrecargar ruedas o suspensiones.

## HTTP

Se recomienda leer las páginas 12-19 del [Tutorial Básico de Java EE](http://www.javahispano.org/storage/contenidos/JavaEE.pdf) publicado por JavaHispano

Veamos las cuestiones más notables

- HTTP es el protocolo usado para la transferencia de recursos en la web.
- El cliente o navegador se denomina "User Agent"
- Se basa en transacciones según el esquema petición-respuesta.
- Los  recursos se identifican por un localizador único: URL


- Es un protocolo sin **estado**, es decir no guarda información entre conexiones. Esto lo hace flexible y escalable pero es un problema para crear aplicaciones web.
- Http requiere de un extra para _recordarnos_ cuando abrimos sesión en una aplicaión. Lo veremos.

## HTTPS 

### ¿Cuál es la diferencia entre HTTP y HTTPS?

El protocolo de transferencia de hipertexto (HTTP) es un protocolo o conjunto de reglas de comunicación para la comunicación cliente-servidor. Cuando visita un sitio web, su navegador envía una solicitud HTTP al servidor web, que responde con una respuesta HTTP. El servidor web y su navegador intercambian datos como texto sin formato. En resumen, el protocolo HTTP es la tecnología subyacente que impulsa la comunicación de red. Como su nombre indica, el protocolo seguro de transferencia de hipertexto (HTTPS) es una versión más segura o una extensión de HTTP. En HTTPS, el navegador y el servidor establecen una **conexión segura y cifrada antes de transferir datos**.

### ¿Cómo funciona el protocolo HTTPS?

HTTP transmite datos no cifrados, lo que significa que la información enviada desde un navegador puede ser interceptada y leída por terceros. Este no era el proceso ideal, por lo que se extendió a HTTPS para agregar otro nivel de seguridad a la comunicación. HTTPS combina las solicitudes y respuestas HTTP con la tecnología SSL y TLS.

Los sitios web HTTPS deben obtener un certificado SSL/TLS de una autoridad de certificación (CA) independiente. Estos sitios web comparten el certificado con el navegador antes de intercambiar datos para generar confianza. El certificado SSL también contiene información criptográfica, por lo que el servidor y los navegadores web pueden intercambiar datos cifrados o codificados. El proceso funciona de la siguiente manera:

1. Para visitar un sitio web HTTPS, debe escribir el formato de URL `https://`en la barra de direcciones del navegador.
2. El navegador intenta verificar la autenticidad del sitio mediante la solicitud del certificado SSL del servidor.
3. El servidor envía el certificado SSL que contiene una clave pública como respuesta.
4. El certificado SSL del sitio web demuestra la identidad del servidor. Una vez que el navegador está satisfecho, utiliza la clave pública para cifrar y enviar un mensaje que contiene una clave de sesión secreta.
5. El servidor web utiliza su clave privada para descifrar el mensaje y recuperar la clave de sesión. A continuación, cifra la clave de sesión y envía un mensaje de confirmación al navegador.
6. Ahora, tanto el navegador como el servidor web cambian a usar la misma clave de sesión para intercambiar mensajes de forma segura.

Los certificados SSL son emitidos por entidades que se dedican a eso y que son confiables. Si nosotros creamos nuestro propio certificado podemos tener alugnos problemas como veremos más adelante.

### Las URL

- El esquema de una URL es:
  `protocolo://maquina:puerto/camino/fichero`

- Protocolo es **http** o **https**
- Máquina: una IP o un nombre (DNS).
- El puerto suele omitirse por usarse los de defecto: 80 y 443 para http y https respectivamente.
- Camino o ruta relativa al directorio raíz del sitio
- Fichero es el nombre del recurso.

### Peticiones HTTP

Las peticiones HTTP siguen la siguiente estructura:

```
Método SP URL SP Versión Http retorno_de_carro
(nombre-cabecera: valor-cabecera (, valor-cabecera)*CRLF)*
Cuerpo del mensaje

nota: 
CRLF es retorno de carro
SP es espacio
El cuerpo suele ir vacío pero no cuando enviamos formularios, subimos ficheros, ...
```

Veamos un ejemplo

```
GET /index.html HTTP/1.1 
Host: www.sitioweb.com:8080 
User-Agent: Mozilla/5.0 (Windows;en-GB; rv:1.8.0.11) Gecko/20070312 
[Línea en blanco]
```

- Las cabeceras aportan gran información. En el ejemplo vemos el  host con el puerto y la identificación del navegador cliente.

- Otro ejemplo con el método POST.

```
POST /en/html/dummy HTTP/1.1 
Host: www.explainth.at 
User-Agent: Mozilla/5.0 (Windows;en-GB; rv:1.8.0.11) Gecko/20070312 Firefox/1.5.0.11 
Accept: text/xml,text/html;q=0.9,text/plain;q=0.8, image/png,*/*;q=0.5 
Accept-Language: en-gb,en;q=0.5 
Accept-Encoding: gzip,deflate 
Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7 
Keep-Alive: 300 
Connection: keep-alive 
Referer: http://www.explainth.at/en/misc/httpreq.shtml 
Content-Type: application/x-www-form-urlencoded 
Content-Length: 39 

name=MyName&married=not+single&male=yes 
```

- La lista completa de cabeceras que se pueden usar la podemos consultar en [wikipedia](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields). Se pueden enviar informaciones como:

  - El nombre del navegador
  - El tipo de contenido solicitado y el aceptado (p. ej. página html, o un pdf, ...).
  - El juego de caracteres.
  - El idioma preferido.
  - Si se admite contenido comprimido ...

- El cuerpo del mensaje en las peticiones GET está vacío.

- La lista de métodos es bastante amplia pero de momento sólo nos preocupan los métodos GET y POST.

  - GET pide un recurso
  - POST envía datos al servidor para ser procesados. Los datos se incluyen en el cuerpo del nensaje.

### Respuestas HTTP

La respuesta se ajusta al siguiente esquema:
```
Versión-http SP código-estado SP frase-explicación retorno_de_carro
(nombre-cabecera: valor-cabecera ("," valor-cabecera)* CRLF)*
Cuerpo del mensaje
```

Un ejemplo sería

```
HTTP/1.1 200 OK
Content-Type: text/xml; charset=utf-8
Content-Length: 673
<html>
<head> <title> Título de nuestra web </title> </head>
<body>
¡Hola mundo!
</body>
</html>
```

### Códigos de estado

Un elemento importante de la respuesta es el código de estado.

Podemos consultar una lista completa de los posibles estados en [wikipedia](https://es.wikipedia.org/wiki/Anexo:C%C3%B3digos_de_estado_HTTP)
pero aquí tenemos un amplio resumen

- Códigos 1xx : Mensajes
  - 100-111 Conexión rechazada
- Códigos 2xx: Operación realizada con éxito
  - **200 OK**
  - 201-203 Información no oficial
  - 204 Sin Contenido
  - 205 Contenido para recargar
  - 206 Contenido parcial

- Códigos 3xx: Redireción
  - 301 Mudado permanentemente
  - 302 Encontrado
  - 303 Vea otros
  - 304 No modificado
  - 305 Utilice un proxy
  - 307 Redirección temporal

- Códigos 4xx: Error por parte del cliente
  - 400 Solicitud incorrecta
  - 402 Pago requerido
  - **403 Prohibido**
  - **404 No encontrado**
  - 409 Conflicto
  - 410 Ya no disponible
  - 412 Falló precondición

- Códigos 5xx: Error del servidor
  - 500 Error interno
  - 501 No implementado
  - 502 Pasarela incorrecta
  - 503 Servicio nodisponible
  - 504 Tiempo de espera de la pasarela agotado
  - 505 Versión de HTTP no soportada
