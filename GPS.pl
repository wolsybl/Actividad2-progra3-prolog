% Actividad 02 - Ejercicio 2: Red Vial España
% Estudiante: Wilson Andres Henao - ProgIIIG101

% Datos de carreteras y distancias en km
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

% Distancia en ambas direcciones
distancia(X, Y, D) :- tramo(X, Y, D) ; tramo(Y, X, D).

% Algoritmo de busqueda de ruta evitando ciclos
ruta(Origen, Destino, Ruta, Distancia) :-
obtener_ruta(Origen, Destino, [Origen], RInvertida, Distancia),
reverse(RInvertida, Ruta).

obtener_ruta(X, X, Vis, Vis, 0).
obtener_ruta(Origen, Destino, Vis, Ruta, DTotal) :-
distancia(Origen, Inter, D1),
+ member(Inter, Vis),
obtener_ruta(Inter, Destino, [Inter|Vis], Ruta, D2),
DTotal is D1 + D2.

% Consultas:
% ?- ruta(madrid, barcelona, Ruta, Distancia).
% ?- aggregate_all(min(D, R), ruta(bilbao, sevilla, R, D), min(Dist, Ruta)).