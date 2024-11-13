# Servidores de servicios

## Configuración de red

Configurar la red de un equipo supone configurar su tarjeta o tarjetas de red. Estas tarjetas normalmente son cableadas (ethernet) o inalámbricas (wifi). La configuración implica definir algunos parámetros:

- Asignar una o más direcciónes IP y sus máscaras de red. Por regla general, direcciones privadas como ya vimos. Lo habitual es que sea una única dirección.
- Además hay que definir una puerta de enlace o _gateway_. Esta puerta de enlace estará asociada a una de las tarjetas de red.
- Por último hay que definir una o más direcciones de servidores DNS. Estos serán máquinas que traducen nombres de dominio en IP. Ten en cuenta que:

### Configuración en linux. Netplan.

Netplan es el sistema usado desde hace algunos años por los sistemas Ubuntu y otras distribuciones linux de la misma familia.

La configuración se realiza mediante un fichero [YAML](https://es.wikipedia.org/wiki/YAML). ubicado en `/etc/netplan`. Suele llamarse:

  - `/etc/netplan/00-installer-config.yaml` en los server.
  - `01-network-manager-all.yaml` en los desktop.


Puedes encontrar unos cuantos ejemplos de uso en [GitHub](https://github.com/canonical/netplan/tree/main/examples). 

La gestión de la red está definida por la etiqueta `renderer`:

- NetworkManager. Aplicación gráfica en los entornos de escritorio. El fichero de configuración no guarda realmente los datos de configuración.
- Systemd-network (`networkd`). Gestor usado en los entornos servidor. Aquí sí que todos los datos deben ser guardados en el fichero YAML.


- Ejemplo de configuración `dhcp`. Observa en este ejemplo los comentarios sobre el sangrado:

  ```
  network: //0 espacios
    version: 2 //2 espacios
    renderer: networkd
    ethernets:
      enp3s0: //4 espacios
        dhcp4: true //6 espacios
  ```

- Ejemplo de configuración estática:

  ```
  network:
    version: 2
    renderer: networkd
    ethernets:
      enp3s0:
        addresses: [10.10.10.2/24]
        nameservers:
          search: [mydomain, otherdomain]
          addresses: [10.10.10.1, 1.1.1.1]
        gateway4: 192.168.1.1

  ```

- Eqivalente:

  ```
  network:
    version: 2
    renderer: networkd
    ethernets:
      enp3s0:
        addresses:
          - 10.10.10.2/24
        nameservers:
          search: [mydomain, otherdomain]
          addresses: 
            - 10.10.10.1
            - 1.1.1.1
        gateway4: 192.168.1.1        
  ```

- Ejemplo de configuración en entorno gráfico:

  ```
  network:
    version: 2
    renderer: NetworkManager
  ```


### Configuración en Windows. Entorno gráfico.



## DHCP

- El servicio DCHP puede implementarse fácilmente en un servidor Ubuntu
- No es una práctica habitual porque hay hardware (routers) que habitalmente se ocupa de esto. 
- No obstante, los conceptos aplicados son los mismos por lo que vamos a hacer la configuración en nuestro Ubuntu Server
- Para la configuración de este servicio puedes revisar estas notas:

### Ejercicio: Instalación y configuración del servidor dhcp en linux

Después de leer la documentación, instala el servidor dhcp. Recuerda que al inicializar el servicio nos dará un error, esto es debido a que no hemos configurado el servidor.

#### Instalación del servidor isc-dhcp-server


Para instalar nuestro servidor dhcp ejecutamos:

```bash
apt-get install isc-dhcp-server
```

>	Cuando instalamos el servidor por primera se produce un error, ya que no está configurado. Puedes ver los errores producidos por el servidor en el fichero `/var/log/syslog`

#### Configuración del servidor isc-dhcp-server


Lo primero que tenemos que hacer es configurar el interfaz de red por el que va a trabajar el servidor dhcp, para ello editamos el siguiente fichero `/etc/default/isc-dhcp-server`.

Donde configuramos el parámetro interfaces, por ejemplo:
	
```bash
INTERFACES="enp3s0"
```
 
El fichero principal de configuración de DHCP es `/etc/dhcp/dhcpd.conf`.

El fichero de configuración está dividido en dos partes:

* Parte principal (valores por defecto): especifica los parámetros generales que definen la concesión y los parámetros adicionales que se proporcionarán al cliente.
* Secciones (concretan a la principal)
     * Subnet: Especifican rangos de direcciones IPs que serán cedidas a los clientes que lo soliciten.
     * Host: Especificaciones concretas de equipos.

En la parte principal podemos configurar los siguientes parámetros, que más tarde podremos reescribir en las distintas secciones:

* `default-lease-time`: Tiempo de la concesión si el cliente no pide otro.
* `max-lease-time`: Tiempo de la concesión máximo, si el cliente pide un tiempo mayor.
* `option routers`: Indicamos la dirección red de la puerta de enlace que se utiliza para salir a internet.
* `option domain-name-server`: Se pone las direcciones IP de los servidores DNS que va a utilizar el cliente.
* `option domain­-name`: Nombre del dominio que se manda al cliente.
* `option subnet­mask`: Subred enviada a los clientes.
* `option broadcast-­address`: Dirección de difusión de la red.

Al indicar una sección subnet tenemos que indicar la dirección de la red y la mascara de red y entre llaves podemos poner los siguientes parámetros:

* `range`: Indicamos el rango de direcciones IP que vamos a asignar.
* Algunos de los parámetros que hemos explicado en la sección principal.

Ejemplo de configuración de la sección subnet puede ser:

```bash
subnet 192.168.0.0 netmask 255.255.255.0 {
  range 192.168.0.60 192.168.0.90;
  option routers 192.168.0.254;
  option domain-name-server 80.58.0.33, 80.58.32.9;
}
```
	
#### Mantenimiento del servicio

Una vez hechos los cambios en el servicio, debemos reiniciar el servidor para que dichos cambios surtan efecto:

```bash
service isc-dhcp-server restart
```

> [!IMPORTANT]
> 
> - Además de reiniciar el servicio podemos pararlo, iniciarlo o ver el estado:
>   ```
>   service isc-dhcp-server stop
>   service isc-dhcp-server start
>   service isc-dhcp-server status
>   ```
>  - El puerto usado es el UDP número 67. Además, los clientes tienen otro servidor atendiendo al puerto UDP número 68. Podemos verificar que está funcionando con
> 
>   ```
>   netstat -lun 
>   # -l para listado, -u para UDP, -n para numérico. Para TCP usaríamos -t
>   ```
>   - Si no funciona podemos detectar el posible error de configuración en el fichero revisando el `service isc-dhcp-server status` o en el contenido del fichero `/var/log/syslog`
>     ```bash
>     less /var/log/syslog #Para ver el log del sistema de forma interactiva
>     tail /var/log/syslog #Para ver las últimas líneas del log del sistema
>     ```

Sólo falta configurar los clientes para que tomen la configuración de red de forma dinámica.

> [!NOTE]  
>	En Windows la instrucción ``ipconfig /release`` libera la concesión, la instrucción ``ipconfig /renew`` la renueva. 
>
> En linux el comando para liberar la concesión es ``dhclient -r`` y el que nos permite renovarla será ``dhclient``.

Una vez realizada la concesión podemos verificar el estado de nuestra red:

> [!NOTE]  
> Recuerda que:
> 
> En windows puedes conocer toda la información de la red con `ipconfig` o `ipconfig/all`
> 
> En linux hace falta algo más complejo:
> 
> - `ip a`, `ip address` para ver las direcciones de red
> - `ip r`,  `ip route` para ver la puerta de enlace (y más información de enrutamiento)
> - `cat /etc/resolv.conf` para ver el servidor DNS

En el servidor podemos comprobar la lista de direcciones prestadas usando uno de estos comandos:

```bash
dhcp-lease-list

cat /var/lib/dhcp/dhcpd.leases
```

#### Creando reservas


Veamos la sección host, en ella configuramos un host para reservar una dirección IP para él.

En una sección host debemos poner el nombre que identifica al host y los siguientes parámetros:

* ``hardware ethernet``: Es la dirección MAC de la tarjeta de red del host.
* ``fixed-address``: La dirección IP que le vamos a asignar. 
* Podemos usar también las opciones ya explicadas en la sección principal.

Ejemplo

```bash
host fantasia {
  hardware ethernet 08:00:07:26:c0:a5;
  fixed-address fantasia.example.com;
}
```



## SSH

- El servcio SSH permite laconexión por consola con una máquina remota.

- [asir.gonzaleztroyano.es/projects/syad-1/servicio/servidor-ssh.html](https://asir.gonzaleztroyano.es/projects/syad-1/servicio/servidor-ssh.html)

### Instalar SSH

- Para instalar el servidor SSH, si no estuviera instalado, debemos ejecutar el siguiente comando:

```
apt update

apt install openssh-server
```

- Si lo acabamos de instalar debemos iniciarlo y permitir su inicio en el arranque del equipo:

```bash
// activar al inicio del sistema
systemctl enable ssh
// iniciarlo manualmente
systemctl start ssh
```

### Realizar una conexión SSH 

- Conexión a máquina remota

```bash
ssh direccionRemota
# direccionRemota es un nombre de dominio o una IP.
```

- Conexión a máquina remota usuario específico.

```bash
ssh usuario@direccionRemota
```

- Conexión a máquina remota puerto específico.

```bash
ssh usuario@direccionRemota -p NuevoPuerto
```

- Conexión sin contraseña.
  - Generar par de claves pública/privada: `ssh-keygen`
  - Copiar la clave en la máquina remota: `ssh-copy-id usuario_remoto@direccionRemota`

### Copiar ficheros a través de ssh: scp y rsync

- Copiar ficheros a través de ssh: `scp`. Es un comando similar al compando `cp`.
- Puedes usar `rsync` en vez de `scp`. Resulta muy potente para sincronizar carpetas completas de modo que los ficheros que no cambian no se copian. 
  - Puedes revisar su uso básico [aquí](https://www.hostinger.es/tutoriales/rsync-linux)
  - Veamos alugnos ejemplos:
  
  ```bash
  #Toma el contenido dentro de "original/" y lo replica en "duplicate/" ambas carpetas deben existir
  rsync -avz original/ duplicate/
  #Toma la carpeta "original" y su contenido y lo replica en "duplicate" esa carpeta se crea si es necesario.
  rsync -av original duplicate

  # -a: (--archive) Se conservan permisos, fechas y es recursivo.
  # -v: (--verbose) Muestra información del proceso
  # -z: (--compress) Comprime para hacer la transferencia más eficiente

  rsync -az ~/Desktop/Original edward@192.168.22.90:~/tmp/
  rsync -az ~/Despliegue/daw rafa@192.168.22.90:/var/www/
  ```


### Montar carpetas remotas en VSC

Podemos abrir conexiones ssh en nuestro editor VSC. Esto significa abrir terminales remotos pero también puede usarse para abrir carpetas en el editor para editar ficheros remotos. Puedes hacerlo con distintas extensiones. Te proponemos hacerlo con estas extensiones de Microsoft:

- Remote - SSH
- Remote - SSH: Editing Configuration Files
- Remote Explorer


 

## DNS. El Sistema de Nombres de Dominio

###  Concepto

<!-- Enlace a apuntes completos: https://www.fpgenred.es/DNS/_cmo_funciona_.html -->

El Sistema de Nombres de Dominio de Internet (Internet Domain Name System) es una implementación del concepto de servidor de nombres. Actúa como una "agenda telefónica" que traduce los nombres de dominio legibles por humanos (como `www.ejemplo.com`) en direcciones IP numéricas que las computadoras utilizan para identificarse y comunicarse entre sí. Dicha implementación cubre tres requisitos:

- Necesidad de una jerarquía de nombres.
- Necesidad de un reparto de carga entre los   servidores de nombres.
- Necesidad de delegar la administración de los servidores de nombres.

El DNS se implementa a través de una estructura de árbol. Es una estructura jerárquica:

![Jerarquía DNS](/assets/dns/jerarquia.png)

### Función básica de DNS

Cuando quieres acceder a un sitio web, por ejemplo, escribes en el navegador `www.ejemplo.com`. Sin embargo, las computadoras no entienden los nombres de dominio, solo las direcciones IP (números únicos que identifican a cada servidor en la red). Aquí es donde entra el DNS: convierte el nombre `www.ejemplo.com` en una dirección IP (por ejemplo, `192.0.2.1`).

### Cómo funciona el proceso DNS

1. **Resolución de nombres**: El proceso de traducción de un nombre de dominio a una dirección IP se llama "resolución de nombres". Esto involucra una serie de pasos:

   - **Paso 1: Consulta del navegador**: Cuando escribes un nombre de dominio en el navegador, este primero revisa si la dirección IP ya está guardada en su caché local (porque ya se ha visitado ese sitio antes).
   - **Paso 2: Consulta al resolver DNS local**: Si no está en la caché del navegador, el sistema operativo consulta el servidor DNS configurado en tu red (generalmente, el de tu proveedor de servicios de Internet, o ISP). Este servidor es conocido como *resolutor*.
   - **Paso 3: Recursión**: Si el servidor DNS local no tiene la respuesta en su caché, comienza a realizar consultas recursivas a otros servidores DNS, empezando por los servidores raíz. Es decir, en la práctica el servidor DNS local nos da la solución, porque la tiene en caché o porque la busca recursivamente.


### Jerarquía DNS

- En el nivel superior se encuentra el nodo raíz ("."). No lo escribimos pero está ahí: **google.com.**
- Le siguen los nodos de dominios de primer nivel (TLD, Top Level Domain). De tipo general (gTLD) como ".com" y de tipo regional (ccTLD) como el ".es". Los ccTLD son siempre de dos caracteres.
- A continuación vienen los nodos de dominios de segundo nivel (SLD, Second Level Domain). Son dominios definidos dentro de un TLD. Esos son los dominios que normalmente deseamos contratar. Por ejemplo **iessantiagoherandez.com** es la unión del SLD _iessantiagohernandez_ dentro del TLD _.com_
- Y por último, termina con un número indefinido de nodos de niveles inferiores. Todos estos niveles se separan con un punto al escribirlos. www.iessantiagoherandez.com


### Resumen de la jerarquía:

1. **Servidores raíz**: Son los encargados de dirigir la consulta a los servidores TLD. Por ejemplo quien se ocupa de los ".com"
2. **Servidores TLD**: Responden con la ubicación de los servidores autorizados para un dominio específico. Por ejemplo quien se ocupa del "ejemplo.com"
3. **Servidores autorizados**: Tienen la información final y oficial sobre el dominio, como la dirección IP que necesita el cliente. Es decir traduce la información de esos nombres o permite generar subdominios como departamento.ejemplo.com


#### Autoridad y delegación.

- El dominio raiz (.) lo administra el [ICANN](https://es.wikipedia.org/wiki/Corporaci%C3%B3n_de_Internet_para_la_Asignaci%C3%B3n_de_Nombres_y_N%C3%BAmeros). Todos los TLD son creados bajo su autoridad.
- Los gTLD son administrados de forma autorizada por el ICANN. Es decir, la creación del dominio **santiagohernandez.com** debe ser autorizada por el ICANN.
- Los ccTLD han sido delegados a los paises. La creación del dominio **santiagohernandez.com** debe ser autorizada por [Rediris](https://www.rediris.es/), entidad que gestiona dicha tarea.
- Algunos paises continuan delegando en areas más pequeñas. Pero eso no ocurre en España.
- Quien compra un dominio SLD es el responsable de crear subdominios o máquinas dentro de su dominio:
  - **www.iessantiagohernandez.com** sería el nombre por defecto para el host servidor de páginas web.
  - **alumnos.iessantiagohernandez.com** seria un subdominio que podría albergar otras máquinas como por ejemplo www.alumnos.iessantiagohernandez.com


### Cómo funciona el proceso DNS

1. **Resolución de nombres**: El proceso de traducción de un nombre de dominio a una dirección IP se llama "resolución de nombres". Esto involucra una serie de pasos:

   - **Paso 1: Consulta del navegador**: Cuando escribes un nombre de dominio en el navegador, este primero revisa si la dirección IP ya está guardada en su caché local (porque ya se ha visitado ese sitio antes). La caché está en el propio navegador o sistema operativo.
   - **Paso 2: Consulta al resolver DNS local**: Si no está en la caché del navegador, el sistema operativo consulta el servidor DNS configurado en tu red (generalmente, el de tu proveedor de servicios de Internet, o ISP). Este servidor es conocido como *resolutor*. Otras veces se usa uno genérico como el 8.8.8.8 de Google.
   - **Paso 3: Recursión**: Si el servidor DNS local no tiene la respuesta en su caché, comienza a realizar consultas recursivas a otros servidores DNS, empezando por los servidores raíz.

2. **Jerarquía de servidores DNS**: El sistema DNS está organizado jerárquicamente y tiene varios tipos de servidores:

   - **Servidores raíz**: Son los puntos de entrada al sistema DNS. Existen 13 servidores raíz distribuidos por el mundo, y son responsables de dirigir las consultas a los servidores correspondientes de los dominios de nivel superior (TLD, por sus siglas en inglés).
   - **Servidores TLD**: Estos servidores gestionan los dominios de nivel superior, como `.com`, `.org`, `.es`, etc. Cuando el servidor raíz recibe una consulta para `www.ejemplo.com`, redirige la consulta a los servidores TLD de `.com`.
   - **Servidores autorizados** (no digáis autoritativos o autoritarios): Son los que contienen la información definitiva sobre el dominio y su dirección IP. En este caso, el servidor autorizado para `ejemplo.com` devolverá la dirección IP asociada al dominio. Y no sólo eso, también qué direcciones tiene el servidor o servidores autorizados, quien se ocupa del correo electróncio y alguna información más.

3. **Respuesta final**: Una vez que el servidor DNS autorizado responde con la dirección IP correspondiente, esta se envía de vuelta al servidor DNS local, que a su vez la pasa al navegador. El navegador entonces puede conectarse al servidor de esa dirección IP para cargar el sitio web.

### Caché de DNS

Para optimizar el proceso y reducir la carga de trabajo en los servidores DNS, tanto los navegadores como los servidores DNS locales mantienen una caché con las respuestas a consultas recientes. Esto significa que si vuelves a visitar un sitio que ya has visitado antes, el navegador puede usar la dirección IP guardada sin tener que hacer toda la resolución de nuevo. Esta información se guarda un tiempo determinado (TTL, Time To Live).

### Ejemplo del flujo completo:

Supongamos que deseas acceder a `www.ejemplo.com`. Aquí te dejo un resumen del proceso:

1. **El navegador** busca si ya tiene la dirección IP de `www.ejemplo.com` en su caché.
2. Si no la encuentra, **consulta el servidor DNS** configurado en tu red (el servidor de tu ISP o uno público como Google DNS).
3. El servidor DNS consulta al **servidor raíz** para saber quién maneja el dominio `.com`.
4. El servidor raíz responde, indicando que la consulta debe enviarse a los **servidores TLD de `.com`**.
5. El servidor DNS consulta a los **servidores TLD** de `.com`, que responden indicando que el dominio `ejemplo.com` está gestionado por un servidor DNS autorizado.
6. El servidor DNS consulta a los **servidores autorizados** para `ejemplo.com`, y obtiene la dirección IP correspondiente.
7. Finalmente, el servidor DNS envía la dirección IP al navegador, que puede conectarse al servidor web y cargar la página.

### Tipos de registros DNS

Dentro de un servidor DNS, la información se organiza en diferentes tipos de "registros" que definen cómo se debe resolver un dominio. Los más comunes son:

- **A (Address Record)**: Asocia un nombre de dominio con una dirección IPv4 (por ejemplo, `www.ejemplo.com` → `192.0.2.1`).
- **AAAA**: Similar al registro A, pero para direcciones IPv6.
- **CNAME (Canonical Name)**: Redirige un dominio a otro (por ejemplo, `www.ejemplo.com` → `ejemplo.com`).
- **MX (Mail Exchange)**: Especifica los servidores de correo electrónico responsables de un dominio.
- **NS (Name Server)**: Indica qué servidores DNS son autorizados para un dominio.
- **TXT**: Permite almacenar texto arbitrario, utilizado para configuraciones de seguridad como SPF (Sender Policy Framework).


    
###  Herramientas de diagnóstico DNS

- A continuación tres enlaces para empezar a usar estas herramientas:

  - https://webirix.com/herramientas-de-diagnostico-dns-en-linux-host-nslookup-y-dig/
  - https://www.zeppelinux.es/herramienta-de-diagnostico-dns-dig/
  - https://www.youtube.com/watch?v=aAUahbLogKc

### Configurar servicio DNS en Linux: Bind

