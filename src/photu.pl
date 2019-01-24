/*
 * Phó từ đứng trước động từ, tính từ, bổ nghĩa cho động từ, tính từ
 */

:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_photu.pl').
:- reconsult('../tuvung/tuvung_photu_encoded.pl').

% pho_tu -> photu_truoc
% return: [[pho_tu, [photu_truoc, ...]]].
pho_tu(List_Input, List_Output, Phrase) :-
	photu_truoc(List_Input, List_Output, Phrase_A),
	append_multiple([['pho_tu'], [Phrase_A]], Phrase).

% pho_tu -> photu_sau
% return: [[pho_tu, [photu_sau, ...]]].
pho_tu(List_Input, List_Output, Phrase) :-
	photu_sau(List_Input, List_Output, Phrase_A),
	append_multiple([['pho_tu'], [Phrase_A]], Phrase).

% pho_tu -> photu_giupdo
% return: [[pho_tu, [photu_giupdo, ...]]].
pho_tu(List_Input, List_Output, Phrase) :-
	photu_giupdo(List_Input, List_Output, Phrase_A),
	append_multiple([['pho_tu'], [Phrase_A]], Phrase).

% photu_truoc -> photu_truoc
% return: [[photu_truoc, '']]
photu_truoc(List_Input, List_Output, Phrase) :-
	photu_truoc(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['photu_truoc'], [Word]], Phrase).

% photu_sau -> photu_sau
% return: [[photu_sau, '']]
photu_sau(List_Input, List_Output, Phrase) :-
	photu_sau(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['photu_sau'], [Word]], Phrase).

% photu_giupdo -> photu_giupdo
% return: [[photu_giupdo, '']]
photu_giupdo(List_Input, List_Output, Phrase) :-
	photu_giupdo(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['photu_giupdo'], [Word]], Phrase).