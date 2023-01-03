# Solution al desafio #1 Universidad de Alchemy

Objetivos:
Al final de este tutorial, aprenderás a hacer lo siguiente:

    Cómo escribir y modificar el contrato inteligente utilizando OpenZeppelin y Remix.
    Obtener ETH Goerli gratis usando https://goerlifaucet.com/
    Desplegarlo en la blockchain de Ethereum Goerli testnet para ahorrar en tasas de gas
    Aloja los metadatos de los tokens NFT en IPFS usando Filebase.
    Menta un NFT y visualízalo en OpenSea

## Comenzando 🚀

Estas instrucciones te permitirán tener una copia del proyecto corriendo en tu máquina local para 
propósitos de desarrollo y pruebas.

Ver **Despliegue** para saber cómo desplegar el proyecto.

### Prerrequisitos 📋

Desarrollar el Contrato Inteligente ERC721 con el Asistente de Contratos de OpenZeppelin

Como hemos dicho antes, en este tutorial, vas a utilizar el Asistente de OpenZeppelin para crear el contrato inteligente. 
inteligente, por dos razones principales:

    Es seguro.
    Ofrece contratos inteligentes estándar.

Cuando se trata de escribir contratos inteligentes, la seguridad es clave. Hay toneladas de ejemplos de contratos inteligentes 
que han visto cientos de millones de dólares robados por actores maliciosos debido a la mala seguridad.

No quieres que alguien te robe todas tus preciadas criptomonedas o NFTs una vez que las despliegues en el 
blockchain, ¿verdad?

OpenZeppelin sirve a este propósito, siendo uno de los mayores mantenedores de los estándares de contratos inteligentes 
(ERC20, ERC721, etc), permitiendo a los desarrolladores utilizar código auditado a fondo para desarrollar contratos fiables.

Lo primero que hay que hacer para desarrollar nuestro contrato inteligente NFT ERC721 es [ir a la página Open 
Zeppelin Smart contract wizard page](https://docs.openzeppelin.com/contracts/4.x/wizard).

Una vez en la página, verás el siguiente editor:

[Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Haga clic en el botón ERC721 en la esquina superior izquierda, para seleccionar el tipo de estándar ERC a utilizar y el 
tipo de contrato que desea redactar:

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Ahora que ha seleccionado la norma contractual, en el menú de la izquierda debería ver una serie de 
opciones:

Empecemos por elegir el nombre y el símbolo de nuestros Tokens. Haga clic en el cuadro de texto con "MyToken" y 
nombre, haga lo mismo con el símbolo y deje en blanco el campo URI base (el nombre del token será utilizado por OpenSea y Rar). 
utilizado por OpenSea y Rarible como el nombre de la colección).

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Seleccione las características del token NFT (ERC721).

Ahora tendrás que seleccionar las características que quieres integrar en nuestro Smart contract, justo después de 
la sección de configuración, encontrarás la sección de características donde podrás seleccionar los diferentes 
módulos a incluir en tu contrato inteligente.

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

En este caso, vas a seleccionar las siguientes integraciones:

    Mintable creará una función mint sólo invocable por cuentas privilegiadas
    Autoincrement IDs asignará automáticamente IDs incrementales a sus NFTs
    Enumerable le dará acceso a la enumeración de Tokens en la cadena y a funciones como "totalSupply", no presentes en la integración ERC721 por defecto URI storage, para asociar metadatos e imágenes a cada uno de sus NFTs
    Almacenamiento URI, para poder asociar URIs a nuestras NFTs

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Por el bien de este tutorial, y porque no quieres crear ningún tipo de Tokenomic alrededor de nuestros 
NFTs, deje los siguientes módulos sin marcar:

    Burnable - para quemar fichas
    Pausable - para pausar transferencias de tokens, ventas, etc.
    Votes - da acceso a funciones de gobierno como delegados y votos.

Si quieres saber más sobre estos módulos, consulta la documentación oficial de OpenZeppelin sobre el estándar 
estándar ERC721.

Ahora que has seleccionado las características que deseas, el Asistente de OpenZeppelin rellenará el código del Smart 
Contract, que debería tener el siguiente aspecto:

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Alchemy is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    constructor() ERC721("Alchemy", "ALC") {}

    function safeMint(address to, uint256 tokenId, string memory uri)
        public
        onlyOwner
    {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
```

Es hora de copiar nuestro código y llevarlo a Remix IDE para modificarlo y desplegarlo en la Blockchain.


### Instalación 🔧

Modifica y despliega tu contrato ERC721 con REMIX IDE_

Ahora que ya tienes tu contrato inteligente ERC721, vamos a modificarlo, y desplegarlo en la Goerli Testnet. Para ello 
Para ello, utilizará Remix IDE, un entorno de desarrollo integrado gratuito y basado en web diseñado específicamente 
para el desarrollo de contratos inteligentes con Solidity.

En primer lugar, como te habrás dado cuenta, en la parte superior del editor OpenZeppelin Wizard, está el botón 
"Abrir en Remix":

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Haciendo clic en él se abrirá REMIX IDE en una nueva pestaña de tu navegador.

Uso de Remix para modificar el contrato inteligente NFT

A partir de la parte superior del contrato, no es el "SPDX-Licencia-Identificador" que especifica el tipo de 
licencia bajo la que se publicará tu código - es una buena práctica en aplicaciones web3 mantener el código 
código abierto, ya que garantizará la fiabilidad.

```
// SPDX-License-Identifier: MIT
```

Luego está el pragma: la versión del compilador que querrás usar para compilar el código del contrato inteligente. 
del contrato inteligente. El pequeño símbolo "^", le dice al compilador que cualquier versión entre 0.8.0 y 0.8.9 es adecuada para 
compilar nuestro código.

```
pragma solidity ^0.8.17;
```

Luego importamos un montón de librerías e inicializamos el contrato inteligente.

```
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
```

A continuación, inicializamos el contrato, heredando todos los estándares que estamos importando del repositorio OpenZeppelin:

```
contract Alchemy is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {...}
```

Como puedes observar, la función safeMint tiene el modificador "only owner" - esto permitirá sólo al propietario 
del contrato inteligente (la dirección del monedero que desplegó el contrato inteligente) acuñar NFTs. Lo más probable es que 
quieras que cualquiera pueda acuñar NFTs, para ello tendrás que eliminar el modificador onlyOwner de la función Mint.

```
function safeMint(address to, string memory uri) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }
```

También puede eliminarlo de la declaración de contrato "Ownable", y la bibrary impot.

```
import "@openzeppelin/contracts/access/Ownable.sol";
```

Ahora que todo el mundo podrá acuñar nuestros NFT, tendrás que evitar que la gente acuñe más NFT que el número máximo de NFT de 
nuestra colección. Para ello, especifiquemos el número máximo de NFT minables.

Digamos que queremos que los usuarios puedan acuñar hasta un total de 10.000 NFT. Para ello, creemos una nueva variable uint256, 
llamémosla MAX_SUPPLY, y asignémosle 10.000.

```
Counters.Counter private _tokenIdCounter;
    uint256 MAX_SUPPLY = 100000;

    constructor() ERC721("Alchemy", "ALCH") {}
```

A continuación, pasemos a la función safeMint y añadamos una sentencia require en la línea 18:

```
require(_tokenIdCounter.current() <= MAX_SUPPLY, "I'm sorry we reached the cap");
```

Dediquemos un par de palabras a entender mejor qué es la sentencia "require" en Solidity.

Puedes leer más sobre la sentencia "require" de Solidity en la documentación oficial.

Ahora que hemos limitado el suministro máximo de nuestros NFTs, es el momento de compilar el contrato inteligente y desplegarlo en la Goerli Testnet. Para 
hacerlo, tendrás que crear una cuenta gratuita en [Alchemy.com](https://alchemy.com/?a=roadtoweb3weekone), añadirla como proveedor de nodos 
en Metamask, y conseguir algo de [Goerli ETH gratis](https://goerlifaucet.com/).

Crear una cuenta gratuita de Alchemy

En primer lugar, vamos a tener que navegar a [Alchemy.com](https://alchemy.com/?a=roadtoweb3weekone) haga clic en "Login" y crear un nuevo 
cuenta:

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Seleccione el ecosistema Ethereum:

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Dale un nombre a tu aplicación y a tu equipo, elige la red Goerli y haz clic en crear App:

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Una vez que hayas completado el proceso de onboarding, seremos redirigidos al dashboard. Haz clic en la aplicación con el nombre 
que hayas decidido, en este caso, "test", haz clic en el botón "VER CLAVE" de la esquina superior derecha y copia la URL HTTP:

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

A continuación, tendrá que añadir Alchemy a Metamask como proveedor Goerli RPC. Si no tienes Metamask instalado, asegúrate de 
seguir esta guía para añadirlo a tu navegador y crear un nuevo monedero.

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Serás redirigido a la siguiente página, donde tendrás que rellenar la información de la red Goerli y la URL RPC.

Texto alternativo](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Añade la siguiente información al formulario:

    Nombre de la red: Alchemy Goerli
    Nueva URL RPC: la URL HTTP de la aplicación Goerli Alchemy
    ID de cadena: 5
    Símbolo de moneda: GoerliETH
    Explorador de bloques: https://goerli.etherscan.io

Increíble, ¡acabas de añadir Goerli a Metamask, usando Alchemy! 🎉

Ahora es el momento de desplegar nuestro Contrato Inteligente en Goerli, pero antes, necesitarás conseguir ETH de Prueba de Goerli.

Conseguir ETH de Prueba Goerli gratis

Conseguir Goerli ETH de prueba es super sencillo, sólo tienes que navegar a [goerlifaucet.com](https://goerlifaucet.com/), copiar 
la dirección de la cartera en la barra de texto, y haga clic en "Send Me ETH":

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

A continuación, tendrá que añadir Alchemy a Metamask como proveedor Goerli RPC. Si no tienes Metamask instalado, asegúrate de 
seguir esta guía para añadirlo a tu navegador y crear un nuevo monedero.

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Serás redirigido a la siguiente página, donde tendrás que rellenar la información de la red Goerli y la URL RPC.

Texto alternativo](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Añade la siguiente información al formulario:

    Nombre de la red: Alchemy Goerli
    Nueva URL RPC: la URL HTTP de la aplicación Goerli Alchemy
    ID de cadena: 5
    Símbolo de moneda: GoerliETH
    Explorador de bloques: https://goerli.etherscan.io

Increíble, ¡acabas de añadir Goerli a Metamask, usando Alchemy! 🎉

Ahora es el momento de desplegar nuestro Contrato Inteligente en Goerli, pero antes, necesitarás conseguir ETH de Prueba de Goerli.

Conseguir ETH de Prueba Goerli gratis
![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Después de 10-20 segundos verás aparecer el Goerli ETH en la Cartera Metamask.

Podrás conseguir hasta 0,1 ETH cada 24 sin iniciar sesión, o 0,5 con una cuenta de Alchemy.

Ahora que ya tienes la ETH de prueba, es hora de compilar y desplegar nuestro contrato inteligente NFT en la blockchain.

Compilar y desplegar el contrato inteligente NFT en la red de prueba Goerli.

De vuelta a Remix, vamos a hacer clic en el menú del compilador en el lado izquierdo de la página y haga clic en el botón azul 
"Compilar":

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

A continuación hagamos clic en el menú "Deploy and Run Transactions", hagamos clic en el menú desplegable "Environment" y 
seleccionemos "injected Web3":

Asegúrate de que el monedero Metamask está en la red Alchemy Goerli, selecciona el contrato inteligente NFT en el menú desplegable 
Contract, y haga clic en Desplegar.

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Aparecerá una ventana emergente de Metamask, haz clic en "firmar", y procede a pagar las tasas de gas.

Si todo ha funcionado como esperabas, después de 10 segundos deberías ver el contrato en la lista de Contratos Desplegados:

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Ahora que el contrato inteligente está desplegado en la red de pruebas Goerli, es hora de acuñar nuestros NFTs, pero primero, 
necesitarás crear y subir los metadatos a IPFS, entendamos a qué nos referimos con el término "metadatos".

¿Qué son los metadatos NFT?

![Texto alternativo](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Para que OpenSea extraiga metadatos fuera de la cadena para tokens ERC721, el contrato tendrá que devolver un URI que apunte a los 
metadatos alojados alojados. Para encontrar este URI, OpenSea, Rarible y otros mercados populares utilizarán el método tokenURI 
contenido en el estándar ERC721Uristorage.

La función tokenURI del ERC721 debe devolver una URL HTTP o IPFS, como ipfs://
bafkreig4rdq3nvyg2yra5x363gdo4xtbcfjlhshw63we7vtlldyyvwagbq. Cuando se consulta, esta URL debe devolver un blob de datos JSON con 
los metadatos de su token.

Puede obtener más información sobre [estándares de metadatos en la documentación oficial de OpenSea](https://docs.opensea.io/docs/
metadata-standards).

_Cómo formatear sus metadatos NFT_

Según la documentación de OpenSea, los metadatos NFT deben almacenarse en un archivo .json y estructurarse de la siguiente manera:

```
{ 
  "description": "YOUR DESCRIPTION",
  "external_url": "YOUR URL",
  "image": "IMAGE URL",
  "name": "TITLE", 
  "attributes": [
    {
      "trait_type": "Base", 
      "value": "Starfish"
    }, 
    {
      "trait_type": "Eyes", 
      "value": "Big"
    }, 
    {
      "trait_type": "Mouth", 
      "value": "Surprised"
    }, 
    {
      "trait_type": "Level", 
      "value": 5
    }, 
    {
      "trait_type": "Stamina", 
      "value": 1.4
    }, 
    {
      "trait_type": "Personality", 
      "value": "Sad"
    }, 
    {
      "display_type": "boost_number", 
      "trait_type": "Aqua Power", 
      "value": 40
    }, 
    {
      "display_type": "boost_percentage", 
      "trait_type": "Stamina Increase", 
      "value": 10
    }, 
    {
      "display_type": "number", 
      "trait_type": "Generation", 
      "value": 2
    }]
  }
```

He aquí una breve explicación de lo que almacena cada propiedad:

Propiedad Explicación
* Imagen: Es la URL de la imagen del elemento. Puede ser casi cualquier tipo de imagen (incluyendo SVGs, que serán almacenados en 
caché en PNGs por OpenSea), y pueden ser URLs IPFS o rutas. Recomendamos utilizar una imagen de 350 x 350.
* Datos_de_imagen: Datos de imagen SVG sin procesar, si desea generar imágenes sobre la marcha (no recomendado). Utilícelo sólo si 
no incluyendo el parámetro image.
* URL_externa:	Esta es la URL que aparecerá debajo de la imagen del activo en OpenSea y permitirá a los usuarios salir de OpenSea 
y ver el elemento en su sitio.
* Descripción:	Una descripción legible por humanos del elemento. Se admite Markdown.
* name: Nombre del elemento
* Atributos:	Estos son los atributos del elemento, que se mostrarán en la página OpenSea del elemento. (ver más abajo)
* background_color: Color de fondo del elemento en OpenSea. Debe ser hexadecimal de seis caracteres sin un prefijo.
* animation_url:	Una URL a un archivo multimedia adjunto para el elemento. Se admiten las extensiones de archivo GLTF, GLB, WEBM, 
MP4, M4V, OGV y OGG. 
junto con las extensiones de audio MP3, WAV y OGA. Animation_url también admite páginas HTML, lo que nos permite crear 
experiencias ricas y NFT interactivas utilizando JavaScript canvas, WebGL, etc. Los scripts y las rutas relativas dentro de la 
página HTML son ahora compatibles. Sin embargo, no se admite el acceso a las extensiones del navegador. youtube_url Una URL a un 
vídeo de YouTube.

Ahora que ya sabemos lo que contendrán los metadatos de tokens, vamos a aprender a crearlos y almacenarlos en IPFS. 
en IPFS.

Creación y carga de los metadatos en IPFS

En primer lugar, navega a [filebase.com](https://filebase.com/) y crea una nueva cuenta.

Una vez iniciada la sesión, haz clic en el botón bucket del menú de la izquierda y crea un nuevo bucket:

[Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Navega dentro del bucket, haz clic en el botón de subir, y sube la imagen que quieras usar para tu NFT, yo usaré la siguiente.

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Una vez cargado pulsa sobre él y copia la URL del Gateway IPFS:

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Utilizando cualquier editor de texto, pega el siguiente código JSON:

```
{ 
  "description": "This NFT proves I've created and deployed my first ERC20 smart contract on Goerli with Alchemy Road to Web3",
  "external_url": "Alchemy.com/?a=roadtoweb3weekone",
  "image": "https://ipfs.filebase.io/ipfs/bafybeihyvhgbcov2nmvbnveunoodokme5eb42uekrqowxdennt2qyeculm",
  "name": "A cool NFT", 
  "attributes": [
    {
      "trait_type": "Base", 
      "value": "Starfish"
    }, 
    {
      "trait_type": "Eyes", 
      "value": "Big"
    }, 
    {
      "trait_type": "Mouth", 
      "value": "Surprised"
    }, 
    {
      "trait_type": "Level", 
      "value": 5
    }, 
    {
      "trait_type": "Stamina", 
      "value": 1.4
    }, 
    {
      "trait_type": "Personality", 
      "value": "Sad"
    }, 
    {
      "display_type": "boost_number", 
      "trait_type": "Aqua Power", 
      "value": 40
    }, 
    {
      "display_type": "boost_percentage", 
      "trait_type": "Stamina Increase", 
      "value": 10
    }, 
    {
      "display_type": "number", 
      "trait_type": "Generation", 
      "value": 2
    }]
  }
```

Y guarda el archivo como "metadata.json". Vuelve a Filebase y sube el archivo metadata.json en el mismo bucket donde subimos 
la imagen.

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

_Menta tu Goerli NFT_

Vuelve a Remix y en el menú Deploy & Run Transactions, ve a "deployed contracts" - y pulsa sobre el contrato que acabamos de 
desplegado, se abrirá una lista de todos los métodos contenidos en su contacto inteligente:

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Los métodos naranjas son métodos que realmente escriben en la blockchain mientras que los métodos azules son métodos que aprenden 
de la blockchain.

Haz clic en el icono desplegable del método safeMint y pega tu dirección y la siguiente cadena en el campo uri:

```
ipfs://<sus_metadatos_cid>
```

Al hacer clic en "Transact", aparecerá una ventana emergente de Metamask en la que se le pedirá que pague las tasas de gas.

Haga clic en "firmar" y ¡a acuñar su primer NFT!

Espere un par de segundos y, para asegurarse de que la acuñación se ha realizado correctamente, copie y pegue su dirección en la 
entrada del método balanceOf  y ejecútalo: debería mostrar que tienes 1 NFT.

Haz lo mismo con el método tokenUri, insertando "0" como argumento de id - debería mostrar tu tokenURI.

Y ya está. ¡Acabas de acuñar tu primer NFT! 🎉

Ahora es el momento de pasar a OpenSea para comprobar si los metadatos son benignos leer.

Visualice su NFT en OpenSea

Navega a [testnets.opensea.io](https://testnets.opensea.io/) e inicia sesión con tu monedero Metamask. A continuación, haga clic 
en su perfil debería ver allí su NFT recién acuñado. Si la imagen aún no es visible, haga clic en ella, y haga clic en el botón 
"refrescar metadatos".

![Texto alternativo](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

A veces a OpenSea le cuesta reconocer los metadatos de la red de pruebas y puede tardar hasta 6 horas en verlos. Después de algún 
tiempo su NFT debería ser visible como sigue:

![Alt text](https://www.github.com/assets.digitalocean.com/articles/alligator/boo.svg "un título")

Enhorabuena, has creado, modificado y desplegado con éxito tu primer contrato inteligente. Acuñado tu primer NFT, y 
¡publicado tu imagen en IPFS! 🔥


## Desafío ⚙️

¿Por qué no modifica su contrato inteligente para permitir a los usuarios acuñar sólo hasta un cierto número de 
NFTs? 5 por usuario debería ser suficiente, ¡o alguien podría empezar a acuñar miles de NFTs!

Para ello, busca en el tipo de mapeo, aquí hay una guía increíble para guiarte.

Para ganar un NFT de Prueba de Conocimiento, completa el desafío anterior y luego comparte una reflexión en 
el Discord Server de Alchemy University en el canal de envío #prueba-de-conocimiento

¿Quieres la versión en vídeo de este tutorial? Suscríbete al canal de YouTube de Alchemy y únete a nuestra comunidad de Discord 
donde encontrarás miles de desarrolladores dispuestos a ayudarte.

Siempre buscamos mejorar este viaje de aprendizaje, ¡comparte con nosotros cualquier comentario que tengas! En 
puedes tuitear a la comunidad etiquetando a @AlchemyLearn, o puedes sugerir modificaciones a este documento haciendo clic en 
"Sugerir modificaciones" en la parte superior derecha.

¡Nos vemos en el próximo desafío!

## Construido con 🛠️

_Herramientas que utilizaste para desarrollar el desafio_

- [Visual Studio Code](https://code.visualstudio.com/) - El IDE
- [Alchemy](https://dashboard.alchemy.com) - Interfaz/API para la red Tesnet de Goerli
- [Xubuntu](https://xubuntu.org/) - Sistema operativo basado en la distribución Ubuntu.
- [Opensea](https://testnets.opensea.io) - Sistema web utilizado para verificar/visualizar nuestra NFT
- [Solidity](https://soliditylang.org) - Lenguaje de programación orientado a objetos para implementar smart
  inteligentes en varias plataformas blockchain.
- [OpenZeppellin Wizard](https://docs.openzeppelin.com/contracts/4.x/wizard) - siendo uno de los mayores mantenedores de 
  estándares de contratos inteligentes (ERC20, ERC721, etc), permitiendo a los desarrolladores utilizar código auditado a fondo 
  para desarrollar contratos fiables.
- [Hardhat](https://hardhat.org) - Entorno que los desarrolladores utilizan para probar, compilar, desplegar y depurar dApps
  basadas en la cadena de bloques Ethereum
- [GitHub](https://github.com/) - Servicio de alojamiento en Internet para el desarrollo de software y control de versiones 
  mediante Git.
- [Goerli Faucet](https://goerlifaucet.com/) - Faucet que se utiliza para obtener ETH y utilizarlos para desplegar 
  los Contratos Inteligentes así como para interactuar con ellos.
- [Remix](https://remix.ethereum.org/) - herramienta sin configuración con una GUI para desarrollar contratos inteligentes. 
  Utilizado por expertos y principiantes por igual, Remix te pondrá en marcha en doble tiempo. Remix funciona bien con otras 
  herramientas y permite un sencillo proceso de despliegue en la cadena de su elección. Remix es famoso por nuestro depurador 
  visual.
- [Filebase](https://filebase.com/) - Sistema Web para Almacenar datos en redes descentralizadas puede ser difícil. Filebase 
  elimina esa complejidad. Sube datos en segundos usando las herramientas que ya conoces y amas.
- [MetaMask](https://metamask.io) - MetaMask es una cartera de criptomoneda de software utilizada para interactuar con
  la blockchain Ethereum.


## Contribuir 🖇️

Por favor, lee [CONTRIBUTING.md](https://gist.github.com/llabori-venehsoftw/xxxxxx) para más detalles sobre 
nuestro código de conducta, y el proceso para enviarnos pull requests.

## Wiki 📖

N/A

## Versionado 📌

Utilizamos [GitHub] para versionar todos los archivos utilizados (https://github.com/tu/proyecto/tags).

## Autores ✒️

_Personas que colaboraron con el desarrollo del reto_.

- **VeneHsoftw** - _Trabajo Inicial_ - [venehsoftw](https://github.com/venehsoftw)
- **Luis Labori** - _Trabajo inicial_, _Documentaciónn_ - [llabori-venehsoftw](https://github.com/
llabori-venehsoftw)

## Licencia 📄

Este proyecto está licenciado bajo la Licencia (Su Licencia) - ver el archivo [LICENSE.md](LICENSE.md) 
para más detalles.

## Gratitud 🎁

- Si la información reflejada en este Repo te ha parecido de gran importancia, por favor, amplía tu 
colaboración pulsando el botón de la estrella en el margen superior derecho. 📢
- Si está dentro de sus posibilidades, puede ampliar su donación a través de la siguiente dirección: 
`0xAeC4F555DbdE299ee034Ca6F42B83Baf8eFA6f0D`

---

⌨️ con ❤️ por [Venehsoftw](https://github.com/llabori-venehsoftw) 😊
