# Gitbook

- Sistema que permite crear documetación online usando un framework sencillo.
- Dirección: https://www.gitbook.com/
- El framdwork estaba para uso local. Ahora se considra obsoleto:
  - https://github.com/gitbook-ng
  - https://github.com/GitbookIO/gitbook-cli

## Práctica de clase: GitBook de forma local

El objetivo es instalar un proyecto GitBook local. Ver su estructura y que podemos probarlo sin ayuda de un servidor externo.

- Vamos a necesitar usar node.js y npm.
- Necesitamos instalar nvm (Node Version Manager) para disponer de node.js y npm
- Seguimos las intrucciones de DigitalOcean:
    [https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04)
- Una vez instalado NVM. Instalamos node de acuerdo a las intrucciones.

```
nvm install v16
#para ver la versión de node:
node -v
```

- Creamos una carpeta vacía para nuestro proyecto

```
mkdir gitbook
cd gitbook
# seguimos las intrucciones de aquí:
# https://github.com/gitbook-ng/gitbook

npm install @gitbook-ng/gitbook
#editamos el fichero package.json de acuerdo a esa página
```

- Antes de probarlo:
    - Creamos un README.md con un texto de ejemplo
    - Creamos un SUMMARY.md con un contenido semejante a éste:


```
# Tabla de contenidos

* [Bienvenido](README.md)

## Capitulo 1

* [Capítulo 1](capitulo1.md)
```

- Añadimos un fichero capitulo1.md
- Para ver el resultado: `npm run serve`. Ya podemos visitar `http://localhost:4000`
- Para generar el sitio estático: `npm run build`


## Práctica de clase: GitBook en gitbook.com

- Crea una carpeta local:
    - Nombre de la carpeta: `pruebagitbook`
    - Conviértela en repositorio git: `git init`
    - Añade los ficheros del ejercicio anterior: README.md, SUMMARY.md, capitulo1.md
    - Haz un commit inicial con ese contenido.
- Crea un repositorio en github.com:
    - Nombre: pruebagitbook
    - Sigue los pasos necesarios para subir el contenido de  `pruebagitbook`
- Regístrate como usuario de gitbook.com
- Añade un sitio `pruebagitbook`
- Vínculalo al contenido de nuestro repositorio github.com (pruebagitbook).
- Publica el sitio.
- Modifica el contenido local. Haz nuevos commits y súbelos a github. Comprueba que el contenido de gitbook.com se actualiza tras unos segundos
