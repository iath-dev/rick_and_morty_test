![Rick&Morty](assets/rick_and_morty.png)

# Rickster - Documentación

Esta aplicación le permite al usuario ver los personajes de la serie de Rick & Morty, esta información es proviene de una [API](https://rickandmortyapi.com/documentation) gratuita.

## Ejecución

Para ejecutar este código es necesario descomprimir el archivo del proyecto y seguir los siguientes pasos:

1. Abrir la consola de comando en la carpeta del proyecto.
2. Escribe y ejecuta el siguiente comando:
```
# Para limpiar el código, como precaución.
flutter clean
# Volver a instalar las dependencias
flutter pub get
```
3. Antes de ejecutar el proyecto hay que asegurarse de tener un dispositivo conectado o el emulador corriendo
4. Con un dispositivo conectado hay que verificar el identificador del dispositivo que se va a utilizar.
```
# Para mostrar los dispositivos conectados
flutter devices
```
5. La respuesta que se obtiene es una tabla separada por puntos, el valor que vamos a necesitar es el identificador que se encuentra en la segunda columna.
6. Con el identificador en mano se puede correr el siguiente comando para ejecutar el proyecto.
```
flutter run -d [device-id]
```

Con estos simples pasos se puede ejecutar la aplicación de forma local.

## Estructura

### Código

Para la estructura del código me base en una aplicación de *Material* y bloc para gestionar el estado de la aplicación.
La aplicación está dividida en carpetas siguiendo la siguiente estructura:

- **theme**: Esta carpeta contiene la clase donde se define la clase del tema junto al archivo de colores que obtuve de la herramienta de [Material Theme Builder](https://m3.material.io/theme-builder)
- **bloc**: En esta carpeta esta la implementación del gestor de estado.
- **config**: Alberga los datos de configuración y las variables de entorno.
- **helpers**: Contiene los códigos de apoyo para la aplicación, en este proyecto solo contiene el **delegate** del buscador.
- **models**: Aquí se albergan los modelos para los datos, un ejemplo de es el modelo de la respuesta que se recibe del api que es utilizada para convertir el texto de respuesta en un objeto.
- **router**: Esta carpeta contiene una clase que contiene los datos necesarios para implementar el router de la aplicación.
- **screens**: Aquí se encuentra los widgets que se utilizan para las pantallas de la aplicación.
- **services**: En esta carpeta se encuentra la clase que consume la API de Rick & Morty.
- **widgets**: Por último esta la carpeta que contiene los widgets creados para la aplicación.

### Librerías

- **animate_do**: Librería de apoyo para implementar animaciones sencillas
- **bloc**: Gestor de estados.
- **equatable**: Librería para facilitar la comparación de estados. 
- **flutter_bloc**: Librería para implementar bloc en una aplicación de flutter.
- **http**: Librería para realizar peticiones http.

### Diseño

Para el diseño de la aplicación opte por cambiar la lista de elementos por una vista de grid en la pantalla de inicio, esta presentación me dio la impresión de que generaría una mejor experiencia de usuario.

Al darle clic a alguno de los elementos la aplicación navega a la página del personaje, esta página muestra en vista grande la imagen del personaje, así como la información del personaje que brinda la aplicación.

Por último, en la página de búsqueda se reutilizan los mismos widgets de la página de inicio para mostrar la lista de los personajes.

Y como valor agregado se utilizó la librería de [animate_do](https://pub.dev/packages/animate_do) para implementar las animaciones de entrada más sencillas y la animación de Hero para la transición a la página de detalles.
