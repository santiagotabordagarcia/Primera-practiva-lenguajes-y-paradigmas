:- initialization(main).

main :-
    write('Ingrese el codigo(Con un punto al final): '),
    read(Codigo),

    (
        caracteristicas(Codigo, Periodo, Categoria, Consecutivo, Paridad) ->
        
            write(Periodo),
            write(' '),
            write(Categoria),
            write(' num'),
            write(Consecutivo),
            write(' '),
            writeln(Paridad)

        ;

        writeln('Codigo invalido')
    ),

    halt.
    
    
 caracteristicas(Codigo, Periodo, Categoria, Consecutivo, Paridad) :-
    
    validar_codigo(Codigo),

    obtener_periodo(Codigo, PeriodoNum),
    convertir_periodo(PeriodoNum, Periodo),

    obtener_categoria(Codigo, CategoriaNum),
    asignar_categoria(CategoriaNum, Categoria),

    obtener_consecutivo(Codigo, Consecutivo),

    paridad(Codigo, Paridad).


% VALIDACION


validar_codigo(Codigo) :-
    Codigo > 0,
    Codigo >= 10000000,
    Codigo =< 99999999,

    obtener_periodo(Codigo, P),
    periodo_correcto(P),

    obtener_categoria(Codigo, C),
    categoria_correcta(C),

    obtener_consecutivo(Codigo, N),
    consecutivo_correcto(N).


% PERIODO


obtener_periodo(Codigo, Periodo) :-
    Periodo is Codigo // 100000.


    periodo_correcto(262).
    periodo_correcto(271).
    periodo_correcto(272).
    periodo_correcto(281).
    periodo_correcto(282).
    periodo_correcto(291).
    periodo_correcto(292).

convertir_periodo(262,'2026-2').
convertir_periodo(271,'2027-1').
convertir_periodo(272,'2027-2').
convertir_periodo(281,'2028-1').
convertir_periodo(282,'2028-2').
convertir_periodo(291,'2029-1').
convertir_periodo(292,'2029-2').


% CATEGORIA


obtener_categoria(Codigo, Categoria) :-
    Categoria is (Codigo mod 100000) // 1000.

categoria_correcta(Categoria) :-
    Categoria >= 1,
    Categoria =< 99.

divisor(N,D) :-
    between(1,N,D),
    D < N,
    N mod D =:= 0.

suma_divisores(N,Suma) :-
    findall(D, divisor(N,D), Lista),
    sumlist(Lista,Suma).

asignar_categoria(N,'Administrative') :-
    suma_divisores(N,Suma),
    Suma > N.

asignar_categoria(N,'Engineering') :-
    suma_divisores(N,Suma),
    Suma =:= N.

asignar_categoria(N,'Humanities') :-
    suma_divisores(N,Suma),
    Suma < N.


% CONSECUTIVO 

obtener_consecutivo(Codigo, Consecutivo) :-
    Consecutivo is Codigo mod 1000.

consecutivo_correcto(N) :-
    N >= 1,
    N =< 999.


% PARIDAD


paridad(Codigo,'even') :-
    Codigo mod 2 =:= 0.

paridad(Codigo,'odd') :-    
    Codigo mod 2 =\= 0.
