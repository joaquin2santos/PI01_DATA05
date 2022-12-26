<p align=center><img src=https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png><p>

# <h1 align=center> **PROYECTO INDIVIDUAL Nº1** </h1>

# <h1 align=center>**`Data Engineering`**</h1>

<p align="center">
<img src="https://files.realpython.com/media/What-is-Data-Engineering_Watermarked.607e761a3c0e.jpg"  height=300>
</p>

¡Bienvenidos a mi primer proyecto en el  rol de un ***Data Engineer***.  

<hr>  

## **Introducción**

La idea de este proyecto es lograr internalizar los conocimientos requeridos para la elaboración y ejecución de una API.
 ¿ Que es una API?

`Application Programming Interface` es una interfaz que permite que dos aplicaciones se comuniquen entre sí, independientemente de la infraestructura subyacente. Son herramientas muy versátiles y fundamentales para la creación de, por ejemplo, pipelines, ya que permiten mover y brindar acceso simple a los datos que se quieran disponibilizar a través de los diferentes endpoints, o puntos de salida de la API.

Hoy en día contamos con **FastAPI**, un web framework moderno y de alto rendimiento para construir APIs con Python.
<p align=center>
<img src = 'https://i.ibb.co/9t3dD7D/blog-zenvia-imagens-3.png' height=250><p>

## **Propuesta de trabajo**

El proyecto consiste en realizar una ingesta de datos desde diversas fuentes, posteriormente aplicar las transformaciones que  se considere pertinentes, y luego disponibilizar los datos limpios para su consulta a través de una API. Esta API deberán construirla en un entorno virtual dockerizado.

Los datos serán provistos en archivos de diferentes extensiones, como *csv* o *json*. Se espera que realicen un EDA para cada dataset y corrijan los tipos de datos, valores nulos y duplicados, entre otras tareas. Posteriormente, tendrán que relacionar los datasets así pueden acceder a su información por medio de consultas a la API.

Las consultas a realizar son:

+ Máxima duración según tipo de film (película/serie), por plataforma y por año:
    El request debe ser: get_max_duration(año, plataforma, [min o season])

+ Cantidad de películas y series (separado) por plataforma
    El request debe ser: get_count_plataform(plataforma)  
  
+ Cantidad de veces que se repite un género y plataforma con mayor frecuencia del mismo.
    El request debe ser: get_listedin('genero')  
    Como ejemplo de género pueden usar 'comedy', el cuál deberia devolverles un cunt de 2099 para la plataforma de amazon.

+ Actor que más se repite según plataforma y año.
  El request debe ser: get_actor(plataforma, año)

## **Pasos del proyecto**

1. Ingesta y normalización de datos

2. Relacionar el conjunto de datos y crear la tabla necesaria para realizar consultas. Aquí se recomienda corroborar qué datos necesitarán en base a las consultas a realizar y concatenar las 4 tablas

3. Leer documentación en links provistos e indagar sobre Uvicorn, FastAPI y Docker

4. Crear la API en un entorno Docker → leer documentación en links provistos

5. Realizar consultas solicitadas

6. Realizar un video demostrativo

 

<p align=center>
<img src = 'https://i.postimg.cc/2SwvnTcw/Sin-t-tulo.png' height = 400></p>

## **Criterios del tranbajo**

**`Código`**:

+ Prolijidad de código 

+ Uso de clases y/o funciones, en caso de ser necesario

+ Código comentado

**`Repositorio`**:

+ Nombres de archivo adecuados

+ Uso de carpetas para ordenar los archivos

+ README.md presentando el proyecto y el trabajo realizado

**Fuente de datos**

+ Podrán encontrar los archivos con datos en la carpeta Datasets, en este mismo repositorio.

** Trabajo realizado**
En este trabajo pude aplicar gran parte de los conocimientos trabajados durante el bootcamp,ya puedo decir que fue todo un desafio hasta el momento sobretodo por el hecho de tener que tomar decisiones fundamentadas en cada etapa del proyecto. 
Los pasos fueron en un primer momento disponibilizar los archivos y sus formatos para la ingesta en la que use python con el framework pandas para transformar de formato json a csv. Al tener los 4 datasets en el mismo formato los ingrese en sql en tablas individuales, comprobe los duplicados y luego los uni en una tabla unica. 
En un segundo momento comence con la limpieza, dandome cuenta que la columna rating contenia valores de duracion, por lo tanto arme una nueva columna donde inserte estos valores, para luego agregar los valores numericos de la columna duration, en formato string. Una vez hecho esto transforme y reemplace la columnaduracion ya con valores int. 
El proximo paso fue intentar responder una de las querys, dandome cuenta que con una nueva columna para el type podria filtrar mejor a la hora de la consulta. 
Por ultimo probe las querys en sql y comence a levantar la api, cosa que al principio se hizo cuesta arriba pero con la ayuda de la comunidad llego a buen puerto. 
En este momento quedaria pendiente levantar la imagen de docker pero por seguridad voy a hacer una entrega parcial, y en caso de llegar actualizare el repo. 
 
<p align=center>
<img src = 'https://cdn.memegenerator.es/imagenes/memes/full/0/90/902781.jpg' height = 300></p>
