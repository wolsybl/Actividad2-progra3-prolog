% Actividad 02 - Ejercicio 3: Grafo Dirigido Canada
% Estudiante: Wilson Andres Henao - ProgIIIG101

% Arcos dirigidos y sus costos
arco(vancouver, edmonton, 16).  arco(vancouver, calgary, 13).
arco(edmonton, saskatoon, 12).  arco(calgary, edmonton, 4).
arco(calgary, regina, 14).      arco(saskatoon, calgary, 9).
arco(saskatoon, winnipeg, 20).  arco(regina, saskatoon, 7).
arco(regina, winnipeg, 4).

% Regla C: Verificar si un nodo tiene aristas salientes
tiene_aristas(Nodo) :- arco(Nodo, _, _).

% Regla D: Calcular costo para ir de X a Z pasando por Y
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

% Consultas de prueba:
% a) ?- camino_dirigido(saskatoon, vancouver, Ruta, Costo).
% b) ?- arco(regina, Destino, Costo).
% c) ?- tiene_aristas(vancouver).
% d) ?- costo_via_intermedio(vancouver, edmonton, saskatoon, Costo).
% e) ?- camino_dirigido(edmonton, calgary, Ruta, Costo).