:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_daitu.pl').
:- reconsult('../tuvung/tuvung_daitu_encoded.pl').

% dai_tu -> daitu_nhanxung_ngoithunhat
% return: [[dai_tu, [daitu_nhanxung_ngoithunhat, ...]]].
dai_tu(List_Input, List_Output, Phrase) :-
	daitu_nhanxung_ngoithunhat(List_Input, List_Output, Phrase_A),
	append_multiple([['dai_tu'], [Phrase_A]], Phrase).

% dai_tu -> daitu_nhanxung_ngoithuhai
% return: [[dai_tu, [daitu_nhanxung_ngoithuhai, ...]]].
dai_tu(List_Input, List_Output, Phrase) :-
	daitu_nhanxung_ngoithuhai(List_Input, List_Output, Phrase_A),
	append_multiple([['dai_tu'], [Phrase_A]], Phrase).

% dai_tu -> daitu_nhanxung_ngoithuba
% return: [[dai_tu, [daitu_nhanxung_ngoithuba, ...]]].
dai_tu(List_Input, List_Output, Phrase) :-
	daitu_nhanxung_ngoithuba(List_Input, List_Output, Phrase_A),
	append_multiple([['dai_tu'], [Phrase_A]], Phrase).

% daitu_nhanxung_ngoithunhat -> daitu_nhanxung_ngoithunhat
% return: [[daitu_nhanxung_ngoithunhat, '']]
daitu_nhanxung_ngoithunhat(List_Input, List_Output, Phrase) :-
	daitu_nhanxung_ngoithunhat(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['daitu_nhanxung_ngoithunhat'], [Word]], Phrase).

% daitu_nhanxung_ngoithuhai -> daitu_nhanxung_ngoithuhai
% return: [[daitu_nhanxung_ngoithuhai, '']]
daitu_nhanxung_ngoithuhai(List_Input, List_Output, Phrase) :-
	daitu_nhanxung_ngoithuhai(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['daitu_nhanxung_ngoithuhai'], [Word]], Phrase).

% daitu_nhanxung_ngoithuba -> daitu_nhanxung_ngoithuba
% return: [[daitu_nhanxung_ngoithuba, '']]
daitu_nhanxung_ngoithuba(List_Input, List_Output, Phrase) :-
	daitu_nhanxung_ngoithuba(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['daitu_nhanxung_ngoithuba'], [Word]], Phrase).