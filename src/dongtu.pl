:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_dongtu.pl').
:- reconsult('../tuvung/tuvung_dongtu_encoded.pl').

% cum_dong_tu -> dong_tu
cum_dong_tu(List_Input, List_Output, Json) :-
	dong_tu(List_Input, List_Output, A),
	atomics_to_string(["'cum_dong_tu':", "{", A, "}"], Json).
	
% cum_dong_tu -> dong_tu + cum_danh_tu
cum_dong_tu(List_Input, List_Output, Json) :-
	dong_tu(List_Input, List_Temp, A),
	cum_danh_tu(List_Temp, List_Output, B),
	atomics_to_string(["'cum_dong_tu':", "{", A, ",", B, "}"], Json).

% cum_dong_tu -> dong_tu + bởi + cum_danh_tu
cum_dong_tu(List_Input, List_Output, Json) :-
	dong_tu(List_Input, List_Temp, A),
	delete_first_list('62e1bb9f69', List_Temp, List_Temp2), % 62e1bb9f69 : bởi
	atomics_to_string(["'tu_dat_biet':", "'62e1bb9f69'"], B),
	cum_danh_tu(List_Temp2, List_Output, C),
	atomics_to_string(["'cum_dong_tu':", "{", A, ",", B, ",", C, "}"], Json).

% dong_tu -> dong_tu_temp
dong_tu(List_Input, List_Output, Json) :-
	dong_tu_temp(List_Input, List_Output, A),
	atomics_to_string(["'dong_tu':", "{", A, "}"], Json).

% dong_tu -> photu_truoc + dong_tu_temp
dong_tu(List_Input, List_Output, Json) :-
	photu_truoc(List_Input, List_Temp, A),
	dong_tu_temp(List_Temp, List_Output, B),
	atomics_to_string(["'dong_tu':", "{", A, ",", B, "}"], Json).

% dong_tu_temp -> loai_dongtu
dong_tu_temp(List_Input, List_Output, Json) :-
	loai_dongtu(List_Input, List_Output, A),
	atomics_to_string(["'dong_tu_temp':", "{", A, "}"], Json).

% dong_tu_temp -> dongtu_phudinh + loai_dongtu
dong_tu_temp(List_Input, List_Output, Json) :-
	dongtu_phudinh(List_Input, List_Temp, A),
	loai_dongtu(List_Temp, List_Output, B),
	atomics_to_string(["'dong_tu_temp':", "{", A, ",", B, "}"], Json).

% dong_tu_temp -> dongtu_kethop + loai_dongtu
dong_tu_temp(List_Input, List_Output, Json) :-
	dongtu_kethop(List_Input, List_Temp, A),
	loai_dongtu(List_Temp, List_Output, B),
	atomics_to_string(["'dong_tu_temp':", "{", A, ",", B, "}"], Json).

% dong_tu_temp -> dongtu_phudinh + dongtu_kethop + loai_dongtu
dong_tu_temp(List_Input, List_Output, Json) :-
	dongtu_phudinh(List_Input, List_Temp, A),
	dongtu_kethop(List_Temp, List_Temp2, B),
	loai_dongtu(List_Temp2, List_Output, C),
	atomics_to_string(["'dong_tu_temp':", "{", A, ",", B, ",", C, "}"], Json).

% loai_dongtu -> dongtu_chihanhdong
loai_dongtu(List_Input, List_Output, Json) :-
	dongtu_chihanhdong(List_Input, List_Output, A),
	atomics_to_string(["'loai_dongtu':", "{", A, "}"], Json).

% loai_dongtu -> dongtu_chitrangthai
loai_dongtu(List_Input, List_Output, Json) :-
	dongtu_chitrangthai(List_Input, List_Output, A),
	atomics_to_string(["'loai_dongtu':", "{", A, "}"], Json).

% loai_dongtu -> dongtu_dacbiet
loai_dongtu(List_Input, List_Output, Json) :-
	dongtu_dacbiet(List_Input, List_Output, A),
	atomics_to_string(["'loai_dongtu':", "{", A, "}"], Json).

% dongtu_chihanhdong -> dongtu_chihanhdong
dongtu_chihanhdong(List_Input, List_Output, Json) :-
	dongtu_chihanhdong(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'dongtu_chihanhdong':", "'", A, "'"], Json).

% dongtu_chitrangthai -> dongtu_chitrangthai
dongtu_chitrangthai(List_Input, List_Output, Json) :-
	dongtu_chitrangthai(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'dongtu_chitrangthai':", "'", A, "'"], Json).

% dongtu_dacbiet -> dongtu_dacbiet
dongtu_dacbiet(List_Input, List_Output, Json) :-
	dongtu_dacbiet(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'dongtu_dacbiet':", "'", A, "'"], Json).

% dongtu_kethop -> dongtu_kethop
dongtu_kethop(List_Input, List_Output, Json) :-
	dongtu_kethop(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'dongtu_kethop':", "'", A, "'"], Json).

% dongtu_phudinh -> dongtu_phudinh
dongtu_phudinh(List_Input, List_Output, Json) :-
	dongtu_phudinh(List_Input, List_Output),
	sublist(List_Input, N, List_Output),
	atomics_to_string(N,' ',A),
	atomics_to_string(["'dongtu_phudinh':", "'", A, "'"], Json).