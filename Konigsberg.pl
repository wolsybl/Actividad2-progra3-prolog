% Actividad 02 - Ejercicio 1: Puentes de Konigsberg
% Estudiante: Wilson Andres Henao - ProgIIIG101

% Puentes entre sectores
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

% Búsqueda de recorrido euleriano sin repetir puentes
camino_euleriano(Inicio, Inicio, Usados, Total, []) :-
length(Usados, Total).
camino_euleriano(Actual, Fin, Usados, Total, [P|Resto]) :-
conecta(Actual, Sig, P),
+ member(P, Usados),
camino_euleriano(Sig, Fin, [P|Usados], Total, Resto).

% Consulta:
% ?- camino_euleriano(a, a, [], 7, Solucion).