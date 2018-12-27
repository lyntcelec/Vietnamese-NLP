:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_photu.pl').
:- reconsult('../tuvung/tuvung_photu_encoded.pl').

% pho_tu -> photu_daucau
pho_tu(List_Input, List_Output, Json) :-
	print('->photu_daucau'),
	photu_daucau(List_Input, List_Output, A),
	atomics_to_string(["'pho_tu':", "{", A, "}"], Json).

% pho_tu -> photu_cuoicau
pho_tu(List_Input, List_Output, Json) :-
	print('->photu_cuoicau'),
	photu_cuoicau(List_Input, List_Output, A),
	atomics_to_string(["'pho_tu':", "{", A, "}"], Json).

% pho_tu -> photu_giupdo
pho_tu(List_Input, List_Output, Json) :-
	print('->photu_giupdo'),
	photu_giupdo(List_Input, List_Output, A),
	atomics_to_string(["'pho_tu':", "{", A, "}"], Json).
	
% photu_daucau -> photu_daucau
photu_daucau(List_Input, List_Output, Json) :-
	print('->photu_daucau'),
	photu_daucau(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'photu_daucau':", "'", A, "'"], Json).

% photu_cuoicau -> photu_cuoicau
photu_cuoicau(List_Input, List_Output, Json) :-
	print('->photu_cuoicau'),
	photu_cuoicau(List_Input, List_Temp),
	!,
	delete(List_Temp,mà,List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'photu_cuoicau':", "'",A, "'"], Json).

% photu_cuoicau -> photu_cuoicau
photu_cuoicau(List_Input, List_Output, Json) :-
	print('->photu_cuoicau'),
	photu_cuoicau(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'photu_cuoicau':", "'", A, "'"], Json).

% photu_giupdo -> photu_giupdo
photu_giupdo(List_Input, List_Output, Json) :-
	print('->photu_giupdo'),
	photu_giupdo(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'photu_giupdo':", "'", A, "'"], Json).