:- reconsult('lib.pl').

% so_huu -> của + cum_danh_tu
so_huu(List_Input, List_Output, Json) :-
	delete_first_list('63e1bba761', List_Input, List_Temp), % 63e1bba761 : của
	atomics_to_string(["'tu_dat_biet':", "'63e1bba761'"], A),
	cum_danh_tu(List_Temp, List_Output, B),
	atomics_to_string(["'so_huu':", "{", A, ",", B, "}"], Json).
