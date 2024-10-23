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
- No obstante, los conceptos aplicados son los mismos por lo que vamos a hacer la configuración en nuestro Ubunt Server

## SSH


## DNS


<!-- ## FTP -->