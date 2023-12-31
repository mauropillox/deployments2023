**Obligatorio Implementación de Soluciones Cloud** 	 

Marcos Posnanski 213303 - Mauro Guimarans 212473

![image](https://github.com/mauropillox/deployments2023/assets/51933362/801e59f8-1d0f-4f55-b790-75f0a2c49abe)


# INDICE

[DECLARACION DE AUTORIA	](#_toc138673087)

[ALCANCE	](#_toc138673088)

[ESQUEMA ACTUAL	](#_toc138673089)

[Necesidad del cliente:	](#_toc138673090)

[Arquitectura actual:	](#_toc138673091)

[Oportunidades de Mejora	](#_toc138673092)

[PROPUESTA	](#_toc138673093)

[Infraestructura en la Cloud	](#_toc138673094)

[Solución propuesta	](#_toc138673095)

[Kubernetes como Servicio (EKS)	](#_toc138673096)

[RECURSOS ](#_toc138673097)

[Datos de Infraestructura	](#_toc138673098)

[Servicios de AWS Utilizados	](#_toc138673099)

[Variables para las instancias EC2	](#_toc138673100)

[Variables para la base de datos RDS	](#_toc138673101)

[Variables para los grupos de seguridad	](#_toc138673102)

[LIMITACIONES Y DESAFIOS	](#_toc138673103)

[Utilización del sistema operativo	](#_toc138673104)

[Seguridad de la solución	](#_toc138673105)

[Permisos y usuarios para el despliegue EC2	](#_toc138673106)

[Uso de REDIS	](#_toc138673107)

[REFERENCIAS	](#_toc138673108)









# <a name="_toc138673087"></a>DECLARACION DE AUTORIA 
Nosotros, Marcos Posnanski, número de estudiante 213303 y Mauro Guimarans, número de estudiante 212473, estudiantes de “Analista en Infraestructura informática”, facultad de ingeniería ORT, por medio de este documento, entregamos la presente investigación “implementación de Soluciones Cloud, Obligatorio” del cual nos responsabilizamos por ser los autores de este. Montevideo, junio 2023
# <a name="_toc138673088"></a>ALCANCE 
En este documento se contemplan aspectos de Análisis e Investigación sobre los beneficios a migrar a la cloud, costos, modelos de servicios recomendados y diagramas de arquitectura. 

Se presenta una solución que permite el despliegue automático de toda la arquitectura necesaria en la Cloud, esta solución presenta innovación, vanguardia tecnológica, performance, y continuidad del negocio. 

Se explican también en detalle y fundamentan los diseños, arquitectura y configuración de cada módulo relevante.

# <a name="_toc138673089"></a>ESQUEMA ACTUAL

<a name="_toc138673090"></a>**Necesidad del cliente:**

La startup “e-shop Services” ha recibido una ronda de inversión para expandir sus operaciones por todo el mundo, haciendo llegar sus servicios de e-commerce y retail, a todo el continente de América. 

La competencia actualmente está posicionada en la región a la cual se quiere expandir, pero los inversionistas están presionando para que “e-shop Services” expanda su marca ya que de esto depende el seguir invirtiendo. 

Se ha contratado a la consultora BitBeat para modernizar y desplegar la arquitectura e infraestructura de su aplicación que actualmente corre en un datacenter on-premise. Una célula de desarrollo trabajó en la implementación del e-commerce basado en una arquitectura de microservicios para correr sobre containers cuyo ciclo de integración continua ya se encuentra configurado y la solución ya se encuentra disponible para desplegar por parte del equipo de DevOps.

<a name="_toc138673091"></a>**Arquitectura a migrar:**

![image](https://github.com/mauropillox/deployments2023/assets/51933362/04fe330c-edb8-4390-832c-49ee65f3484b)


- Un RP para publicar la aplicación 
- Dos servidores Web para el Frontend - Un Servidor web para el control de stock
- Un servidor web para el carrito de compras 
- Un servidor web para el catálogo 
- Una base de datos relacional
- Un servidor donde se almacenan documentos estáticos 
- Una base de datos clave-valor 
- Servicios de Cache

<a name="_toc138673092"></a>**Oportunidades de Mejora**

Se detectan diversas oportunidades de mejora, las cuales se basan en la modernización de la tecnologia en infraestructura, que acompañe el crecimiento del negocio y la escalabilidad a corto/mediano plazo que se presente. 

Entendemos que el mejor escenario es utilizar capacidad de cómputo en la nube, el cual detallaremos a continuación.

El siguiente análisis e investigación contempla los siguientes puntos: 

- Consumo bajo demanda / Auto-scaling 
- Automatización de los despliegues 
- Alta disponibilidad 
- Recuperación ante desastres 
- Enfoque y prácticas DevOps 

# <a name="_toc138673093"></a>PROPUESTA
<a name="_toc138673094"></a>**Infraestructura en la Cloud**

Proponemos crear recursos en AWS, dado que es el líder del mercado, se encuentra la mayor documentación, aportes en la comunidad, innovación en productos y cantidad de servicios.

- AWS ha sido constantemente aclamado como el proveedor líder en el Cuadrante Mágico de Gartner
- Un estudio del sector muestra que Amazon tiene una mayor cuota de mercado en la nube que Azure
- AWS ofrece más productos y servicios en la nube que Azure
- La red de la nube de Amazon es más grande, con más puntos de presencia en todo el mundo
- AWS es más barato que Azure en cuanto a precios de computación, que constituye la columna vertebral de las implementaciones en la nube

Cuadrante de Gartner (junio 2022) 

![gartner](https://github.com/mauropillox/deployments2023/assets/51933362/1225219d-d06b-4118-9b21-6a87be338431)


<a name="_toc138673095"></a>**Infraestructura propuesta**

Para el despliegue de toda la solución se utilizan recursos de AWS explicados más en detalle en el apartado “Recursos”. De esta forma automatizaremos el despliegue de la aplicación con el uso de Terraform. 

El esquema de recursos en IaaS en AWS es el siguiente:

![infra](https://github.com/mauropillox/deployments2023/assets/51933362/8bdfcb91-4bdb-4130-8723-47f321827d79)


Se crea una instancia EC2 T2.micro la cual pertenece a un grupo de autoescalado, con un máximo de 2 instancias deseadas, de esta forma nos aseguramos la cantidad de instancias activas bajo cualquier problema que afecte la disponibilidad. 

Se despliega Redis utilizando el servicio de Amazon ElastiCache. En este caso, ElastiCache se encarga de administrar y escalar automáticamente el clúster de Redis.

Estas instancias están debajo de un Elastic Load Balancer para balancear tráfico a los diferentes targets, agrupadas en 2 zonas de disponibilidad dentro de la misma región. 

Estos recursos se encuentran bajo una VPC, en la cual se encuentran 4 subnet, 2 públicas y 2 privadas. Para fortalecer la seguridad y la alta disponibilidad, se implementa una VPN NAT Gateway, este recurso nos permita el acceso seguro a otros recursos de la nube AWS. 

Desde estas instancias se crea un link a un Bucket S3. Este Bucket está pensado para almacenar eventualmente recursos que sean necesarios. 

<a name="_toc138673096"></a>**Kubernetes como Servicio (EKS)**

Se deben desplegar un total de 11 microservicios. Estos microservicios se deben desplegar en el siguiente orden debido a sus dependencias:

![Untitled (2)](https://github.com/mauropillox/deployments2023/assets/51933362/984cda0b-2938-4f38-a868-e3fed4ffce8b)




Para esta solución, decidimos desplegar un cluster de Kubernetes como servicio, haciendo uso de las 2 instancias EC2 como nodos de trabajo. 

Cada uno de esos microservicios se despliega en un pod, habiendo 11 en total, esto nos permite obtener un entorno aislado para la ejecución de aplicaciones. Proporcionando una infraestructura flexible y escalable para ejecutar y mantener las aplicaciones en la nube.

La aplicación será dockerizada de forma customizada con dockerfile, creando un build de la imagen y guardándola en un docker hub, a este se accede y se ejecuta directamente en el despliegue de la instancia.


En cada uno de estos nodos, además de los pods, se pueden crear Persistent Volume Claims (PVC) en una VPC. Estos PVC permiten que los pods accedan a volúmenes de almacenamiento independientes de la vida útil del pod. Si un pod falla o se reinicia, el PVC puede volver a reclamar el mismo almacenamiento persistente. Los PVC hacen referencia a un AWS Storage Class, el cual proporciona una abstracción de nivel superior para la administración del almacenamiento.

![pods](https://github.com/mauropillox/deployments2023/assets/51933362/89813021-0aa2-4997-a0f6-814d8988d65b)

Se realiza el despliegue:

![WhatsApp Image 2023-06-27 at 12 23 13](https://github.com/mauropillox/deployments2023/assets/51933362/54810148-be06-4db2-b839-b1ef06f539ca)



Una vez finalizado el despliegue quedara accesible la página con todas sus funcionalidades:

![Untitled (1)](https://github.com/mauropillox/deployments2023/assets/51933362/00caf56d-cef3-436f-aa0c-6be0ad534739)




Vemos que no solamente se despliega la pagina web, sino que también todos los servicios correspondientes para su correcto funcionamiento. Validamos esto agregando productos al carrito de compras y también finalizando la misma. 

# <a name="_toc138673097"></a>RECURSOS

<a name="_toc138673098"></a>**Datos de Infraestructura**

- Tipo de instancia de EC2 para el frontend: t2.micro
- Tipo de instancia de EC2 para Redis: cache.t2.micro
- Motor de base de datos RDS: MySQL
- Clase de instancia de base de datos RDS: db.t2.micro
- Almacenamiento asignado para la instancia de base de datos RDS: 10 GB
- **Grupo de seguridad de la VPC:** 
  - Nombre: grupo-seguridad-ssh
  - Descripción: Security group para tráfico SSH
- **Grupo de seguridad para el balanceador de carga:** 
  - Nombre: grupo-seguridad-http
  - Descripción: Security group para tráfico HTTP
- **Grupo de seguridad para la base de datos:** 
  - Nombre: grupo-seguridad-db
  - Descripción: Security group para la base de datos RDS
- **Grupo de seguridad para Redis:** 
  - Nombre: obligatorio-redis-sg
  - Descripción: Security group para Redis
- **Grupo de seguridad para el acceso a S3:** 
  - Nombre: grupo-seguridad-s3-access
  - Descripción: Security group para acceso al bucket de S3















<a name="_toc138673099"></a>**Servicios de AWS Utilizados**
- **Amazon EC2 (Elastic Compute Cloud):** Se utilizan instancias de Amazon EC2 para implementar los diferentes servicios del sistema, como el frontend, Redis, cartservice, adservice, currencyservice, emailservice, paymentservice, productcatalogservice, recommendationservice, checkoutservice, loadgenerator y shippingservice. Estas instancias proporcionan capacidad computacional escalable y flexible en la nube.
- **Amazon RDS (Relational Database Service):** Se utiliza Amazon RDS para implementar la base de datos relacional con el motor de base de datos MySQL. Amazon RDS simplifica la administración de bases de datos al encargarse de tareas como el aprovisionamiento, la copia de seguridad, la escalabilidad y las actualizaciones del motor de base de datos.
- **Amazon ElastiCache:** Se utiliza Amazon ElastiCache para implementar el caché de Redis con instancias de tipo cache.t2.micro. ElastiCache permite mejorar el rendimiento de las aplicaciones al almacenar en caché datos frecuentemente utilizados, reduciendo así las solicitudes a la base de datos.
- **Amazon S3 (Simple Storage Service):** Se utiliza Amazon S3 para implementar el bucket de almacenamiento. Amazon S3 proporciona un almacenamiento seguro, duradero y altamente escalable para los archivos y objetos del sistema.
- **Elastic Load Balancer:** Se utiliza Elastic Load Balancer para distribuir el tráfico entre las instancias de EC2. Esto ayuda a mejorar la disponibilidad y el rendimiento del sistema al distribuir la carga de manera equitativa entre las instancias.
- **Application Load Balancer (ALB):** Se utiliza el servicio Application Load Balancer para distribuir el tráfico de red de manera eficiente entre las instancias. El ALB proporciona capacidades avanzadas de enrutamiento y permite configurar reglas para dirigir el tráfico a diferentes servicios o rutas según las necesidades de la aplicación.
- **NAT Gateway:** Se utiliza el servicio NAT Gateway para permitir que las instancias privadas en la red VPC se comuniquen de forma segura con Internet. El NAT Gateway actúa como un punto de salida para el tráfico saliente de las instancias privadas.
- **Grupos de seguridad (Security Groups):** Se utilizan los grupos de seguridad de Amazon EC2 para controlar el tráfico de red entrante y saliente para las instancias de EC2 y otros servicios de AWS. Los grupos de seguridad permiten definir reglas de firewall a nivel de instancia para proteger los recursos y restringir el acceso no autorizado.
- **Amazon VPC (Virtual Private Cloud):** se utiliza Amazon VPC para crear y administrar la red virtual del sistema. Las subredes públicas y privadas se implementan dentro de la VPC para separar y organizar los recursos, permitiendo la conectividad desde Internet en las subredes públicas y aislamiento en las subredes privadas.
  
<a name="_toc138673100"></a>**Variables para las instancias EC2**

frontend\_instance\_type = "t2.micro"

redis\_instance\_type = "cache.t2.micro"

<a name="_toc138673101"></a>**Variables para la base de datos RDS**

rds\_engine = "mysql"

rds\_instance\_class = "db.t2.micro"

rds\_allocated\_storage = 10

<a name="_toc138673102"></a>**Variables para los grupos de seguridad**

vpc\_security\_group = "grupo-seguridad-ssh"

lb\_security\_group = "grupo-seguridad-http"

db\_security\_group = "grupo-seguridad-db"

redis\_security\_group = "obligatorio-redis-sg"

s3\_security\_group = "grupo-seguridad-s3-access"








<a name="_toc138673102"></a>**Variables para File System**

variable "ebs_volume_size" {
  description = "Size of the EBS volume in GB"
  type        = number
}
 el valor es 50







<a name="_toc138673102"></a>**Variables para el nombre de los recursos**

lb\_name = "obligatorio-lb"

frontend\_instance\_name = "obligatorio\_frontend"

redis\_instance\_name = "Redis"

cartservice\_instance\_name = "Cartservice"

adservice\_instance\_name = "Adservice"

currencyservice\_instance\_name = "Currencyservice"

emailservice\_instance\_name = "Emailservice"

paymentservice\_instance\_name = "Paymentservice"

productcatalogservice\_instance\_name = "Productcatalogservice"

recommendationservice\_instance\_name = "Recommendationservice"

checkoutservice\_instance\_name = "Checkoutservice"

loadgenerator\_instance\_name = "Loadgenerator"

frontend\_instance\_name = "Frontend"

shippingservice\_instance\_name = "Shippingservice"

db\_instance\_name = "obligatorio-database"

redis\_instance\_name = "obligatorio-redis-instance"

s3\_bucket\_name = "obligatorio1"


#











# <a name="_toc138673103"></a>LIMITACIONES Y DESAFIOS 

A lo largo del despliegue para esta tarea nos encontramos con diversos desafíos que nos parecen importantes remarcar a continuación: 

<a name="_toc138673104"></a>**Utilización del sistema operativo**

Ambos estudiantes utilizamos y estamos más familiarizados con Windows como sistema operativo base, no solo a nivel personal sino también a nivel laboral. Windows tiene algunas limitantes que al inicio tuvimos que sortear para poder acceder a la VPC y conectarlas con nuestro Visual Studio. Terminamos resolviendo estas limitantes haciendo uso de Ubuntu virtualizado desde nuestros sistemas operativos raíz. 

<a name="_toc138673105"></a>**Seguridad de la solución** 

Al desplegar las subnets, tuvimos que agregar un servicio de internet NAT Gateway para poder aumentar la seguridad de la solución.

<a name="_toc138673106"></a>**Permisos y usuarios para el despliegue EC2**

Un gran stopper en nuestra tarea que nos demandó un tiempo considerable resolver, fue la diferencia en con los usuarios y por ende permisos asociados a cada uno. Luego de varias horas de intentos nos dimos cuenta de que el usuario “local” desde el cual se realiza el despliegue no era el mismo que se utiliza en AWS por sí mismo. 

<a name="_toc138673107"></a>**Uso de REDIS**

No pudimos desplegar esta solución hasta la última semana, luego de clase teórica logramos despejar varias dudas que nos permitieron su correcta implementación. 












# <a name="_toc138673108"></a>REFERENCIAS

<https://developer.hashicorp.com/terraform/docs>

<https://kubernetes.io/docs/concepts/storage/storage-classes/> 

<https://azure.microsoft.com/en-us/overview/what-is-cloud-computing/> 

<https://github.com/hashicorp>

<https://aws.amazon.com/es/eks/features/> 

<https://www.gartner.com/doc/reprints?id=1-1ZDZDMTF&ct=200703&st=s>

<https://kinsta.com/es/blog/aws-vs-azure/>

<https://aws.amazon.com/blogs>


