# Práctica 1

- Desplegar una aplicación de servidor con Node.js

## Objetivos

- Node.js no requiere de un servidor como Apache. Express es una librería que hace las funciones de servidor.
- Instalar Node usando nvm
- Desplegar una aplicación de Node.js que usa Express y Mysql. En este caso se trata de una API REST

## Punto de partida

- Sería interesante hace la instalación en un servidor aparte pero las limitaciones de Campusvdi nos lleva a hacerlo en el mismo, es decir **serve2**.
- Usaremos también el cliente para comprobar el funcionamiento de nuestra aplicación

## Instalación de Node con NVM


## Node.js

Node.js es un entorno de ejecución de JavaScript que permite ejecutar código JavaScript fuera de un navegador. Fue creado en 2009 por **Ryan Dahl** y está diseñado para construir aplicaciones rápidas y escalables.  

Se basa en el motor **V8**, el mismo que usa Google Chrome para interpretar JavaScript. Es eficiente y ligero.

### Características principales:

1. **JavaScript en el servidor**: Permite usar JavaScript tanto en el cliente (navegador) como en el servidor.
2. **Asincronía**: Es perfecto para manejar múltiples solicitudes al mismo tiempo sin bloquear el proceso principal, ideal para aplicaciones en tiempo real como chats o transmisiones en vivo.
3. **NPM (Node Package Manager)**: Un ecosistema gigante de bibliotecas y herramientas que puedes instalar fácilmente.
4. **Ligero y escalable**: Diseñado para manejar muchas conexiones simultáneamente con un rendimiento eficiente.
5. **Multiplataforma**: Funciona en Windows, macOS y Linux.
6. **NVM.** Para poder usar distintas versiones de forma flexible se usa el Node Version Manager (NVM). Permite cambiar fácilmente de versión. Incluso permite tener varias versiones corriendo en el mismo equipo, cada una de ellas en distintas carpetas o proyectos.

### ¿Para qué se usa Node.js?

- Servidores para aplicaciones web y APIs REST.
- Aplicaciones en tiempo real (chats, juegos multijugador).
- Desarrollo de microservicios.
- Herramientas de línea de comandos.
- Aplicaciones de backend con conexión a bases de datos.

### Ejemplo básico:

Un servidor HTTP simple con Node.js. Edita este código en un fichero llamado `index.js`:

```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hola, mundo');
});

server.listen(3000, () => {
  console.log('Servidor ejecutándose en http://localhost:3000');
});
```

Se ejecuta usando el comando `node index.js`. Este código crea un servidor que responde "¡Hola, mundo!" cuando visitas la URL.


## Instalar Node.js

En esta guía encontrarás varias maneras de instalarlo:

[https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04#option-3-installing-node-using-the-node-version-manager](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04#option-3-installing-node-using-the-node-version-manager)


Hay varias maneras de instalar Node.js. La más sencilla es la típica:

```bash
sudo apt install node
```

Sin embargo es más interesante usar la instalación con NVM. Accede al enlace y procede a instalar en el servidor. Hazlo usando ssh para poder copiar y pegar comandos.

Una vez instalado NVM puedes probar algunos comandos. Hazlo e interpreta lo que ocurre en cada caso:

```bash
nvm list-remote
nvm list
nvm install v20.18.0
nvm current //comprobar versión actual
node -v     //similar
npm -v      //versión del gestor de dependencias Node Package Manager
nvm install v18
nvm install 18
node -v
node use v20
node -v
```

Ahora puedes probar el fichero anteriormente mostrado: `node index.js`

## Despliegue de una aplicación

- Vamos a desplegar una aplicación ya existente que usa Express y Mysql
- Clona el código de esta aplicación: [https://github.com/rafacabeza/demoapinode](https://github.com/rafacabeza/demoapinode)
- Instala las dependencias con npm: `npm install`
- Crea una base de datos demo con el sql que hay disponible en el código.
- Parametriza la conexión a MySql
- Ejecuta la aplicación (`npm start`) y prueba su funcionamiento en el naveagora: http://192.168.0.1:3000