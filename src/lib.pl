:- set_prolog_flag(answer_write_options,[max_depth(0)]).
/* ------------- MACRO ------------- */
pdebug(0). % Set 1 to debug

/* 
?- sublist([a,b,c,d], X, [d]).
X = [a,b,c] . 
*/
sublist(A,[],A).
sublist([A|B],[A|C],X) :-
	sublist(B,C,X).

delete_first_list(A, [A|B], B).

append_multiple([[]], []).
append_multiple([[A|B]], [A|B]) :- !.
append_multiple([[A]], [A]).
append_multiple([H|T], O) :-
	append_multiple(T, O2),
	append(H, O2, O).

no :-
	notrace,
	nodebug.

print(String) :-
	pdebug(X),
	(
		X = 1, write(String);
		X \= 1, X is 0 % X is 0 : để tránh lỗi nếu không có lệnh gì sau biểu thức điều kiện
	).
