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

### Configuración de red

[https://asir.readthedocs.io/es/latest/TEMA_2_Dhcp/configuracion.html](https://asir.readthedocs.io/es/latest/TEMA_2_Dhcp/configuracion.html)