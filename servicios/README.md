# Servicdores de servicios

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
systemctl enable ssh

systemctl start ssh
```

### Veamos algunos casos de uso de SSH 

- Conexión a máquina remota

```bash
ssh direccionRemota
# direccionRemota es un nombre de dominio o una IP.
```

- Conexión a máquina remota usuario específico.

```bash
ssh usuario@direccionRemota
# direccionRemota es un nombre de dominio o una IP.
```

- Conexión a máquina remota puerto específico.

- Conexión sin contraseña.

- 


### Más cosas interesantes:

- Conexión gráfica a través de SSH. Reenvío de puertos X11
- Sistema de ficheros SSHFS
- Montar carpetas en VSC con SSH
- Copiar ficheros con SSH.
- Copiar ficheros con rsync y SSH.

## DNS


<!-- ## FTP -->