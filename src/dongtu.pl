:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_dongtu.pl').
:- reconsult('../tuvung/tuvung_dongtu_encoded.pl').

% cum_dong_tu -> dong_tu
cum_dong_tu(List_Input, List_Output, Json) :-
	print('->dong_tu'),
	dong_tu(List_Input, List_Temp, A),
	print(' +cum_danh_tu'),
	cum_danh_tu(List_Temp, List_Output, B),
	atomics_to_string(["'cum_dong_tu':", "{", A, ",", B, "}"], Json).

% cum_dong_tu -> dong_tu + photu_giupdo
cum_dong_tu(List_Input, List_Output, Json) :-
	print('->dong_tu'),
	dong_tu(List_Input, List_Temp, A),
	print(' +cum_danh_tu'),
	cum_danh_tu(List_Temp, List_Temp2, B),
	print('->photu_giupdo'),
	photu_giupdo(List_Temp2, List_Output, C),
	atomics_to_string(["'cum_dong_tu':", "{", A, ",", B, ",", C, "}"], Json).

% cum_dong_tu -> dong_tu + photu_giupdo + daitu_nhanxung_ngoithunhat
cum_dong_tu(List_Input, List_Output, Json) :-
	print('->dong_tu'),
	dong_tu(List_Input, List_Temp, A),
	print(' +cum_danh_tu'),
	cum_danh_tu(List_Temp, List_Temp2, B),
	print('->photu_giupdo'),
	photu_giupdo(List_Temp2, List_Temp3, C),
	print('->daitu_nhanxung_ngoithunhat'),
	daitu_nhanxung_ngoithunhat(List_Temp3, List_Output, D),
	atomics_to_string(["'cum_dong_tu':", "{", A, ",", B, ",", C, ",", D, "}"], Json).

% dong_tu -> loai_dongtu
dong_tu(List_Input, List_Output, Json) :-
	print('->loai_dongtu'),
	loai_dongtu(List_Input, List_Output, A),
	atomics_to_string(["'dong_tu':", "{", A, "}"], Json).

% dong_tu -> loai_dongtu + photu_giupdo
dong_tu(List_Input, List_Output, Json) :-
	print('->loai_dongtu'),
	loai_dongtu(List_Input, List_Temp, A),
	print('->photu_giupdo'),
	photu_giupdo(List_Temp, List_Output, B),
	atomics_to_string(["'dong_tu':", "{", A, ",", B, "}"], Json).

% dong_tu -> loai_dongtu + photu_giupdo + daitu_nhanxung_ngoithunhat
dong_tu(List_Input, List_Output, Json) :-
	print('->loai_dongtu'),
	loai_dongtu(List_Input, List_Temp, A),
	print('->photu_giupdo'),
	photu_giupdo(List_Temp, List_Temp2, B),
	print('->daitu_nhanxung_ngoithunhat'),
	daitu_nhanxung_ngoithunhat(List_Temp2, List_Output, C),
	atomics_to_string(["'dong_tu':", "{", A, ",", B, ",", C, "}"], Json).

% loai_dongtu -> dongtu_chihanhdong
loai_dongtu(List_Input, List_Output, Json) :-
	print('->dongtu_chihanhdong'),
	dongtu_chihanhdong(List_Input, List_Output, A),
	atomics_to_string(["'loai_dongtu':", "{", A, "}"], Json).

% loai_dongtu -> dongtu_chitrangthai
loai_dongtu(List_Input, List_Output, Json) :-
	print('->dongtu_chitrangthai'),
	dongtu_chitrangthai(List_Input, List_Output, A),
	atomics_to_string(["'loai_dongtu':", "{", A, "}"], Json).

% loai_dongtu -> dongtu_dacbiet
loai_dongtu(List_Input, List_Output, Json) :-
	print('->dongtu_dacbiet'),
	dongtu_dacbiet(List_Input, List_Output, A),
	atomics_to_string(["'loai_dongtu':", "{", A, "}"], Json).

% dongtu_chihanhdong -> dongtu_chihanhdong
dongtu_chihanhdong(List_Input, List_Output, Json) :-
	print('->dongtu_chihanhdong'),
	dongtu_chihanhdong(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'dongtu_chihanhdong':", "'", A, "'"], Json).

% dongtu_chitrangthai -> dongtu_chitrangthai
dongtu_chitrangthai(List_Input, List_Output, Json) :-
	print('->dongtu_chitrangthai'),
	dongtu_chitrangthai(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'dongtu_chitrangthai':", "'", A, "'"], Json).

% dongtu_dacbiet -> dongtu_dacbiet
dongtu_dacbiet(List_Input, List_Output, Json) :-
	print('->dongtu_dacbiet'),
	dongtu_dacbiet(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'dongtu_dacbiet':", "'", A, "'"], Json).