apply(add, X, Y, Result) :- Result is X + Y, !.
apply(subtract, X, Y, Result) :- Result is X - Y, !.
apply(multiply, X, Y, Result) :- Result is X * Y, !.
apply(divide, X, Y, Result) :- Result is X / Y, !.

apply_lr([], [Result], Result).
apply_lr([Op|OpTail], [X, Y |NumTail], FinalResult) :- apply(Op, X, Y, Result), apply_lr(OpTail, [Result|NumTail], FinalResult).	

populate_list([], _, []).
populate_list([_|Xs], Elements, NewList) :- append(_, [E|_], Elements), populate_list(Xs, Elements, NewTail), append([E], NewTail, NewList).

allLists(Num, Elements, Result) :- length(EmptyList, Num), populate_list(EmptyList, Elements, Result).
