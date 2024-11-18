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

---

#### 1. host

`host` es una herramienta más sencilla y directa que `nslookup` y `dig`, ideal para obtener resultados rápidos. A continuación, te muestro cómo usarla para realizar algunas consultas sobre **ejemplo.com**.

##### Consulta básica (Registro A)

Para obtener la dirección IP (registro A) de **ejemplo.com**:

```bash
host ejemplo.com
```

**Ejemplo de salida:**

```bash
ejemplo.com has address 185.199.110.153
```

Esto muestra que el dominio **ejemplo.com** resuelve a la dirección IP `185.199.110.153`.

##### Consultar registros MX (Mail Exchanger)

Para obtener los servidores de correo asociados con **ejemplo.com**:

```bash
host -t MX ejemplo.com
```

**Ejemplo de salida:**

```bash
ejemplo.com mail is handled by 10 mail.ejemplo.com.
```

Esto indica que el dominio **ejemplo.com** tiene un servidor de correo con el nombre **mail.ejemplo.com** y una prioridad de 10. Si hay varios, se tomaran por prioridad, el de menor en primer lugar.

##### Consulta a un servidor DNS específico

Para usar un servidor DNS específico (por ejemplo, `8.8.8.8`), podemos hacer lo siguiente:

```bash
host ejemplo.com 8.8.8.8
```

Esto consulta el servidor DNS de Google para obtener la dirección IP del dominio **ejemplo.com**.

##### Mostrar todos los registros

Para obtener todos los registros disponibles (A, MX, NS, etc.) de **ejemplo.com**, puedes usar:

```bash
host -a ejemplo.com
```

Esto devuelve todos los registros DNS asociados con **ejemplo.com**.

---

#### Resumen de Comandos

| **Comando**                        | **Descripción**                                               | **Ejemplo**                               |
|------------------------------------|---------------------------------------------------------------|-------------------------------------------|
| `nslookup ejemplo.com` | Consulta el registro A (dirección IP) del dominio.            | `nslookup ejemplo.com`       |
| `nslookup -query=MX ejemplo.com` | Consulta los registros MX del dominio.                   | `nslookup -query=MX ejemplo.com` |
| `dig ejemplo.com`     | Consulta el registro A del dominio.                          | `dig ejemplo.com`            |
| `dig ejemplo.com MX`  | Consulta los registros MX del dominio.                       | `dig ejemplo.com MX`         |
| `dig @8.8.8.8 ejemplo.com` | Consulta

 usando un servidor DNS específico (Google DNS).    | `dig @8.8.8.8 ejemplo.com`   |
| `host ejemplo.com`    | Consulta el registro A del dominio.                          | `host ejemplo.com`           |
| `host -t MX ejemplo.com` | Consulta los registros MX del dominio.                       | `host -t MX ejemplo.com`     |
| `host -a ejemplo.com` | Muestra todos los registros DNS del dominio.                 | `host -a ejemplo.com`        |

---


#### 2. nslookup (Name Server Lookup)

`nslookup` es una herramienta utilizada para consultar información sobre registros DNS. Está disponible en Linux y Windows. A continuación, exploraremos los comandos más comunes utilizando el dominio **ejemplo.com**.

##### Consulta básica (Registro A)

Para obtener la dirección IP (registro A) de **ejemplo.com**:

```bash
nslookup ejemplo.com
```

**Ejemplo de salida:**

```bash
Server:  UnKnown
Address:  192.168.1.1

Non-authoritative answer:
Name:    ejemplo.com
Address: 185.199.110.153
```

Esto indica que el dominio **ejemplo.com** resuelve a la dirección IP `185.199.110.153`.

##### Consultar registros MX (Mail Exchanger)

Para obtener los servidores de correo asociados con **ejemplo.com**, usamos la opción `-query=MX`:

```bash
nslookup -query=MX ejemplo.com
```

**Ejemplo de salida:**

```bash
Server:  UnKnown
Address:  192.168.1.1

Non-authoritative answer:
ejemplo.com     MX preference = 10, mail exchanger = mail.ejemplo.com
```

Esto indica que el dominio **ejemplo.com** tiene un servidor de correo con el nombre **mail.ejemplo.com** y una preferencia de 10.

##### Consultar un servidor DNS específico

Para realizar la consulta usando un servidor DNS específico, como Google DNS (8.8.8.8), podemos hacer lo siguiente:

```bash
nslookup ejemplo.com 8.8.8.8
```

Esto consulta el servidor DNS de Google para obtener la información del dominio **ejemplo.com**.

##### Consulta en modo interactivo

Para usar `nslookup` en modo interactivo, simplemente ejecutamos el comando `nslookup` sin ningún parámetro:

```bash
nslookup
```

Luego, en el prompt interactivo:

```bash
> ejemplo.com
```

Esto devolverá la misma información de resolución de nombre IP que obtuvimos en el ejemplo anterior.

Podemos cambiar el servidor que resolverá de forma recursiva.

```bash
> server
```
Podemos cambiar el tipo de registro:

```bash
> server
```

---

#### 3. dig (Domain Information Groper)

`dig` es una herramienta más avanzada que `nslookup`, que ofrece resultados más detallados y una mayor flexibilidad. A continuación, veremos cómo usar `dig` para consultar diferentes registros de **ejemplo.com**.

##### Información básica


```bash
dig 
```

**Ejemplo de salida:**

```bash
; <<>> DiG 9.18.28-0ubuntu0.22.04.1-Ubuntu <<>>
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 28581
;; flags: qr rd ra; QUERY: 1, ANSWER: 13, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;.				IN	NS

;; ANSWER SECTION:
.			5741	IN	NS	d.root-servers.net.
.			5741	IN	NS	m.root-servers.net.
.			5741	IN	NS	b.root-servers.net.
.			5741	IN	NS	j.root-servers.net.
.			5741	IN	NS	i.root-servers.net.
.			5741	IN	NS	c.root-servers.net.
.			5741	IN	NS	e.root-servers.net.
.			5741	IN	NS	l.root-servers.net.
.			5741	IN	NS	f.root-servers.net.
.			5741	IN	NS	a.root-servers.net.
.			5741	IN	NS	h.root-servers.net.
.			5741	IN	NS	g.root-servers.net.
.			5741	IN	NS	k.root-servers.net.

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Nov 18 00:38:16 CET 2024
;; MSG SIZE  rcvd: 239
```

##### Consulta básica (Registro A)

Para obtener la dirección IP del dominio:

```bash
dig ejemplo.com
```

**Ejemplo de salida:**

```bash
; <<>> DiG 9.10.6 <<>> ejemplo.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 12345
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; QUESTION SECTION:
; ejemplo.com. IN A
;; ANSWER SECTION:
ejemplo.com. 3600 IN A 185.199.110.153
;; Query time: 10 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
;; WHEN: Sun Nov 17 14:30:50 UTC 2024
;; MSG SIZE  rcvd: 56
```

Este comando consulta el registro A del dominio **ejemplo.com** y obtiene la dirección IP `185.199.110.153`.

##### Consultar registros MX (Mail Exchanger)

Para consultar los servidores de correo asociados al dominio **ejemplo.com**:

```bash
dig ejemplo.com MX
```

**Ejemplo de salida:**

```bash
; <<>> DiG 9.10.6 <<>> ejemplo.com MX
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 67890
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; QUESTION SECTION:
;ejemplo.com.        IN      MX
;; ANSWER SECTION:
ejemplo.com.    3600    IN      MX      10 mail.ejemplo.com.
;; Query time: 20 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
;; WHEN: Sun Nov 17 14:31:15 UTC 2024
;; MSG SIZE  rcvd: 56
```

Esto muestra que el servidor de correo para **ejemplo.com** es **mail.ejemplo.com**, con una preferencia de 10.

##### Consulta recursiva y no recursiva

- **Recursiva (predeterminada)**:

  ```bash
  dig ejemplo.com
  ```

  Esto realizará una consulta recursiva, es decir, si el servidor DNS que estamos usando no tiene la información, lo buscará en otros servidores DNS.

- **No recursiva**:

  ```bash
  dig +norecurse ejemplo.com
  ```

  En este caso, el servidor DNS solo devolverá los datos que tenga disponibles y no hará consultas adicionales a otros servidores.

##### Consulta a un servidor DNS específico

Si deseas consultar el dominio utilizando un servidor DNS específico (como el servidor DNS de Google `8.8.8.8`), puedes hacerlo de la siguiente forma:

```bash
dig @8.8.8.8 ejemplo.com
```

Esto consulta el servidor DNS de Google para obtener la dirección IP de **ejemplo.com**.

##### Consulta con opción `+trace`

Para obtener información detallada sobre cómo se resuelve el dominio (es decir, la cadena de consultas a diferentes servidores DNS):

```bash
dig +trace ejemplo.com
```

Esto muestra cada paso del proceso de resolución DNS, comenzando desde el servidor raíz hasta el servidor autoritativo del dominio.

---


### Configurar servicio DNS en Linux: Bind9

Vídeo interesante: https://www.youtube.com/watch?v=4IuNKK2y49s

**Tutorial: Configuración de un servidor DNS con BIND9 en Ubuntu**

### **Paso 1: Instalación de BIND9**

1. **Actualizar los paquetes del sistema**:
   Antes de instalar cualquier software, es recomendable actualizar los paquetes de tu sistema.

   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. **Instalar BIND9**:
   BIND9 es el software de servidor DNS más común en sistemas Linux. Para instalarlo, ejecuta el siguiente comando:

   ```bash
   sudo apt install bind9 bind9utils bind9-doc dnsutils -y
   ```

   - `bind9` es el servidor DNS.
   - `bind9utils` contiene herramientas adicionales.
   - `bind9-doc` proporciona la documentación (opcional).
   - `dnsutils` incluye herramientas para probar la configuración (como `dig`).

3. **Habilitar e iniciar el servicio BIND9**:
   Una vez que la instalación esté completa, asegúrate de que el servicio esté habilitado e iniciado.

   ```bash
   sudo systemctl enable bind9
   sudo systemctl start bind9
   ```

4. **Verificar el estado del servicio**:
   Para verificar que BIND9 esté funcionando correctamente, usa el siguiente comando:

   ```bash
   sudo systemctl status bind9
   ```

   Debes ver algo como `Active: active (running)`.

### **Paso 2: Configuración básica de BIND9**

BIND9 se configura mediante archivos de configuración ubicados en el directorio `/etc/bind/`. Los archivos principales que debes editar son:

- `/etc/bind/named.conf` (configuración principal)
- `/etc/bind/named.conf.local` (configuración local)
- `/etc/bind/named.conf.options` (opciones globales)
- Archivos de zona (por ejemplo, `/etc/bind/db.example.com`)

#### 2.1 Configuración del archivo `/etc/bind/named.conf.local`

Este archivo se utiliza para definir las zonas de tu servidor DNS.

1. Abre el archivo para editarlo:

   ```bash
   sudo nano /etc/bind/named.conf.local
   ```

2. Agrega la configuración de una zona. A continuación se muestra un ejemplo de una zona llamada `example.com`:

   ```bash
   zone "example.com" {
       type master;
       file "/etc/bind/db.example.com";
   };
   ```

   - `type master;` indica que este servidor es el principal para la zona.
   - `file "/etc/bind/db.example.com";` especifica el archivo que contiene los registros de la zona.

#### 2.2 Crear el archivo de zona

Ahora necesitamos crear el archivo que contiene los registros DNS de la zona `example.com`.

1. Copia un archivo de zona predeterminado para crear el nuevo archivo de zona:

   ```bash
   sudo cp /etc/bind/db.local /etc/bind/db.example.com
   ```

2. Abre el archivo `/etc/bind/db.example.com` para editarlo:

   ```bash
   sudo nano /etc/bind/db.example.com
   ```

3. Modifica el archivo para adaptarlo a tus necesidades. Aquí tienes un ejemplo básico de un archivo de zona para `example.com`:

   ```txt
   $TTL    604800
   @       IN      SOA     ns1.example.com. admin.example.com. (
                         2023111801 ; Serial
                         604800     ; Refresh
                         86400      ; Retry
                         2419200    ; Expire
                         604800 )   ; Negative Cache TTL

           IN      NS      ns1.example.com.
           IN      NS      ns2.example.com.

   ns1     IN      A       192.168.1.10
   ns2     IN      A       192.168.1.11
   @       IN      A       192.168.1.20
   www     IN      A       192.168.1.20
   mail    IN      A       192.168.1.30
   @       IN      MX      10 mail.example.com.
   ```

   - `SOA` (Start of Authority) es el servidor princial de DNS.
     - admin.example.com representa el email del administrador (admin@example.com)
     - Serial es número de serie
     - Refresh. Tiempo que tardan los secundarios en consultar este principal.
     - Retry. Tiempo que tardan los secundarios en reintentar si hay fallo.
     - Expire. Tiempo que los secundarios mantienen los datos DNS.
     - TTL. Tiempo que se conservan los datos en caché.
   - `NS` son los servidores de nombres (Name Servers) para tu dominio.
   - `A` son los registros de direcciones IPv4.
   - `MX` es el registro de correo.

4. Guarda y cierra el archivo.

#### 2.3 Configuración de las opciones globales (`named.conf.options`)

El archivo `named.conf.options` se usa para configurar las opciones globales del servidor DNS, como el reenvío de consultas.

1. Abre el archivo de configuración:

   ```bash
   sudo nano /etc/bind/named.conf.options
   ```

2. Asegúrate de que la configuración de reenvío esté habilitada si deseas que tu servidor reenvíe consultas a otros servidores DNS. Aquí hay un ejemplo básico de configuración:

   ```txt
   options {
       directory "/var/cache/bind";

       recursion yes;
       allow-query { any; };
       forwarders {
           8.8.8.8;
           8.8.4.4;
       };

       auth-nxdomain no;
       listen-on { any; };
   };
   ```

   - `recursion yes;` habilita la recursividad.
   - `allow-query { any; };` permite consultas desde cualquier IP.
   - `forwarders` define los servidores DNS a los que se reenviarán las consultas que el servidor no pueda resolver de manera recursiva. (En este caso, Google DNS).
   - `listen-on { any; };` indica que el servidor escuchará en todas las interfaces de red.

3. Guarda y cierra el archivo.

### **Paso 3: Verificación de la configuración**

1. **Reiniciar BIND9**:
   
   Después de realizar los cambios, es necesario reiniciar el servicio de BIND9 para que se apliquen las configuraciones.

   ```bash
   sudo systemctl restart bind9
   ```

2. **Verificar la configuración**:

   Puedes usar las herramientas `named-checkconf` y `named-checkzone` para verificar la configuración de BIND9:

   - Verificar el archivo de configuración principal (`named.conf`):

     ```bash
     sudo named-checkconf
     ```

   - Verificar el archivo de zona (`db.example.com`):

     ```bash
     sudo named-checkzone example.com /etc/bind/db.example.com
     ```

   Si todo está bien configurado, no debería haber salida (solo retornará al prompt).

3. **Probar la resolución DNS**:

   Usa la herramienta `dig` para probar la resolución DNS de tu servidor:

   ```bash
   dig @localhost example.com
   ```

   Este comando debe devolver la dirección IP que configuraste para `example.com` en el archivo de zona.

### **Paso 4: Configuración de cortafuegos (opcional)**

Si tienes un firewall activo, asegúrate de permitir el tráfico en el puerto 53 (UDP y TCP) para que tu servidor DNS pueda recibir consultas.

1. Permitir tráfico DNS en el firewall:

   ```bash
   sudo ufw allow 53
   ```

2. Verificar las reglas del firewall:

   ```bash
   sudo ufw status
   ```

