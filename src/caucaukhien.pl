:- reconsult('lib.pl').
:- reconsult('danhtu.pl').
:- reconsult('dongtu.pl').
:- reconsult('daitu.pl').
:- reconsult('photu.pl').

% cau_cau_khien -> caucaukhien_tienxuly + photu_cuoicau
cau_cau_khien(List_Input, List_Output, Json) :-
	print(' +caucaukhien_tienxuly'),
	caucaukhien_tienxuly(List_Input, List_Temp, A),
	print(' +photu_cuoicau'),
	photu_cuoicau(List_Temp, List_Output, B),
	atomics_to_string(["'cau_cau_khien':", "{", A, ",", B, "}"], Json).

% cau_cau_khien -> caucaukhien_tienxuly
cau_cau_khien(List_Input, List_Output, Json) :-
	print(' +caucaukhien_tienxuly'),
	caucaukhien_tienxuly(List_Input, List_Output, A),
	atomics_to_string(["'cau_cau_khien':", "{", A, "}"], Json).

% cau_cau_khien -> caucaukhien_xulytrungtam + photu_cuoicau + caucaukhien_daitu
cau_cau_khien(List_Input, List_Output, Json) :-
	print(' +caucaukhien_xulytrungtam'),
	caucaukhien_xulytrungtam(List_Input, List_Temp, A),
	print(' +photu_cuoicau'),
	photu_cuoicau(List_Temp, List_Temp2, B),
	print(' +caucaukhien_daitu'),
	caucaukhien_daitu(List_Temp2, List_Output, C),
	atomics_to_string(["'cau_cau_khien':", "{", A, ",", B, ",", C, "}"], Json).

% caucaukhien_tienxuly -> caucaukhien_xulytrungtam + caucaukhien_daitu
cau_cau_khien(List_Input, List_Output, Json) :-
	print(' +caucaukhien_xulytrungtam'),
	caucaukhien_xulytrungtam(List_Input, List_Temp, A),
	print(' +caucaukhien_daitu'),
	caucaukhien_daitu(List_Temp, List_Output, B),
	atomics_to_string(["'cau_cau_khien':", "{", A, ",", B, "}"], Json).

% caucaukhien_tienxuly -> caucaukhien_daitu + caucaukhien_xulytrungtam
caucaukhien_tienxuly(List_Input, List_Output, Json) :-
	print(' +caucaukhien_daitu'),
	caucaukhien_daitu(List_Input, List_Temp, A),
	print(' +caucaukhien_xulytrungtam'),
	caucaukhien_xulytrungtam(List_Temp, List_Output, B),
	atomics_to_string(["'caucaukhien_tienxuly':", "{", A, ",", B, "}"], Json).

% Phiền maika mở cho tôi bài lạc trôi
% caucaukhien_tienxuly -> phien + caucaukhien_daitu + caucaukhien_xulytrungtam
caucaukhien_tienxuly(List_Input, List_Output, Json) :-
	print(' +phiền'),
	delete_first_list('706869e1bb816e', List_Input, List_Temp), % 706869e1bb816e : phiền
	atomics_to_string(["'phien':", "'706869e1bb816e'"], A),
	print(' +caucaukhien_daitu'),
	caucaukhien_daitu(List_Temp, List_Temp2, B),
	print(' +caucaukhien_xulytrungtam'),
	caucaukhien_xulytrungtam(List_Temp2, List_Output, C),
	atomics_to_string(["'caucaukhien_tienxuly':", "{", A, ",", B, ",", C, "}"], Json).

% caucaukhien_tienxuly -> caucaukhien_xulytrungtam
caucaukhien_tienxuly(List_Input, List_Output, Json) :-
	print(' +caucaukhien_xulytrungtam'),
	caucaukhien_xulytrungtam(List_Input, List_Output, A),
	atomics_to_string(["'caucaukhien_tienxuly':", "{", A, "}"], Json).

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

% mở cho tôi bài lạc trôi
% caucaukhien_xulytrungtam -> dong_tu + cho + cum_danh_tu + cum_danh_tu
caucaukhien_xulytrungtam(List_Input, List_Output, Json) :-
	print(' +dong_tu'),
	dong_tu(List_Input, List_Temp, A),
	print(' +cho'),
	delete_first_list('63686f', List_Temp, List_Temp2), % 63686f : cho
	atomics_to_string(["'cho':", "'63686f'"], B),
	print(' +cum_danh_tu'),
	cum_danh_tu(List_Temp2, List_Temp3, C),
	print(' +cum_danh_tu'),
	cum_danh_tu(List_Temp3, List_Output, D),
	atomics_to_string(["'caucaukhien_xulytrungtam':", "{", A, ",", B, ",", C, ",", D, "}"], Json).

% mở cho tôi nghe bài lạc trôi
% caucaukhien_xulytrungtam -> dong_tu + cho + cum_danh_tu + cum_dong_tu
caucaukhien_xulytrungtam(List_Input, List_Output, Json) :-
	print(' +dong_tu'),
	dong_tu(List_Input, List_Temp, A),
	print(' +cho'),
	delete_first_list('63686f', List_Temp, List_Temp2), % 63686f : cho
	atomics_to_string(["'cho':", "'63686f'"], B),
	print(' +cum_danh_tu'),
	cum_danh_tu(List_Temp2, List_Temp3, C),
	print(' +cum_dong_tu'),
	cum_dong_tu(List_Temp3, List_Output, D),
	atomics_to_string(["'caucaukhien_xulytrungtam':", "{", A, ",", B, ",", C, ",", D, "}"], Json).

% mở bài lạc trôi cho tôi nghe
% caucaukhien_xulytrungtam -> cum_dong_tu + cho + cum_danh_tu + dong_tu
caucaukhien_xulytrungtam(List_Input, List_Output, Json) :-
	print(' +cum_dong_tu'),
	cum_dong_tu(List_Input, List_Temp, A),
	print(' +cho'),
	delete_first_list('63686f', List_Temp, List_Temp2), % 63686f : cho
	atomics_to_string(["'cho':", "'63686f'"], B),
	print(' +cum_danh_tu'),
	cum_danh_tu(List_Temp2, List_Temp3, C),
	print(' +dong_tu'),
	dong_tu(List_Temp3, List_Output, D),
	atomics_to_string(["'caucaukhien_xulytrungtam':", "{", A, ",", B, ",", C, ",", D, "}"], Json).

% cho tôi nghe bài lạc trôi
% caucaukhien_xulytrungtam -> cho + cum_danh_tu + cum_dong_tu
caucaukhien_xulytrungtam(List_Input, List_Output, Json) :-
	print(' +cho'),
	delete_first_list('63686f', List_Input, List_Temp), % 63686f : cho
	atomics_to_string(["'cho':", "'63686f'"], A),
	print(' +cum_danh_tu'),
	cum_danh_tu(List_Temp, List_Temp2, B),
	print(' +cum_dong_tu'),
	cum_dong_tu(List_Temp2, List_Output, C),
	atomics_to_string(["'caucaukhien_xulytrungtam':", "{", A, ",", B, ",", C, "}"], Json).

% caucaukhien_xulytrungtam -> cum_dong_tu
caucaukhien_xulytrungtam(List_Input, List_Output, Json) :-
	print(' +cum_dong_tu'),
	cum_dong_tu(List_Input, List_Output, A),
	atomics_to_string(["'caucaukhien_xulytrungtam':", "{", A, "}"], Json).

% Giúp tôi mở bài lạc trôi
% caucaukhien_xulytrungtam -> giup + cum_danh_tu + cum_dong_tu
caucaukhien_xulytrungtam(List_Input, List_Output, Json) :-
	print(' +giúp'),
	delete_first_list('6769c3ba70', List_Input, List_Temp), % 6769c3ba70 : giúp
	atomics_to_string(["'giup':", "'6769c3ba70'"], A),
	print(' +cum_danh_tu'),
	cum_danh_tu(List_Temp, List_Temp2, B),
	print(' +cum_dong_tu'),
	cum_dong_tu(List_Temp2, List_Output, C),
	atomics_to_string(["'caucaukhien_xulytrungtam':", "{", A, ",", B, ",", C, "}"], Json).

% mở giúp/giùm tôi bài lạc trôi
% caucaukhien_xulytrungtam -> dong_tu + photu_giupdo + cum_danh_tu + cum_danh_tu
caucaukhien_xulytrungtam(List_Input, List_Output, Json) :-
	print(' +dong_tu'),
	dong_tu(List_Input, List_Temp, A),
	print(' +photu_giupdo'),
	photu_giupdo(List_Temp, List_Temp2, B),
	print(' +cum_danh_tu'),
	cum_danh_tu(List_Temp2, List_Temp3, C),
	print(' +cum_danh_tu'),
	cum_danh_tu(List_Temp3, List_Output, D),
	atomics_to_string(["'caucaukhien_xulytrungtam':", "{", A, ",", B, ",", C, ",", D, "}"], Json).

% mở bài lạc trôi giúp tôi
% caucaukhien_xulytrungtam -> cum_dong_tu + photu_giupdo + cum_danh_tu
caucaukhien_xulytrungtam(List_Input, List_Output, Json) :-
	print(' +cum_dong_tu'),
	cum_dong_tu(List_Input, List_Temp, A),
	print(' +photu_giupdo'),
	photu_giupdo(List_Temp, List_Temp2, B),
	print(' +cum_danh_tu'),
	cum_danh_tu(List_Temp2, List_Output, C),
	atomics_to_string(["'caucaukhien_xulytrungtam':", "{", A, ",", B, ",", C, "}"], Json).