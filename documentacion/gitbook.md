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

Vamos a crear una documentación en GitBook.com. Dicho espacio va a estar sincronizado con un repositorio de GitHub. El contenido que editemos localmente lo subiremos a GitHub y nuestro documentación en GitBook se sincronizará en segundos.

Sigue estas instrucciones para llevarlo a cabo:

- Crea una carpeta local:
  - Nombre de la carpeta: `pruebagitbook`
  - Conviértela en repositorio git: `git init`
  - Añade los ficheros del ejercicio anterior: README.md, SUMMARY.md, capitulo1.md
  - Haz un commit inicial con ese contenido.  
- Ya tenemos un contenido inicial. Este contenido lo vamos a subir a Github.
  - Crea un repositorio en github.com:
  - Nombre: pruebagitbook
  - Sigue los pasos necesarios para subir el contenido de  `pruebagitbook`. Según lo hablado en clase, puedes optar por usar una rama _main_ o _master_.
- Ahora vamos a crear un sitio en GitBook.com. Lo vamos a sincronizar con nuestro repositorio GitHub y vamos a hacer que en la sincronización inicial
  - Regístrate como usuario de [gitbook.com](https://www.gitbook.com/). Tras hacer login llegarás a un sitio semejante a éste.

![Página de inicio](/assets/gitbook/01.png "Página de inicio")

  - Añade un sitio. Le llamaremos `pruebagitbook`. 

  ![Click nuevo](/assets/gitbook/02.png "")
  
  ![Elegimos _docs site_](/assets/gitbook/03.png "")

  - Indicaremos que sin contenido. 

  ![Marcamos _No content_](/assets/gitbook/04.png "")

  - Podríamos dejarlo para más tarde pero decimos que se publique ya.

  ![Marcamos _Publish now_](/assets/gitbook/05.png "")

  - Ya está creada la documentación en GitBook, pero está vacía. Seguimos ....
  - Ahora toca vincularlo al contenido de nuestro repositorio github.com (pruebagitbook). Ve al sitio en GitBook.com y pulta el icono de _configure_. A continuación ves varias imágenes que ilustran el proceso de configuración.

  ![Iniciamos la sincronización en _configure_](/assets/gitbook/06.png "")
  ---
  ![Activamos la sincronización](/assets/gitbook/07.png "")
  ---
  ![Y buscamos nuestra cuenta, repositorio y rama](/assets/gitbook/08.png "")

  - Cuando nos pregunte, marcamos que en la sicronización inicial copie el contenido de GitHub sobre el de GitBook, y pulsamos _sync_.

  ![Marcamos _GitHub to GitBook_](/assets/gitbook/09.png "")
  ---
  ![Esperamos que concluya el proceso](/assets/gitbook/10.png "")

  - Nuestro sitio web ya estará publicado con el contenido que hemos escrito localmente. De ahí en adelante, todo lo que escirbamos en nuesto repositorio local y subamos a GitHub será volcado en segundos en nuestra documentación GitBook.

  ![Ya hemos completado el proceso!](/assets/gitbook/11.png "")

  - Prueba que todo funciona. Modifica el contenido local. Haz nuevos commits y súbelos a github. Comprueba que el contenido de gitbook.com se actualiza tras unos segundos.
