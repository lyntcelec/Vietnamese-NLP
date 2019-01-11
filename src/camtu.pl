:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_camtu.pl').
:- reconsult('../tuvung/tuvung_camtu_encoded.pl').

% cam_tu -> camtu_oi
cam_tu(List_Input, List_Output, Json) :-
	camtu_oi(List_Input, List_Output, A),
	atomics_to_string(["'cam_tu':", "{", A, "}"], Json).

% camtu_oi -> camtu_oi
camtu_oi(List_Input, List_Output, Json) :-
	camtu_oi(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'camtu_oi':", "'", A, "'"], Json).