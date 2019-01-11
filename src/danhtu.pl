:- reconsult('lib.pl').
:- reconsult('../src/cache.pl').
:- reconsult('../tuvung/tuvung_danhtu.pl').
:- reconsult('../tuvung/tuvung_danhtu_encoded.pl').

% cum_danh_tu -> cumdanhtu1_temp
cum_danh_tu(List_Input, List_Output, Json) :-
	cumdanhtu1_temp(List_Input, List_Output, A),
	atomics_to_string(["'cum_danh_tu':", "{", A, "}"], Json).

% cum_danh_tu -> cumdanhtu1_temp + cum_dong_tu
cum_danh_tu(List_Input, List_Output, Json) :-
	cumdanhtu1_temp(List_Input, List_Temp, A),
	cum_dong_tu(List_Temp, List_Output, B),
	atomics_to_string(["'cum_danh_tu':", "{", A, ",", B, "}"], Json).

% cumdanhtu1_temp -> cumdanhtu2_temp
cumdanhtu1_temp(List_Input, List_Output, Json) :-
	cumdanhtu2_temp(List_Input, List_Output, A),
	atomics_to_string(["'cumdanhtu1_temp':", "{", A, "}"], Json).

% cumdanhtu1_temp -> cumdanhtu2_temp + so_huu
cumdanhtu1_temp(List_Input, List_Output, Json) :-
	cumdanhtu2_temp(List_Input, List_Temp, A),
	so_huu(List_Temp, List_Output, B),
	atomics_to_string(["'cumdanhtu1_temp':", "{", A, ",", B, "}"], Json).

% cumdanhtu2_temp -> danh_tu
cumdanhtu2_temp(List_Input, List_Output, Json) :-
	danh_tu(List_Input, List_Output, A),
	atomics_to_string(["'cumdanhtu2_temp':", "{", A, "}"], Json).

% cumdanhtu2_temp -> danh_tu + tinh_tu
cumdanhtu2_temp(List_Input, List_Output, Json) :-
	danh_tu(List_Input, List_Temp, A),
	tinh_tu(List_Temp, List_Output, B),
	atomics_to_string(["'cumdanhtu2_temp':", "{", A, ",", B, "}"], Json).

% cumdanhtu2_temp -> dai_tu
cumdanhtu2_temp(List_Input, List_Output, Json) :-
	dai_tu(List_Input, List_Output, A),
	atomics_to_string(["'cumdanhtu2_temp':", "{", A, "}"], Json).

cumtu_dacbiet_temp([_|B], B).
cumtu_dacbiet_temp([_|B], C) :-
	cumtu_dacbiet_temp(B, C).

% cumtu_dacbiet
cumtu_dacbiet(A, B, Json) :-
	cumtu_dacbiet_temp(A, B),
	sublist(A, C, B),
	atomics_to_string(C,' ', D),
 	atomics_to_string(["'cumtu_dacbiet':", "'", D, "'"], Json).

% danh_tu -> danh_tu_loop
danh_tu(List_Input, List_Output, Json) :-
	danh_tu_loop(List_Input, List_Output, A),
	atomics_to_string(["'danh_tu':", "{", A, "}"], Json).

danh_tu_loop_temp() :-
	nb_getval(danh_tu_loop_list_input, List_Input),
	danh_tu1_temp(List_Input, List_Temp, A),
	nb_getval(danh_tu_loop_json, List_Json_Temp),
	(
		List_Json_Temp == '' -> atomics_to_string([A], Json);
		List_Json_Temp \== '' -> atomics_to_string([List_Json_Temp, ', ', A], Json)
	),
	nb_setval(danh_tu_loop_list_output, List_Temp),
	nb_setval(danh_tu_loop_list_input, List_Temp),
	nb_setval(danh_tu_loop_json, Json).
	
% danh_tu_loop -> danh_tu1_temp + ...	
danh_tu_loop(List_Input, List_Output, Json) :-
	nb_setval(danh_tu_loop_list_input, List_Input),
	nb_setval(danh_tu_loop_list_output, []),
	nb_setval(danh_tu_loop_json, ''),
	repeat,
	(
		not(call(danh_tu_loop_temp)),!
	),
	nb_getval(danh_tu_loop_list_output, List_Output),
	nb_getval(danh_tu_loop_json, Json),
	(
		Json == '' -> fail;
		Json \== '' -> !
	).

% danh_tu_loop2 -> danh_tu1_temp + ...
%% danh_tu_loop2([], _, '') :- fail.
%% danh_tu_loop2(List_Input, List_Output, Json) :-
%% 	danh_tu1_temp(List_Input, List_Temp, A),
%% 	(
%% 		List_Temp == [] -> atomics_to_string([A], Json), List_Output = [],!;
%% 		List_Temp \== [] -> danh_tu_loop2(List_Temp, List_Output, B),!,
%% 		atomics_to_string([A, ', ', B], Json)
%% 	).

% danh_tu1_temp -> bai + cache_nhac
danh_tu1_temp(List_Input, List_Output, Json) :-
	delete_first_list('62c3a069', List_Input, List_Temp), % 62c3a069 : bai
	atomics_to_string(["'tu_dat_biet':", "'62c3a069'"], A),
	cache_nhac(List_Temp, List_Output, B),
	atomics_to_string(["'danh_tu1_temp':", "{", A, ",", B, "}"], Json).

% danh_tu1_temp -> cache_nhac
danh_tu1_temp(List_Input, List_Output, Json) :-
	cache_nhac(List_Input, List_Output, A),
	atomics_to_string(["'danh_tu1_temp':", "{", A, "}"], Json).

% danh_tu1_temp -> cache_ten
danh_tu1_temp(List_Input, List_Output, Json) :-
	cache_ten(List_Input, List_Output, A),
	atomics_to_string(["'danh_tu1_temp':", "{", A, "}"], Json).

% danh_tu1_temp -> danhtu_ten
danh_tu1_temp(List_Input, List_Output, Json) :-
	danhtu_ten(List_Input, List_Output, A),
	atomics_to_string(["'danh_tu1_temp':", "{", A, "}"], Json).

% danh_tu1_temp -> danhtu_rieng
danh_tu1_temp(List_Input, List_Output, Json) :-
	danhtu_rieng(List_Input, List_Output, A),
	atomics_to_string(["'danh_tu1_temp':", "{", A, "}"], Json).

% danh_tu1_temp -> danhtu_demduoc
danh_tu1_temp(List_Input, List_Output, Json) :-
	danhtu_demduoc(List_Input, List_Output, A),
	atomics_to_string(["'danh_tu1_temp':", "{", A, "}"], Json).

% danh_tu1_temp -> danhtu_khongdemduoc
danh_tu1_temp(List_Input, List_Output, Json) :-
	danhtu_khongdemduoc(List_Input, List_Output, A),
	atomics_to_string(["'danh_tu1_temp':", "{", A, "}"], Json).

%% % danh_tu1_temp -> maotu_dacbiet + cumtu_dacbiet
%% danh_tu1_temp(List_Input, List_Output, Json) :-
%% 	maotu_dacbiet(List_Input, List_Temp, A),
%% 	cumtu_dacbiet(List_Temp, List_Output, B),
%% 	atomics_to_string(["'danh_tu1_temp':", "{", A, ",", B, "}"], Json).

%% % danh_tu1_temp -> cumtu_dacbiet
%% danh_tu1_temp(List_Input, List_Output, Json) :-
%% 	cumtu_dacbiet(List_Input, List_Output, A),
%% 	atomics_to_string(["'danh_tu1_temp':", "{", A, "}"], Json).

% danhtu_demduoc -> danhtu_chinguoi
danhtu_demduoc(List_Input, List_Output, Json) :-
	danhtu_chinguoi(List_Input, List_Output, A),
	atomics_to_string(["'danhtu_demduoc':", "{", A, "}"], Json).

% danhtu_demduoc -> danhtu_chicaycoi
danhtu_demduoc(List_Input, List_Output, Json) :-
	danhtu_chicaycoi(List_Input, List_Output, A),
	atomics_to_string(["'danhtu_demduoc':", "{", A, "}"], Json).

% danhtu_demduoc -> danhtu_chidovat
danhtu_demduoc(List_Input, List_Output, Json) :-
	danhtu_chidovat(List_Input, List_Output, A),
	atomics_to_string(["'danhtu_demduoc':", "{", A, "}"], Json).

% danhtu_demduoc -> danhtu_chiconvat
danhtu_demduoc(List_Input, List_Output, Json) :-
	danhtu_chiconvat(List_Input, List_Output, A),
	atomics_to_string(["'danhtu_demduoc':", "{", A, "}"], Json).

% danhtu_demduoc -> danhtuchung_demduoc
danhtu_demduoc(List_Input, List_Output, Json) :-
	danhtuchung_demduoc(List_Input, List_Output, A),
	atomics_to_string(["'danhtu_demduoc':", "{", A, "}"], Json).

% danhtu_ten -> danhtu_ten
danhtu_ten(List_Input, List_Output, Json) :-
	danhtu_ten(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_ten':", "'", A, "'"], Json).

% danhtu_rieng -> danhtu_rieng
danhtu_rieng(List_Input, List_Output, Json) :-
	danhtu_rieng(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_rieng':", "'", A, "'"], Json).

% danhtu_chinguoi -> danhtu_chinguoi
danhtu_chinguoi(List_Input, List_Output, Json) :-
	danhtu_chinguoi(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_chinguoi':", "'", A, "'"], Json).

% danhtu_chicaycoi -> danhtu_chicaycoi
danhtu_chicaycoi(List_Input, List_Output, Json) :-
	danhtu_chicaycoi(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_chicaycoi':", "'", A, "'"], Json).

% danhtu_chicaycoi -> danhtu_chicaycoi
danhtu_chicaycoi(List_Input, List_Output, Json) :-
	delete_first_list('63c3a279', List_Input, List_Temp), % 63c3a279 : cây
	delete(List_Temp,'63c3a279',List_Temp2),
	danhtu_chicaycoi(List_Temp2, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_chicaycoi':", "'",A, "'"], Json).

% danhtu_chidovat -> danhtu_chidovat
danhtu_chidovat(List_Input, List_Output, Json) :-
	danhtu_chidovat(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_chidovat':", "'", A, "'"], Json).

% danhtu_chidovat -> danhtu_chidovat
danhtu_chidovat(List_Input, List_Output, Json) :-
	delete_first_list('63c3a169', List_Input, List_Temp), % 63c3a169 : cái
	delete(List_Temp,'63c3a169',List_Temp2),
	danhtu_chidovat(List_Temp2, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_chidovat':", "'",A, "'"], Json).

% danhtu_chiconvat -> danhtu_chiconvat
danhtu_chiconvat(List_Input, List_Output, Json) :-
	danhtu_chiconvat(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_chiconvat':", "'", A, "'"], Json).

% danhtu_chiconvat -> danhtu_chiconvat
danhtu_chiconvat(List_Input, List_Output, Json) :-
	delete_first_list('636f6e', List_Input, List_Temp), % 636f6e : con
	delete(List_Temp,'636f6e',List_Temp2),
	danhtu_chiconvat(List_Temp2, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_chiconvat':", "'",A, "'"], Json).

% danhtuchung_demduoc -> danhtuchung_demduoc
danhtuchung_demduoc(List_Input, List_Output, Json) :-
	danhtuchung_demduoc(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtuchung_demduoc':", "'", A, "'"], Json).

% danhtu_khongdemduoc -> danhtu_khongdemduoc
danhtu_khongdemduoc(List_Input, List_Output, Json) :-
	danhtu_khongdemduoc(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_khongdemduoc':", "'", A, "'"], Json).