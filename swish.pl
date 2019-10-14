rota("Anchieta", "Romelândia", 21.8).
rota("Anchieta", "Guaraciaba", 30.2).
rota("Anchieta", "Palma Sola", 25.7).
rota("Bandeirante", "São Miguel do Oeste", 15.5).
rota("Barra Bonita", "Romelândia", 28.8).
rota("Barra Bonita", "São Miguel do Oeste", 23.9).
rota("Belmonte", "Descanso", 9.5).
rota("Belmonte", "Santa Helena", 14).
rota("Descanso", "São Miguel do Oeste", 13).
rota("Descanso", "Iporã do Oeste", 23).
rota("Dionísio Cerqueira", "Guarujá do Sul", 23).
rota("Dionísio Cerqueira", "Palma Sola", 50).
rota("Guaraciaba", "São Miguel do Oeste", 15).
rota("Guaraciaba", "São José do Cedro", 20).
rota("Guarujá do Sul", "São José do Cedro", 7.5).
rota("Iporã do Oeste", "Tunápolis", 13.6).
rota("Iporã do Oeste", "Mondaí", 23.8).
rota("Iporã do Oeste", "São João do Oeste", 18.8).
rota("Iporã do Oeste", "Itapiranga", 33.8).
rota("Itapiranga", "São João do Oeste", 27.2).
rota("Itapiranga", "Tunápolis", 32.6).
rota("Itapiranga", "Mondaí", 47.3).
rota("Riqueza", "Mondaí", 10.5).
rota("Princesa", "São José do Cedro", 11.4).
rota("Romelândia", "São Miguel do Oeste", 45.6).
rota("Romelândia", "Descanso", 48.6).
rota("Santa Helena", "Tunápolis", 5.6).
rota("São Miguel do Oeste", "Paraíso", 23.6).
rota("São João do Oeste", "Tunápolis", 20.9).
rota("São José do Cedro", "Anchieta", 39.7).

% Criação da rota ente origem e destino
menor_rota(ORIGEM, DESTINO, MENOR_ROTA) :- encontrar_rota(DESTINO, [0, ORIGEM], ROTA),
ordenar(ROTA, [], MENOR_ROTA).

% Encurtando o caminho entre os postos e somando as distancias
encontrar_rota(DESTINO, [DISTANCIA, DESTINO | POSTOS], [DISTANCIA, DESTINO | POSTOS]) :- !.
encontrar_rota(DESTINO, [DISTANCIA_ANTERIOR, POSTO_ATUAL | POSTOS], ROTA) :-
conectados(POSTO_ATUAL, PROX_POSTO, DISTANCIA_ATUAL_PROX),
\+member(PROX_POSTO, POSTOS),
DISTANCIA_FINAL is DISTANCIA_ANTERIOR + DISTANCIA_ATUAL_PROX,
encontrar_rota(DESTINO, [DISTANCIA_FINAL, PROX_POSTO, POSTO_ATUAL | POSTOS], ROTA).

% Regra que indica se os postos estão conectados
conectados(CIDADE_ORIGEM, CIDADE_DESTINO, DISTANCIA) :- rota(CIDADE_ORIGEM, CIDADE_DESTINO, DISTANCIA).
conectados(CIDADE_ORIGEM, CIDADE_DESTINO, DISTANCIA) :- rota(CIDADE_DESTINO, CIDADE_ORIGEM, DISTANCIA).

% Inverte a ordem da lista
ordenar([], LISTA, LISTA).
ordenar([TOPO | RESTANTE_LISTA], NOVA_LISTA, LISTA):-
ordenar(RESTANTE_LISTA, [TOPO | NOVA_LISTA], LISTA).

% Solicita o posto de origem
pedir_origem(POSTO_ORIGEM) :-
writeln('Posto de Origem:'),
read(POSTO_ORIGEM).

% Solicita o posto de destino
pedir_destino(POSTO_DESTINO) :- 
writeln('Posto de Destino:'),
read(POSTO_DESTINO).

% Percorre a rota e imprime os valores formatados no console.
imprimir([]) :- !. 
imprimir([TOPO|RESTANTE_LISTA]) :- 
(TOPO == [] -> write('Distância: ') ; write('')),
write(TOPO),
(RESTANTE_LISTA \== [] -> writeln(', ') ; write('')),
imprimir(RESTANTE_LISTA). 

% Inicializacao do programa, solicida postos, calcula e imprime o menor percurso
main :- 
pedir_origem(ORIGEM),
pedir_destino(DESTINO),
writeln('Menor Rota: '),
menor_rota(ORIGEM, DESTINO, MENOR_ROTA),
imprimir(MENOR_ROTA),
write('Km.').