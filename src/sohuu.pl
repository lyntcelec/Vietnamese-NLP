:- reconsult('lib.pl').

% so_huu -> của + cum_danh_tu
% return: [[so_huu, [tu_dat_biet, 'của'], [cum_danh_tu, ...]]].
so_huu(List_Input, List_Output, Phrase) :-
	tu_dat_biet('của', List_Input, List_Temp, Phrase_A),
	cum_danh_tu(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['so_huu'], [Phrase_Temp]], Phrase).
