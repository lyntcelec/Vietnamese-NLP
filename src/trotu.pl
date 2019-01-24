:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_trotu.pl').
:- reconsult('../tuvung/tuvung_trotu_encoded.pl').

% tro_tu -> trotu_cuoicau
% return: [[tro_tu, [trotu_cuoicau, ...]]].
tro_tu(List_Input, List_Output, Phrase) :-
	trotu_cuoicau(List_Input, List_Output, Phrase_A),
	append_multiple([['tro_tu'], [Phrase_A]], Phrase).

% trotu_cuoicau -> trotu_cuoicau
% return: [[trotu_cuoicau, '']]
trotu_cuoicau(List_Input, List_Output, Phrase) :-
	trotu_cuoicau(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['trotu_cuoicau'], [Word]], Phrase).

