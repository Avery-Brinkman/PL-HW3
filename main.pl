apply(add, X, Y, Result) :- Result is X + Y, !.
apply(subtract, X, Y, Result) :- Result is X - Y, !.
apply(multiply, X, Y, Result) :- Result is X * Y, !.
apply(divide, X, Y, Result) :- Result is X / Y, !.
