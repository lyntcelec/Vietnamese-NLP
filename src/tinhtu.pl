:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_tinhtu.pl').
:- reconsult('../tuvung/tuvung_tinhtu_encoded.pl').

% tinh_tu -> tinhtu_chung
% return: [[tinh_tu, [tinhtu_chung, ...]]].
tinh_tu(List_Input, List_Output, Phrase) :-
	tinhtu_chung(List_Input, List_Output, Phrase_A),
	append_multiple([['tinh_tu'], [Phrase_A]], Phrase).

% tinh_tu -> tinhtu_chimucdo + tinhtu_chung
% return: [[tinh_tu, [tinhtu_chimucdo, ...], [tinhtu_chung, ...]]].
tinh_tu(List_Input, List_Output, Phrase) :-
	tinhtu_chimucdo(List_Input, List_Temp, Phrase_A),
	tinhtu_chung(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['tinh_tu'], [Phrase_Temp]], Phrase).

% tinhtu_chimucdo -> tinhtu_chimucdo
% return: [[tinhtu_chimucdo, '']]
tinhtu_chimucdo(List_Input, List_Output, Phrase) :-
	tinhtu_chimucdo(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['tinhtu_chimucdo'], [Word]], Phrase).

% tinhtu_chung x 2
% return: [[tinhtu_chung, 'x2']]
tinhtu_chung(List_Input, List_Output, Phrase) :-
	tinhtu_chung(List_Input, _),
	sublist(List_Input, [Word], List_Temp),
	sublist(List_Temp, [Word2], List_Output),
	Word == Word2,
	!,
	atomics_to_string(["'", Word, ' ',Word2, "'"], Word_Out),
	append_multiple([['tinhtu_chung'], [Word_Out]], Phrase).

% tinhtu_chung -> tinhtu_chung
% return: [[tinhtu_chung, '']]
tinhtu_chung(List_Input, List_Output, Phrase) :-
	tinhtu_chung(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['tinhtu_chung'], [Word]], Phrase).