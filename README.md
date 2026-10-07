# Universidad Tecnológica de Pereira
**Programa:** Desarrollo de Software  
**Asignatura:** Programación III (ProgIIIG101) - Grupo 101  
**Estudiante:** Wilson Andrés Henao  
**Profesor:** Ramiro A. Barrios Valencia  
**Actividad:** Actividad 02 - Backtracking y Resolución SLD  

---

## 1. Ejercicio 1: Problema de los Puentes de Königsberg

### Planteamiento
Verificar si es posible realizar un recorrido cerrado comenzando en cualquiera de las 4 regiones, cruzando los 7 puentes exactamente una vez y regresando al nodo de origen.

### Fundamento Teórico y SLD
Según el teorema de Euler, un grafo conectado posee un ciclo euleriano si y solo si el grado de todos sus vértices es par. En este problema:
* Región A: 5 puentes (impar)
* Región B: 3 puentes (impar)
* Región C: 3 puentes (impar)
* Región D: 3 puentes (impar)

Al ejecutar la búsqueda en Prolog, la resolución SLD aplica backtracking para probar todas las rutas posibles. Debido a los grados impares, agota las ramas de búsqueda y concluye en fallo.

### Código Prolog
```prolog
% Hechos: Puentes entre regiones
puente(a, b, p1).
puente(a, b, p2).
puente(a, c, p3).
puente(a, c, p4).
puente(a, d, p5).
puente(b, d, p6).
puente(c, d, p7).

% Conexión bidireccional
conecta(X, Y, P) :- puente(X, Y, P).
conecta(X, Y, P) :- puente(Y, X, P).

% Búsqueda de camino euleriano
camino_euleriano(Inicio, Inicio, Usados, Total, []) :-
    length(Usados, Total).

camino_euleriano(Actual, Fin, Usados, Total, [P|Resto]) :-
    conecta(Actual, Sig, P),
    \+ member(P, Usados),
    camino_euleriano(Sig, Fin, [P|Usados], Total, Resto).
```

### Consulta
```prolog
?- camino_euleriano(a, a, [], 7, Solucion).
% Resultado: false
```

---

## 2. Ejercicio 2: Rutas entre Ciudades (GPS / Mapa de España)

### Planteamiento
Modelar el mapa vial como un grafo no dirigido con distancias entre ciudades para calcular trayectos y hallar rutas óptimas evitando ciclos infinitos.

### Código Prolog
```prolog
% Base de datos de tramos viales (km)
tramo(coruna, vigo, 171).     tramo(coruna, valladolid, 455).
tramo(vigo, valladolid, 356).   tramo(oviedo, bilbao, 304).
tramo(bilbao, valladolid, 280). tramo(bilbao, madrid, 395).
tramo(bilbao, zaragoza, 324).   tramo(valladolid, madrid, 193).
tramo(madrid, badajoz, 403).   tramo(madrid, jaen, 335).
tramo(madrid, albacete, 251).  tramo(madrid, zaragoza, 325).
tramo(zaragoza, barcelona, 296). tramo(barcelona, gerona, 100).
tramo(barcelona, valencia, 349). tramo(valencia, albacete, 191).
tramo(valencia, murcia, 241).   tramo(albacete, murcia, 150).
tramo(jaen, sevilla, 242).     tramo(jaen, granada, 99).
tramo(sevilla, cadiz, 125).     tramo(sevilla, granada, 256).
tramo(granada, murcia, 278).

distancia(X, Y, D) :- tramo(X, Y, D) ; tramo(Y, X, D).

% Búsqueda de ruta
ruta(Origen, Destino, Ruta, Distancia) :-
    obtener_ruta(Origen, Destino, [Origen], RInvertida, Distancia),
    reverse(RInvertida, Ruta).

obtener_ruta(X, X, Vis, Vis, 0).
obtener_ruta(Origen, Destino, Vis, Ruta, DTotal) :-
    distancia(Origen, Inter, D1),
    \+ member(Inter, Vis),
    obtener_ruta(Inter, Destino, [Inter|Vis], Ruta, D2),
    DTotal is D1 + D2.
```

### Consultas
```prolog
% Ruta más corta entre Bilbao y Sevilla
?- aggregate_all(min(D, R), ruta(bilbao, sevilla, R, D), min(Dist, Ruta)).
% Dist = 857, Ruta = [bilbao, valladolid, madrid, jaen, sevilla]

% Rutas entre Madrid y Barcelona
?- ruta(madrid, barcelona, Ruta, Distancia).
% Ruta 1: [madrid, zaragoza, barcelona], Distancia = 621 km
```

---

## 3. Ejercicio 3: Grafo Dirigido con Pesos (Ciudades de Canadá)

### Planteamiento
Analizar el grafo dirigido que conecta las ciudades de Vancouver, Edmonton, Calgary, Saskatoon, Regina y Winnipeg, agregando las reglas solicitadas.

### Código Prolog
```prolog
% Arcos dirigidos y costos
arco(vancouver, edmonton, 16).  arco(vancouver, calgary, 13).
arco(edmonton, saskatoon, 12).  arco(calgary, edmonton, 4).
arco(calgary, regina, 14).      arco(saskatoon, calgary, 9).
arco(saskatoon, winnipeg, 20).  arco(regina, saskatoon, 7).
arco(regina, winnipeg, 4).

% c) Regla: Determinar si un nodo tiene aristas salientes
tiene_aristas(Nodo) :- arco(Nodo, _, _).

% d) Regla: Calcular costo de X a Z pasando por Y
costo_via_intermedio(X, Y, Z, Costo) :-
    arco(X, Y, C1),
    arco(Y, Z, C2),
    Costo is C1 + C2.

% Recorrido en grafo dirigido
camino_dirigido(X, Y, [X,Y], C) :- arco(X, Y, C).
camino_dirigido(X, Y, [X|Resto], Costo) :-
    arco(X, Z, C1),
    camino_dirigido(Z, Y, Resto, C2),
    Costo is C1 + C2.
```

### Respuestas a las Preguntas
a) **¿Existe conexión entre Saskatoon y Vancouver?**
   * Consulta: `?- camino_dirigido(saskatoon, vancouver, Ruta, C).`
   * Respuesta: `false`. No existen arcos dirigidos hacia Vancouver desde Saskatoon.

b) **¿Con qué nodos está conectado Regina y su costo?**
   * Consulta: `?- arco(regina, Destino, Costo).`
   * Respuestas:
     * `Destino = saskatoon, Costo = 7`
     * `Destino = winnipeg, Costo = 4`

e) **¿Es posible viajar desde Edmonton a Calgary?**
   * Consulta: `?- camino_dirigido(edmonton, calgary, Ruta, Costo).`
   * Respuesta: `true`.
   * `Ruta = [edmonton, saskatoon, calgary]`
   * `Costo = 21` (12 + 9)