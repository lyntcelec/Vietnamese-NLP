:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_tinhtu.pl').
:- reconsult('../tuvung/tuvung_tinhtu_encoded.pl').

% tinh_tu -> tinhtu_chung
tinh_tu(List_Input, List_Output, Json) :-
	tinhtu_chung(List_Input, List_Output, A),
	atomics_to_string(["'tinh_tu':", "{", A, "}"], Json).

% tinh_tu -> tinhtu_chimucdo + tinhtu_chung
tinh_tu(List_Input, List_Output, Json) :-
	tinhtu_chimucdo(List_Input, List_Temp, A),
	tinhtu_chung(List_Temp, List_Output, B),
	atomics_to_string(["'tinh_tu':", "{", A, ",", B, "}"], Json).

% tinhtu_chimucdo -> tinhtu_chimucdo
tinhtu_chimucdo(List_Input, List_Output, Json) :-
	tinhtu_chimucdo(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'tinhtu_chimucdo':", "'", A, "'"], Json).

% tinhtu_chung x 2
tinhtu_chung(List_Input, List_Output, Json) :-
	tinhtu_chung(List_Input, _),
	delete_first_list(Word, List_Input, List_Temp),
	delete_first_list(Word2, List_Temp, List_Output),
	Word == Word2,
	!,
	atomics_to_string(["'tinhtu_chung':", "'", Word, " ", Word, "'"], Json).

% tinhtu_chung -> tinhtu_chung
tinhtu_chung(List_Input, List_Output, Json) :-
	tinhtu_chung(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'tinhtu_chung':", "'", A, "'"], Json).