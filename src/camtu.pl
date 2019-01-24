:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_camtu.pl').
:- reconsult('../tuvung/tuvung_camtu_encoded.pl').

% cam_tu -> camtu_oi
% return: [[cam_tu, [camtu_oi, ...]]].
cam_tu(List_Input, List_Output, Phrase) :-
	camtu_oi(List_Input, List_Output, Phrase_A),
	append_multiple([['cam_tu'], [Phrase_A]], Phrase).

% camtu_oi -> camtu_oi
% return: [[camtu_oi, '']]
camtu_oi(List_Input, List_Output, Phrase) :-
	camtu_oi(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['camtu_oi'], [Word]], Phrase).