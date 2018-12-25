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

no :-
	notrace,
	nodebug.

print(String) :-
	pdebug(X),
	(
		X = 1, write(String);
		X \= 1, X is 0 % X is 0 : để tránh lỗi nếu không có lệnh gì sau biểu thức điều kiện
	).
