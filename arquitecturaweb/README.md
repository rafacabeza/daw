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

**La capa de aplicación**

Aquí están las necesidades de las aplicaciones que usamos en nuestros equipos. Estas aplicaciones pueden ser de usuario, como un navegador web o un cliente de correo electrónico, o no como un servidor web o de bases de datos.

En esta capa se definen los protocolos que usan dichas aplicaciones: HTTP, SSH, DNS, 

**La capa de transporte**

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

**La capa de red**

- Esta capa es la responsable de enviar los segmentos recibidos de la capa de transporte.
- Usa un sistema de direcciones llamado IP (Internet Protocol)
- Los segmentos son "metidos en un sobre" con la información que requiere este IP. Lo más importante es indicar la dirección IP destino y la de origen.
- Esta capa la encontramos en:
  - Los ordenadores (móviles, servidores)
  - En los equipos de interconexión llamados routers. Reciben este nombre porque se ocupan de *enrutar* los paquetes que deben viajar de una red a otra. Ellos deciden cuál es el camino que deben seguir hasta alcanzar el destino.
  - En realidad están asociados a un hardware presente en todos ellos: la tarjeta de red o NIC (Network Interface Card). 

**Capa de acceso a la red**

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

**Hardware**

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

**Resumen del direccionamiento IP**

- Las direcciones IP son 32 bits (ceros y unos). Representados como 4 decimales separados por puntos. Por ejemplo 192.168.5.3. Cada decimal representa 8b por lo que va desde 0 a 255.
- La primera parte de esos 32 bits representa una red, un conjunto de equipos conectados entre sí directamente. Todos los equipos de la red tienen esa primera parte de su dirección idéntica.
- La segunda parte identifica a cada miembro o *host* de la red.
- La dirección de host que usa sólo 0's es especial y se usa para referirse a la red en conjunto.
- La dirección de host que usa sólo 1's es especial también. Se usa para enviar algo a todos los miembros de la red. Es un comodín.
- Quien administra las direcciones es un organismo global de internet, el IANA. Este organismo dividió las direcciones en varias clases.


Clase |	Intervalo (*) |	Red y Host |	Máscara de red
------|-------------- |------------|-------------
A |	0.0.0.0 (**) – 127.255.255.254 |	8b + 24b |	255.0.0.0
B |	128.0.0.0 – 191.255.255.254 |	16b + 16b |	255.255.0.0
C |	192.0.0.0 – 223.255.255.254 |	24b + 8b |	255.255.255.0
D |	224.0.0.0 – 239.255.255.254 | | |		
E |	240.0.0.0 – 255.255.255.254 | | |

- Clase A. Pocas redes, muy grandes. Clase C, muchas redes pequeñas. Clase B, situación intermedia.

**Direcciones dinámicas y estáticas** 

- Dinámicas si se asignan al encender el equipo y cambian periódicamente. 
  - Caso de nuestro router doméstico que recibe una IP pública cambiante.
  - Los ordenadores de una red local (LAN) configurados por DHCP

- Estáticas
  - Si nuestro router pudiera *comprar* o *alquilar* una IP fija. Hoy inviable para usuarios domésticos.

**Direcciones privadas**


- Las direcciones públicas son únicas en el mundo. No puede haber dos redes iguales o dos host iguales en la misma red.
- Las direcciones públicas son escasas por eso a los equipos domésticos dentro de una LAN se les asignan unas direcciones llamadas privadas. 
  - Las direcciones privadas se repiten en multitud de ubicaciones.
  - Los routers usan un mecanismo llamado NAT (traducción de direcciones de red) para reemplazar la IP del host cuando sus paquetes salen al exterior.
  - Las direcciones privadas son las siguientes:

Clase |	Inicio |	Fin | Estructura	| nº de redes
------|--------------|------------|-------------|-------------
Clase A |	10.0.0.0 |	10.255.255.255 | 	8 bits red, 24 bits hosts | 1 red
Clase B |	172.16.0.0 |	172.31.255.255 | 	16 bits red, 16 bits hosts | 16 redes
  - Si un equipo en la red local tiene una dirección fija: router, impresora, servidor, .reservadas o especiales..

Clase C |	192.168.0.0 |	192.168.255.255 | 	24 bits red, 8 bits hosts | 256 redes

**Direcciones reservadas o especiales**

Inicio |	Fin | Explicación
------|--------------|------------
0.0.0.0 |	0.0.0.255 | Uso interno para los routers
127.0.0.0 |	127.255.255.255 | Loopback o bucle interno, el propio equipo
169.254.0.0 |	169.254.255.255 | Configuración DCHP fallida

**Representación de una dirección**

- Una IP son 32 bits y se representan así: 172.18.5.1 (host), o 172.18.0.0 (red)
- En muchas ocasiones interesa acompañarla de su máscara de red en tal caso, la máscara puede representarse en decimal: 255.255.0.0
- Es muy habitual representar la IP y su máscara en una sola línea. Tras la IP se pone una barra (/) y el número de bits de la máscara: 172.18.5.1/24, 172.18.0.0/24, 192.168.5.31/24, ....

**Subredes**

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