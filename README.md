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
4. Para iniciar el proyecto hay que ejecutar los siguientes comando en la consola de comando (Recuerda que debes seguir en la carpeta del proyecto)
```
# Para mostrar los dispositivos conectados
flutter devices
# Los dispositivos aparecen a forma de tabla, el que vamos a necesitar es el de la segunda columna que es el **id**.
flutter run -d [device-id]
```

Con estos simples pasos se puede ejecutar la aplicación de forma local.

## Estructura

### Código

Para la estructura del código me base en una aplicación de *Material* y bloc para gestionar el estado de la aplicación.
La aplicación esta dividida en carpetas siguiendo la siguiente estructura:

- **theme:** Esta carpeta contiene la clase donde se define la clase del tema junto al archivo de colores que obtuve de la herramienta de [Material Theme Builder](https://m3.material.io/theme-builder)
- **bloc:** En esta carpeta esta la implementación del gestor de estado.
- **config:** Alberga los datos de configuración y las variables de entorno.
- **helpers:** Contiene los códigos de apoyo para la aplicación, en este proyecto solo contiene el **delegate** del buscador.
- **models:** Aquí se albergan los modelos para los datos, un ejemplo de es el modelo de la respuesta que se recibe de la api que es utilizada para convertir el texto de respuesta en un objeto.
- **router:** Esta carpeta contiene una clase que contiene los datos necesarios para implementar el router de la aplicación.
- **screens:** Aquí se encuentra los widgets que se utilizan para las pantallas de la aplicación.
- **services:** En esta carpeta se encuentra la clase que consume la API de Rick & Morty.
- **widgets:** Por ultimo esta la carpeta que contiene los widgets creados para la aplicación.

### Librerías

- **animate_do**: Librería de apoyo para implementar animaciones sencillas
- **bloc**: Gestor de estados.
- **equatable**: Librería para facilitar la comparación de estados. 
- **flutter_bloc**: Librería para implementar bloc en una aplicación de flutter.
- **http**: Librería para realizar peticiones http.

### Diseño

Para el diseño de la aplicación opte por cambiar la lista de elementos por una vista de grid en la pantalla de inicio, esta presentación me dio la impresión de que generaría una mejor experiencia de usuario.

Al darle clic a alguno de los elementos la aplicación navega a la pagina del personaje, esta pagina muestra en vista grande la imagen del personaje asi como la información del personaje que brinda la aplicación.

Por ultimo en la pagina de búsqueda se reutilizan los mismos widgets de la pagina de inicio para mostrar la lista de los personajes.

Y como valor agregado se utilizo la librería de [animate_do](https://pub.dev/packages/animate_do) para implementar las animaciones de entrada mas sencillas y la animación de Hero para la transición a la pagina de detalles.