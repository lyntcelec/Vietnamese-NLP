/*
 * Phó từ đứng trước động từ, tính từ, bổ nghĩa cho động từ, tính từ
 */

:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_photu.pl').
:- reconsult('../tuvung/tuvung_photu_encoded.pl').

% pho_tu -> photu_truoc
pho_tu(List_Input, List_Output, Json) :-
	photu_truoc(List_Input, List_Output, A),
	atomics_to_string(["'pho_tu':", "{", A, "}"], Json).

% pho_tu -> photu_sau
pho_tu(List_Input, List_Output, Json) :-
	photu_sau(List_Input, List_Output, A),
	atomics_to_string(["'pho_tu':", "{", A, "}"], Json).

% pho_tu -> photu_giupdo
pho_tu(List_Input, List_Output, Json) :-
	photu_giupdo(List_Input, List_Output, A),
	atomics_to_string(["'pho_tu':", "{", A, "}"], Json).
	
% photu_truoc -> photu_truoc
photu_truoc(List_Input, List_Output, Json) :-
	photu_truoc(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'photu_truoc':", "'", A, "'"], Json).

% photu_sau -> photu_sau
photu_sau(List_Input, List_Output, Json) :-
	photu_sau(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'photu_sau':", "'", A, "'"], Json).

% photu_giupdo -> photu_giupdo
photu_giupdo(List_Input, List_Output, Json) :-
	photu_giupdo(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'photu_giupdo':", "'", A, "'"], Json).