% mở giùm bài nhạc này
% mở giùm tao bài nhạc này
% mở giùm tao bài nhạc này không
% mở giùm tao bài nhạc này được không
% mở giùm tao bài nhạc này coi
% mở giùm tao bài nhạc này đi
% có thể mở giùm tao bài nhạc này không
% Làm ơn mở giùm tao bài nhạc này
% mở bài nhạc này nhanh lên
% mở bài nhạc này ngay lập tức
% phiền mày mở giúp tao bài nhạc này đi mà
% mở bài nhạc này
% mở bài nhạc này không
% mở nhạc

% bạn mở nhạc đi
% mày mở nhạc
% Maika mở nhạc

:- reconsult('lib.pl').
:- reconsult('danhtu.pl').
:- reconsult('dongtu.pl').
:- reconsult('daitu.pl').
:- reconsult('photu.pl').

% cau_cau_khien -> caucaukhien_daitu + caucaukhien_hauxuly
cau_cau_khien(List_Input, List_Output, Json) :-
	print(' +caucaukhien_daitu'),
	caucaukhien_daitu(List_Input, List_Temp, A),
	print(' +caucaukhien_hauxuly'),
	caucaukhien_hauxuly(List_Temp, List_Output, B),
	atomics_to_string(["'cau_cau_khien':", "{", A, ",", B, "}"], Json).

% cau_cau_khien -> cum_dong_tu + photu_cuoicau + caucaukhien_daitu
cau_cau_khien(List_Input, List_Output, Json) :-
	print(' +cum_dong_tu'),
	cum_dong_tu(List_Input, List_Temp, A),
	print(' +photu_cuoicau'),
	photu_cuoicau(List_Temp, List_Temp2, B),
	print(' +caucaukhien_daitu'),
	caucaukhien_daitu(List_Temp2, List_Output, C),
	atomics_to_string(["'cau_cau_khien':", "{", A, ",", B, ",", C, "}"], Json).

% cau_cau_khien -> caucaukhien_hauxuly
cau_cau_khien(List_Input, List_Output, Json) :-
	print(' +caucaukhien_hauxuly'),
	caucaukhien_hauxuly(List_Input, List_Output, A),
	atomics_to_string(["'cau_cau_khien':", "{", A, "}"], Json).

% caucaukhien_daitu -> danhtu_ten
caucaukhien_daitu(List_Input, List_Output, Json) :-
	print(' +danhtu_ten'),
	danhtu_ten(List_Input, List_Output, A),
	atomics_to_string(["'caucaukhien_daitu':", "{", A, "}"], Json).

% caucaukhien_daitu -> danhtu_ten + camtu_oi
caucaukhien_daitu(List_Input, List_Output, Json) :-
	print(' +danhtu_ten'),
	danhtu_ten(List_Input, List_Temp, A),
	print(' +cam_tu'),
	camtu_oi(List_Temp, List_Output, B),
	atomics_to_string(["'caucaukhien_daitu':", "{", A, ",", B, "}"], Json).

% cau_cau_khien -> daitu_nhanxung_ngoithuhai
caucaukhien_daitu(List_Input, List_Output, Json) :-
	print(' +daitu_nhanxung_ngoithuhai'),
	daitu_nhanxung_ngoithuhai(List_Input, List_Output, A),
	atomics_to_string(["'caucaukhien_daitu':", "{", A, "}"], Json).

% caucaukhien_hauxuly -> cum_dong_tu + photu_cuoicau
caucaukhien_hauxuly(List_Input, List_Output, Json) :-
	print(' +cum_dong_tu'),
	cum_dong_tu(List_Input, List_Temp, A),
	print(' +photu_cuoicau'),
	photu_cuoicau(List_Temp, List_Output, B),
	atomics_to_string(["'caucaukhien_hauxuly':", "{", A, ",", B, "}"], Json).

% caucaukhien_hauxuly -> cum_dong_tu
caucaukhien_hauxuly(List_Input, List_Output, Json) :-
	print(' +cum_dong_tu'),
	cum_dong_tu(List_Input, List_Output, A),
	atomics_to_string(["'caucaukhien_hauxuly':", "{", A, "}"], Json).

% caucaukhien_hauxuly -> dong_tu
caucaukhien_hauxuly(List_Input, List_Output, Json) :-
	print(' +dong_tu'),
	dong_tu(List_Input, List_Output, A),
	atomics_to_string(["'caucaukhien_hauxuly':", "{", A, "}"], Json).
