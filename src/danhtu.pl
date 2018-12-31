:- reconsult('lib.pl').
:- reconsult('../src/cache.pl').
:- reconsult('../tuvung/tuvung_danhtu.pl').
:- reconsult('../tuvung/tuvung_danhtu_encoded.pl').

% cum_danh_tu -> cumdanhtu_chinh
cum_danh_tu(List_Input, List_Output, Json) :-
	print('->cumdanhtu_chinh'),
	cumdanhtu_chinh(List_Input, List_Output, A),
	atomics_to_string(["'cum_danh_tu':", "{", A, "}"], Json).

% cum_danh_tu -> cumdanhtu_chinh + so_huu
cum_danh_tu(List_Input, List_Output, Json) :-
	print('->cumdanhtu_chinh'),
	cumdanhtu_chinh(List_Input, List_Temp, A),
	print(' +so_huu'),
	so_huu(List_Temp, List_Output, B),
	atomics_to_string(["'cum_danh_tu':", "{", A, ",", B, "}"], Json).

% cumdanhtu_chinh -> danh_tu
cumdanhtu_chinh(List_Input, List_Output, Json) :-
	print('->danh_tu'),
	danh_tu(List_Input, List_Output, A),
	atomics_to_string(["'cumdanhtu_chinh':", "{", A, "}"], Json).

% cumdanhtu_chinh -> dai_tu
cumdanhtu_chinh(List_Input, List_Output, Json) :-
	print('->dai_tu'),
	dai_tu(List_Input, List_Output, A),
	atomics_to_string(["'cumdanhtu_chinh':", "{", A, "}"], Json).

cumtu_dacbiet_temp([_|B], B).
cumtu_dacbiet_temp([_|B], C) :-
	cumtu_dacbiet_temp(B, C).

% cumtu_dacbiet
cumtu_dacbiet(A, B, Json) :-
	cumtu_dacbiet_temp(A, B),
	sublist(A, C, B),
	atomics_to_string(C,' ', D),
 	atomics_to_string(["'cumtu_dacbiet':", "'", D, "'"], Json).

% danh_tu -> bai + cache_nhac
danh_tu(List_Input, List_Output, Json) :-
	print(' +bai'),
	delete_first_list('62c3a069', List_Input, List_Temp), % 62c3a069 : bai
	atomics_to_string(["'bai':", "'62c3a069'"], A),
	print(' +cache_nhac'),
	cache_nhac(List_Temp, List_Output, B),
	atomics_to_string(["'danh_tu':", "{", A, ",", B, "}"], Json).

% danh_tu -> cache_nhac
danh_tu(List_Input, List_Output, Json) :-
	print(' +cache_nhac'),
	cache_nhac(List_Input, List_Output, A),
	atomics_to_string(["'danh_tu':", "{", A, "}"], Json).

% danh_tu -> cache_ten
danh_tu(List_Input, List_Output, Json) :-
	print(' +cache_ten'),
	cache_ten(List_Input, List_Output, A),
	atomics_to_string(["'danh_tu':", "{", A, "}"], Json).

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

% danh_tu -> maotu_dacbiet + cumtu_dacbiet
danh_tu(List_Input, List_Output, Json) :-
	print('->maotu_dacbiet'),
	maotu_dacbiet(List_Input, List_Temp, A),
	print(' +cumtu_dacbiet'),
	cumtu_dacbiet(List_Temp, List_Output, B),
	atomics_to_string(["'danh_tu':", "{", A, ",", B, "}"], Json).

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
	print(' +cay'),
	delete_first_list('63c3a279', List_Input, List_Temp), % 63c3a279 : cây
	print('->danhtu_chicaycoi'),
	delete(List_Temp,'63c3a279',List_Temp2),
	danhtu_chicaycoi(List_Temp2, List_Output),
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
	print(' +cai'),
	delete_first_list('63c3a169', List_Input, List_Temp), % 63c3a169 : cái
	print('->danhtu_chidovat'),
	delete(List_Temp,'63c3a169',List_Temp2),
	danhtu_chidovat(List_Temp2, List_Output),
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
	print(' +con'),
	delete_first_list('636f6e', List_Input, List_Temp), % 636f6e : con
	print('->danhtu_chiconvat'),
	delete(List_Temp,'636f6e',List_Temp2),
	danhtu_chiconvat(List_Temp2, List_Output),
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