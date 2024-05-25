
# (a) V jazyce Prolog sestavte predikát
# Pro řešení problému je třeba napsat predikát, který nalezne řešení, pokud existuje, nebo vrátí false, pokud řešení neexistuje. Zde je řešení v Prologu:

% Definování časů přechodu pro jednotlivé hobbity
crossing_time(frodo, 1).
crossing_time(pipin, 2).
crossing_time(smiesek, 5).
crossing_time(sam, 8).

% Počáteční stav: všichni hobiti jsou na levé straně
initial_state(state(left, left, left, left, left)).

% Cílový stav: všichni hobiti jsou na pravé straně
goal_state(state(right, right, right, right, right)).

% Hlavní predikát pro nalezení řešení
find_solution(Solution) :-
    initial_state(State),
    solve(State, [], 15, Solution).

% Predikát pro řešení problému
solve(State, _, TimeLeft, []) :-
    goal_state(State),
    TimeLeft >= 0.

solve(State, Visited, TimeLeft, [Move | Moves]) :-
    move(State, Move, NewState, TimeSpent),
    NewTimeLeft is TimeLeft - TimeSpent,
    NewTimeLeft >= 0,
    \+ member(NewState, Visited),
    solve(NewState, [NewState | Visited], NewTimeLeft, Moves).

% Definování možných přechodů
move(state(LF, LP, LS, LSM, left), move([H1, H2], right), state(RF, RP, RS, RSM, right), TimeSpent) :-
    crossing_time(H1, T1),
    crossing_time(H2, T2),
    max_member(TimeSpent, [T1, T2]),
    set_hobbit_position([H1, H2], right, [LF, LP, LS, LSM], [RF, RP, RS, RSM]).

move(state(RF, RP, RS, RSM, right), move(H, left), state(LF, LP, LS, LSM, left), TimeSpent) :-
    crossing_time(H, TimeSpent),
    set_hobbit_position([H], left, [RF, RP, RS, RSM], [LF, LP, LS, LSM]).

% Pomocný predikát pro nastavení pozice hobitů
set_hobbit_position([], _, Positions, Positions).
set_hobbit_position([H | T], Side, [H | RestPositions], [Side | RestNewPositions]) :-
    set_hobbit_position(T, Side, RestPositions, RestNewPositions).

% Spuštění řešení
:- find_solution(Solution), write('Solution: '), writeln(Solution).


# (b) Je některý z predikátů, které jste použili v (a), nedeterministický?
# Ano, predikát solve je nedeterministický. To je proto, že používá zpětné prohledávání k nalezení řešení. Pokud Prolog narazí na slepou uličku, vrátí se a zkusí jinou cestu. Tento nedeterminismus je v tomto případě užitečný, protože umožňuje Prologu prozkoumat všechny možné cesty, jak hobiti mohou překonat most, a najít platné řešení, pokud existuje.

# (c) Fungovalo by vaše řešení i pro jiný počet hobitů (se zadanými časy přechodu) a jinou životnost pochodně? Pokud ano, stručně vysvětlete, jak vyřešit tuto obecnější úlohu.
# Ano, řešení by mohlo fungovat i pro jiný počet hobitů a jinou životnost pochodně, ale bylo by třeba upravit predikáty tak, aby dynamicky zpracovávaly různé počty hobitů a jejich časy přechodů. Zde je základní náčrt, jak by to mohlo být realizováno:

# Uložte časy přechodů do seznamu namísto pevného definování pro každého hobita.
# Upravit stav, aby mohl obsahovat dynamický počet hobitů.
# Přizpůsobit predikát move tak, aby mohl pracovat s obecným seznamem hobitů.
# Toto by znamenalo úpravu řešení pro zpracování dynamických dat. Zde je stručný náčrt:

# Tímto způsobem lze obecněji zpracovat různé počty hobitů a jejich časy přechodů, stejně jako různé životnosti pochodně.

% Definování časů přechodů jako seznam
crossing_times([1, 2, 5, 8]).

% Dynamický počáteční stav
initial_state(State) :-
    crossing_times(Times),
    length(Times, N),
    length(StateList, N),
    maplist(=(left), StateList),
    State =.. [state | StateList].

% Dynamický cílový stav
goal_state(State) :-
    crossing_times(Times),
    length(Times, N),
    length(StateList, N),
    maplist(=(right), StateList),
    State =.. [state | StateList].

% Spuštění řešení pro dynamický počet hobitů
:- find_solution(Solution), write('Solution: '), writeln(Solution).
