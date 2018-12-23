:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_trotu.pl').
:- reconsult('../tuvung/tuvung_trotu_encoded.pl').

% tro_tu -> trotu_cuoicau
tro_tu(List_Input, List_Output, Json) :-
	print('->trotu_cuoicau'),
	trotu_cuoicau(List_Input, List_Output, A),
	atomics_to_string(["'tro_tu':", "{", A, "}"], Json).

% trotu_cuoicau -> trotu_cuoicau
trotu_cuoicau(List_Input, List_Output, Json) :-
	print('->trotu_cuoicau'),
	trotu_cuoicau(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'trotu_cuoicau':", "'", A, "'"], Json).