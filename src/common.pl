:- reconsult('lib.pl').
:- reconsult('danhtu.pl').
:- reconsult('dongtu.pl').
:- reconsult('daitu.pl').
:- reconsult('photu.pl').
:- reconsult('camtu.pl').
:- reconsult('maotu.pl').
:- reconsult('trotu.pl').
:- reconsult('sohuu.pl').
:- reconsult('caucaukhien.pl').

% cau -> cau_don
cau(List_Input, List_Output, Json) :-
	print('cau_don: '),
	cau_don(List_Input, List_Output, A),
	atomics_to_string(["{", A, "}"], Json).

% cau -> cau_don
cau(List_Input, List_Output, Json) :-
	print('cau_cau_khien: '),
	cau_cau_khien(List_Input, List_Output, A),
	atomics_to_string(["{", A, "}"], Json).

% cau_don -> cum_danh_tu + vi_ngu
cau_don(List_Input, List_Output, Json) :-
	print(' +cum_danh_tu'),
	cum_danh_tu(List_Input, List_Temp, A),
	print(' +vi_ngu'),
	vi_ngu(List_Temp, List_Output, B),
	atomics_to_string(["'cau_don':", "{", A, ",", B, "}"], Json).

% vi_ngu -> cum_dong_tu
vi_ngu(List_Input, List_Output, Json) :-
	print('->cum_dong_tu'),
	cum_dong_tu(List_Input, List_Output, A),
	atomics_to_string(["'vi_ngu':", "{", A, "}"], Json).


