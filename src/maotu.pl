:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_maotu.pl').
:- reconsult('../tuvung/tuvung_maotu_encoded.pl').

% mao_tu -> loai_maotu
% return: [[mao_tu, [loai_maotu, ...]]].
mao_tu(List_Input, List_Output, Phrase) :-
	loai_maotu(List_Input, List_Output, Phrase_A),
	append_multiple([['mao_tu'], [Phrase_A]], Phrase).

% mao_tu -> maotu_dacbiet
% return: [[mao_tu, [maotu_dacbiet, ...]]].
mao_tu(List_Input, List_Output, Phrase) :-
	maotu_dacbiet(List_Input, List_Output, Phrase_A),
	append_multiple([['mao_tu'], [Phrase_A]], Phrase).

% loai_maotu -> loai_maotu
% return: [[loai_maotu, '']]
loai_maotu(List_Input, List_Output, Phrase) :-
	loai_maotu(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['loai_maotu'], [Word]], Phrase).

% maotu_dacbiet -> maotu_dacbiet
% return: [[maotu_dacbiet, '']]
maotu_dacbiet(List_Input, List_Output, Phrase) :-
	maotu_dacbiet(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['maotu_dacbiet'], [Word]], Phrase).