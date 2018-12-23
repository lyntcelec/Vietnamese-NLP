:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_danhtu.pl').
:- reconsult('../tuvung/tuvung_danhtu_encoded.pl').

% cum_danh_tu -> danh_tu
cum_danh_tu(List_Input, List_Output, Json) :-
	print('->danh_tu'),
	danh_tu(List_Input, List_Output, A),
	atomics_to_string(["'cum_danh_tu':", "{", A, "}"], Json).

% cum_danh_tu -> dai_tu
cum_danh_tu(List_Input, List_Output, Json) :-
	print('->dai_tu'),
	dai_tu(List_Input, List_Output, A),
	atomics_to_string(["'cum_danh_tu':", "{", A, "}"], Json).

% cum_danh_tu -> mao_tu + cumtu_dacbiet
cum_danh_tu(List_Input, List_Output, Json) :-
	print('->mao_tu'),
	mao_tu(List_Input, List_Temp, A),
	print(' +cumtu_dacbiet'),
	cumtu_dacbiet(List_Temp, List_Output, B),
	atomics_to_string(["'cum_danh_tu':", "{", A, ",", B, "}"], Json).

cumtu_dacbiet_temp([_|B], B).
cumtu_dacbiet_temp([_|B], C) :-
	cumtu_dacbiet_temp(B, C).

% cumtu_dacbiet
cumtu_dacbiet(A, B, Json) :-
	cumtu_dacbiet_temp(A, B),
	sublist(A, C, B),
	atomics_to_string(C,' ', D),
 	atomics_to_string(["'cumtu_dacbiet':", "'", D, "'"], Json).

% danh_tu -> danhtu_ten
danh_tu(List_Input, List_Output, Json) :-
	print('->danhtu_ten'),
	danhtu_ten(List_Input, List_Output, A),
	atomics_to_string(["'danh_tu':", "{", A, "}"], Json).

% danh_tu -> danhtu_rieng
danh_tu(List_Input, List_Output, Json) :-
	print('->danhtu_rieng'),
	danhtu_rieng(List_Input, List_Output, A),
	atomics_to_string(["'danh_tu':", "{", A, "}"], Json).

% danh_tu -> danhtu_demduoc
danh_tu(List_Input, List_Output, Json) :-
	print('->danhtu_demduoc'),
	danhtu_demduoc(List_Input, List_Output, A),
	atomics_to_string(["'danh_tu':", "{", A, "}"], Json).

% danh_tu -> danhtu_khongdemduoc
danh_tu(List_Input, List_Output, Json) :-
	print('->danhtu_khongdemduoc'),
	danhtu_khongdemduoc(List_Input, List_Output, A),
	atomics_to_string(["'danh_tu':", "{", A, "}"], Json).

% danhtu_demduoc -> danhtu_chicaycoi
danhtu_demduoc(List_Input, List_Output, Json) :-
	print('->danhtu_chicaycoi'),
	danhtu_chicaycoi(List_Input, List_Output, A),
	atomics_to_string(["'danhtu_demduoc':", "{", A, "}"], Json).

% danhtu_demduoc -> danhtu_chidovat
danhtu_demduoc(List_Input, List_Output, Json) :-
	print('->danhtu_chidovat'),
	danhtu_chidovat(List_Input, List_Output, A),
	atomics_to_string(["'danhtu_demduoc':", "{", A, "}"], Json).

% danhtu_demduoc -> danhtu_chiconvat
danhtu_demduoc(List_Input, List_Output, Json) :-
	print('->danhtu_chiconvat'),
	danhtu_chiconvat(List_Input, List_Output, A),
	atomics_to_string(["'danhtu_demduoc':", "{", A, "}"], Json).

% danhtu_demduoc -> danhtuchung_demduoc
danhtu_demduoc(List_Input, List_Output, Json) :-
	print('->danhtuchung_demduoc'),
	danhtuchung_demduoc(List_Input, List_Output, A),
	atomics_to_string(["'danhtu_demduoc':", "{", A, "}"], Json).

% danhtu_ten -> danhtu_ten
danhtu_ten(List_Input, List_Output, Json) :-
	print('->danhtu_ten'),
	danhtu_ten(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_ten':", "'", A, "'"], Json).

% danhtu_rieng -> danhtu_rieng
danhtu_rieng(List_Input, List_Output, Json) :-
	print('->danhtu_rieng'),
	danhtu_rieng(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_rieng':", "'", A, "'"], Json).

% danhtu_chicaycoi -> danhtu_chicaycoi
danhtu_chicaycoi(List_Input, List_Output, Json) :-
	print('->danhtu_chicaycoi'),
	danhtu_chicaycoi(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_chicaycoi':", "'", A, "'"], Json).

% danhtu_chicaycoi -> danhtu_chicaycoi
danhtu_chicaycoi(List_Input, List_Output, Json) :-
	print('->danhtu_chicaycoi'),
	delete(List_Input,cây,List_Temp),
	danhtu_chicaycoi(List_Temp, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_chicaycoi':", "'",A, "'"], Json).

% danhtu_chidovat -> danhtu_chidovat
danhtu_chidovat(List_Input, List_Output, Json) :-
	print('->danhtu_chidovat'),
	danhtu_chidovat(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_chidovat':", "'", A, "'"], Json).

% danhtu_chidovat -> danhtu_chidovat
danhtu_chidovat(List_Input, List_Output, Json) :-
	print('->danhtu_chidovat'),
	delete(List_Input,cái,List_Temp),
	danhtu_chidovat(List_Temp, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_chidovat':", "'",A, "'"], Json).

% danhtu_chiconvat -> danhtu_chiconvat
danhtu_chiconvat(List_Input, List_Output, Json) :-
	print('->danhtu_chiconvat'),
	danhtu_chiconvat(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_chiconvat':", "'", A, "'"], Json).

% danhtu_chiconvat -> danhtu_chiconvat
danhtu_chiconvat(List_Input, List_Output, Json) :-
	print('->danhtu_chiconvat'),
	delete(List_Input,con,List_Temp),
	danhtu_chiconvat(List_Temp, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_chiconvat':", "'",A, "'"], Json).

% danhtuchung_demduoc -> danhtuchung_demduoc
danhtuchung_demduoc(List_Input, List_Output, Json) :-
	print('->danhtuchung_demduoc'),
	danhtuchung_demduoc(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtuchung_demduoc':", "'", A, "'"], Json).

% danhtu_khongdemduoc -> danhtu_khongdemduoc
danhtu_khongdemduoc(List_Input, List_Output, Json) :-
	print('->danhtu_khongdemduoc'),
	danhtu_khongdemduoc(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'danhtu_khongdemduoc':", "'", A, "'"], Json).