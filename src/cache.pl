:- reconsult('lib.pl').
:- reconsult('../cache/nhac.pl').
:- reconsult('../cache/nhac_encoded.pl').
:- reconsult('../cache/ten.pl').
:- reconsult('../cache/ten_encoded.pl').

% cache -> cache_nhac
cache(List_Input, List_Output, Json) :-
	print('->cache_nhac'),
	camtu_oi(List_Input, List_Output, A),
	atomics_to_string(["'cache':", "{", A, "}"], Json).

% cache -> cache_ten
cache(List_Input, List_Output, Json) :-
	print('->cache_ten'),
	camtu_oi(List_Input, List_Output, A),
	atomics_to_string(["'cache':", "{", A, "}"], Json).

% cache_nhac -> cache_nhac
cache_nhac(List_Input, List_Output, Json) :-
	print('->cache_nhac'),
	cache_nhac(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'cache_nhac':", "'", A, "'"], Json).

% cache_ten -> cache_ten
cache_ten(List_Input, List_Output, Json) :-
	print('->cache_ten'),
	cache_ten(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'cache_ten':", "'", A, "'"], Json).