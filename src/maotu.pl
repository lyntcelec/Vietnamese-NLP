:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_maotu.pl').
:- reconsult('../tuvung/tuvung_maotu_encoded.pl').

% mao_tu -> loai_maotu
mao_tu(List_Input, List_Output, Json) :-
	print('->loai_maotu'),
	loai_maotu(List_Input, List_Output, A),
	atomics_to_string(["'mao_tu':", "{", A, "}"], Json).

% mao_tu -> maotu_dacbiet
mao_tu(List_Input, List_Output, Json) :-
	print('->maotu_dacbiet'),
	maotu_dacbiet(List_Input, List_Output, A),
	atomics_to_string(["'mao_tu':", "{", A, "}"], Json).

% loai_maotu -> loai_maotu
loai_maotu(List_Input, List_Output, Json) :-
	print('->loai_maotu'),
	loai_maotu(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'loai_maotu':", "'", A, "'"], Json).

% maotu_dacbiet -> maotu_dacbiet
maotu_dacbiet(List_Input, List_Output, Json) :-
	print('->maotu_dacbiet'),
	maotu_dacbiet(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'maotu_dacbiet':", "'", A, "'"], Json).