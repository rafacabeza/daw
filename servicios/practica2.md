Práctica 2. DNS

Servicio de DNS

## Objetivos

- Conocer el funcionamiento del servicio DNS
- Conocer los distintos registros asocidados a un dominio DNS.
- Conocer cómo suplantar el DNS de forma local.

### Herramientas de diagnóstico

- Toma un dominio público: 
  1. github.com
  2. gitlab.com
  3. bitbucket.com
  4. trello.com
  5. atlassian.com
  6. x.com
  7. facebook.com
  8. twiter.com
  9. facbook.com
  10. instagram.com
  11. wikipedia.com
  12. elpais.com
  13. marca.com
  14. heraldo.es
  15. apple.com

- Intenta resolver las siguientes preguntas con con las 3 herramientas presentadas: host,nslookup y dig.
  - Busca la IP asignada
  - Quien resuelve su DNS
  - Cuál es el servidor de correo electrónico. Si hay varios, determina cual es primero por su prioridad.
  - Haz la búsqueda de forma autorizada, es decir, que el servidor que contesta sea uno de los registos NS del dominio.

### Suplantar servicio DNS localmente.

- Edita el fichero `/etc/hosts` para que resuelva un nombre de dominio falso con el siguiente esquema: 
  - `miapellido.local` asociado a la dirección 127.0.0.1
  - `miapellido.es` asociado a una dirección pública inventada.
  - `miapellido.com` asociado a la dirección del dominio de la primera parte de la práctica. Si eres el nº 1 sería `github.com`
- Comprueba la resolución de los tres registros con alguna de las herramientas de diagnóstico.
- Comprueba la misma resolución pero haciendo que el servidor consultado sea el 8.8.8.8

### Configuración del servidor  DNS con BIND9

- Configura el dominio `miapellido.edu` en bind9. Debes hacerlo:
  - En el servidor linux
  - Conectándote al mismo mediante SSH
- Debes definir:
