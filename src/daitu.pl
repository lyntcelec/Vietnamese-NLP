:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_daitu.pl').
:- reconsult('../tuvung/tuvung_daitu_encoded.pl').

% dai_tu -> daitu_nhanxung_ngoithunhat
dai_tu(List_Input, List_Output, Json) :-
	daitu_nhanxung_ngoithunhat(List_Input, List_Output, A),
	atomics_to_string(["'dai_tu':", "{", A, "}"], Json).

% dai_tu -> daitu_nhanxung_ngoithuhai
dai_tu(List_Input, List_Output, Json) :-
	daitu_nhanxung_ngoithuhai(List_Input, List_Output, A),
	atomics_to_string(["'dai_tu':", "{", A, "}"], Json).

% dai_tu -> daitu_nhanxung_ngoithuba
dai_tu(List_Input, List_Output, Json) :-
	daitu_nhanxung_ngoithuba(List_Input, List_Output, A),
	atomics_to_string(["'dai_tu':", "{", A, "}"], Json).

% daitu_nhanxung_ngoithunhat -> daitu_nhanxung_ngoithunhat
daitu_nhanxung_ngoithunhat(List_Input, List_Output, Json) :-
	daitu_nhanxung_ngoithunhat(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'daitu_nhanxung_ngoithunhat':", "'", A, "'"], Json).

% daitu_nhanxung_ngoithuhai -> daitu_nhanxung_ngoithuhai
daitu_nhanxung_ngoithuhai(List_Input, List_Output, Json) :-
	daitu_nhanxung_ngoithuhai(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'daitu_nhanxung_ngoithuhai':", "'", A, "'"], Json).

% daitu_nhanxung_ngoithuba -> daitu_nhanxung_ngoithuba
daitu_nhanxung_ngoithuba(List_Input, List_Output, Json) :-
	daitu_nhanxung_ngoithuba(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'daitu_nhanxung_ngoithuba':", "'", A, "'"], Json).