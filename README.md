# Repel the turtles

Este proyecto tiene como objetivo desarrollar un proyecto que utilice shaders

## Características

- Se utiliza un ruido de [voronoi](https://es.wikipedia.org/wiki/Pol%C3%ADgonos_de_Thiessen#:~:text=Estos%20objetos%20tambi%C3%A9n%20fueron%20estudiados,nombre%20de%20Teselaci%C3%B3n%20de%20Dirichlet.) para representar la forma y el movimiento del agua
- Se producen ondas en el agua para ahuyentar a las tortugas

## Decisiones

##### Tortugas

- Se calcula la distancia entre la tortuga y el centro de la onda para saber si chocan.
    - Si chocan se calcula cual será la nueva rotación de la tortuga y cual será su movimiento 
- Las tortugas las eliminaremos totalmente de la ejecución cuando salga de los siguientes límites:
    - Posición en X menor que -width/5
    - Posición en X mayor que width*1.5 
    - Posición en Y menor que -height/5
    - Posición en Y mayor que height*1.5

##### Intro
- Se da un mensaje inicial que informa del objetivo de la aplicación (desaparecerá después de 6 segundos).

##### Onda
- Tiene una aplitud máxima de 20.
- Cuando se hace click con el ratón la onda aumentará su tamaño desde 0 hasta 20, con un incremento de 0.2 cada iteración.
- Cuando se acerque a su amplitud máxima irá desapareciendo progresivamente.

## Gif resultado

![](TurtlesGif.gif)

## Base

Para realizar esta implementación se ha tenido en cuenta, entre otras fuentes, la implementación de Voronoi que existe en la herramienta Unity (más concretamente dentro de la función de Shader Graph).

- [Nodo Voronoi](https://docs.unity3d.com/Packages/com.unity.shadergraph@6.9/manual/Voronoi-Node.html)


## Herramientas utilizadas
- [Processing](https://processing.org/)
- [Editor del shader](https://thebookofshaders.com/edit.php)
- [Editor readme.md](https://dillinger.io/)

Realizado por [José Juan Reyes Cabrera](https://github.com/JoseJuanRC)
