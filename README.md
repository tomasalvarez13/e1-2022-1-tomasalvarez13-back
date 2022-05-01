# 2022-1 / IIC2173 - E0 | De cómo volvemos a hacer grupos de amigos con contactos estrechos

## Consideraciones generales
* El requisito https no fue realizado, por lo que solo se puede acceder mediante http

## Nombre del dominio
http://e0lige0.tk

## Metodo de acceso al servidor
ssh -i "e00.pem" ubuntu@ec2-18-234-104-58.compute-1.amazonaws.com

## Puntos logrados

### Requisitos funcionales (15p)

* **RF1: (5p)** ***Esencial*** Se puede crear cuentas de usuario con mail, datos de contacto, nick y contraseñas. Se puede iniciar sesión con las cuentas creadas.
* **RF2: (3p)** ***Esencial*** Un usuario debe poder registrar sus ubicaciones mediante coordenadas geográficas en la aplicación. Debe poder asignarles un nombre y verlas en una lista. 
* **RF3: (5p)** El usuario debe ser capaz de ver todas sus ubicaciones y las de otro usuario en un mapa desde su aplicación. Para esto pueden usar la API de OpenStreetMap.

### Requisitos no funcionales (15p)

* **RNF1: (3p)** Debe haber un proxy inverso (como Nginx o Traefik) configurado.
* **RNF2: (2p)** El servidor debe tener un nombre de dominio de primer nivel (tech, me, tk, ml, ga, com, cl, etc)
* **RNF3: (2p)** ***Esencial*** El servidor debe estar corriendo en EC2.
* **RNF4: (4p)** ***Esencial*** Debe haber una base de datos Postgres o Mongo externa asociada a la aplicación para guardar mensajes y consultarlos. Debe estar hosteada en otro servidor o container. Las posiciones geográficas deben ser guardadas usando PostGIS o geoJSON respectivamente. Cabe mencionar que durante la realización de la tarea, consulté por slack si era obligación usar PostGIS o geoJSON, a lo que me respondió un ayudante que no era necesario y que si lo guardaba como string no iba a hber descuento asociado.(https://arqui-software.slack.com/archives/C038H2GLGKU/p1648749414247389) Dias después dijieron que si se iba a descontar, pero lamentablemente yo ya lo habia realizado tomando en cuenta lo anterior y no pude cambiarlo por temas de tiempo. Agradecería si pudiesen tomar en cuenta esto para la corrección :)
* **RNF5: (4p)** ***Esencial*** El servicio debe estar dentro de un container Docker.

### Variables

#### Docker-Compose (25%) (15p)

Componer servicios es esencial para obtener entornos de prueba confiables, especialmente en las máquinas de los desarrolladores. Arriésguense con este fascinante desafío.

* **RNF1: (5p)** Lanzar su app desde docker-compose
* **RNF2: (5p)** Integrar db desde docker-compose
* **RNF3: (5p)** Configurar su proxy inverso desde docker-compose

#### Confirmación del correo (25%) (15p)

Al momento de crear una sesión por primera vez, deben confirmar que el usuario usó una cuenta de correo válida para evitar repeticiones. 

* **RF1: (9p)** Implementar un envío de correo electrónico hacia la cuenta especificada.
* **RF2: (6p)** Confirmación de la cuenta mediante el acceso al link que le indiquen u otro método que consideren. 

