:- reconsult('lib.pl').
:- reconsult('danhtu.pl').
:- reconsult('dongtu.pl').
:- reconsult('daitu.pl').
:- reconsult('photu.pl').

% cau_cau_khien -> cum_danh_tu + dongtu_kethop + cau_cau_khien_temp
% return: [[cau_cau_khien, [cum_danh_tu, ...], [dongtu_kethop, ...], [cau_cau_khien_temp, ...]]].
cau_cau_khien(List_Input, List_Output, Phrase) :-
	cum_danh_tu(List_Input, List_Temp, Phrase_A),
	dongtu_kethop(List_Temp, List_Temp2, Phrase_B),
	cau_cau_khien_temp(List_Temp2, List_Output, Phrase_C),
	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C]], Phrase_Temp),
	append_multiple([['cau_cau_khien'], [Phrase_Temp]], Phrase).

% cau_cau_khien -> cau_cau_khien_temp
% return: [[cau_cau_khien, [cau_cau_khien_temp, ...]]].
cau_cau_khien(List_Input, List_Output, Phrase) :-
	cau_cau_khien_temp(List_Input, List_Output, Phrase_A),
	append_multiple([['cau_cau_khien'], [Phrase_A]], Phrase).

% cau_cau_khien_temp -> caucaukhien_tienxuly
% return: [[cau_cau_khien_temp, [caucaukhien_tienxuly, ...]]].
cau_cau_khien_temp(List_Input, List_Output, Phrase) :-
	caucaukhien_tienxuly(List_Input, List_Output, Phrase_A),
	append_multiple([['cau_cau_khien_temp'], [Phrase_A]], Phrase).

% cau_cau_khien_temp -> caucaukhien_tienxuly + trotu_cuoicau
% return: [[cau_cau_khien_temp, [caucaukhien_tienxuly, ...], [trotu_cuoicau, ...]]].
cau_cau_khien_temp(List_Input, List_Output, Phrase) :-
	caucaukhien_tienxuly(List_Input, List_Temp, Phrase_A),
	trotu_cuoicau(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['cau_cau_khien_temp'], [Phrase_Temp]], Phrase).

% cau_cau_khien_temp -> caucaukhien_xulytrungtam + trotu_cuoicau + caucaukhien_daitu
% return: [[cau_cau_khien_temp, [caucaukhien_xulytrungtam, ...], [trotu_cuoicau, ...], [caucaukhien_daitu, ...]]].
cau_cau_khien_temp(List_Input, List_Output, Phrase) :-
	caucaukhien_xulytrungtam(List_Input, List_Temp, Phrase_A),
	trotu_cuoicau(List_Temp, List_Temp2, Phrase_B),
	caucaukhien_daitu(List_Temp2, List_Output, Phrase_C),
	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C]], Phrase_Temp),
	append_multiple([['cau_cau_khien_temp'], [Phrase_Temp]], Phrase).

% cau_cau_khien_temp -> caucaukhien_xulytrungtam + caucaukhien_daitu
% return: [[cau_cau_khien_temp, [caucaukhien_xulytrungtam, ...], [caucaukhien_daitu, ...]]].
cau_cau_khien_temp(List_Input, List_Output, Phrase) :-
	caucaukhien_xulytrungtam(List_Input, List_Temp, Phrase_A),
	caucaukhien_daitu(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['cau_cau_khien_temp'], [Phrase_Temp]], Phrase).

% Phiền maika mở cho tôi bài lạc trôi
% caucaukhien_tienxuly -> phiền + caucaukhien_daitu + caucaukhien_xulytrungtam
% return: [[caucaukhien_tienxuly, [tu_dat_biet, 'phiền'], [caucaukhien_daitu, ...], [caucaukhien_xulytrungtam, ...]]].
caucaukhien_tienxuly(List_Input, List_Output, Phrase) :-
	tu_dat_biet('phiền', List_Input, List_Temp, Phrase_A),
	caucaukhien_daitu(List_Temp, List_Temp2, Phrase_B),
	caucaukhien_xulytrungtam(List_Temp2, List_Output, Phrase_C),
	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C]], Phrase_Temp),
	append_multiple([['caucaukhien_tienxuly'], [Phrase_Temp]], Phrase).

% caucaukhien_tienxuly -> caucaukhien_daitu + caucaukhien_xulytrungtam
% return: [[caucaukhien_tienxuly, [caucaukhien_daitu, ...], [caucaukhien_xulytrungtam, ...]]].
caucaukhien_tienxuly(List_Input, List_Output, Phrase) :-
	caucaukhien_daitu(List_Input, List_Temp, Phrase_A),
	caucaukhien_xulytrungtam(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['caucaukhien_tienxuly'], [Phrase_Temp]], Phrase).

% caucaukhien_tienxuly -> caucaukhien_xulytrungtam
% return: [[caucaukhien_tienxuly, [caucaukhien_xulytrungtam, ...]]].
caucaukhien_tienxuly(List_Input, List_Output, Phrase) :-
	caucaukhien_xulytrungtam(List_Input, List_Output, Phrase_A),
	append_multiple([['caucaukhien_tienxuly'], [Phrase_A]], Phrase).

% caucaukhien_daitu -> danhtu_ten
% return: [[caucaukhien_daitu, [danhtu_ten, ...]]].
caucaukhien_daitu(List_Input, List_Output, Phrase) :-
	danhtu_ten(List_Input, List_Output, Phrase_A),
	append_multiple([['caucaukhien_daitu'], [Phrase_A]], Phrase).

% caucaukhien_daitu -> danhtu_ten + camtu_oi
% return: [[caucaukhien_daitu, [danhtu_ten, ...], [camtu_oi, ...]]].
caucaukhien_daitu(List_Input, List_Output, Phrase) :-
	danhtu_ten(List_Input, List_Temp, Phrase_A),
	camtu_oi(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['caucaukhien_daitu'], [Phrase_Temp]], Phrase).

% caucaukhien_daitu -> daitu_nhanxung_ngoithuhai
% return: [[caucaukhien_daitu, [daitu_nhanxung_ngoithuhai, ...]]].
caucaukhien_daitu(List_Input, List_Output, Phrase) :-
	daitu_nhanxung_ngoithuhai(List_Input, List_Output, Phrase_A),
	append_multiple([['caucaukhien_daitu'], [Phrase_A]], Phrase).

% caucaukhien_xulytrungtam -> cum_dong_tu
% return: [[caucaukhien_xulytrungtam, [cum_dong_tu, ...]]].
caucaukhien_xulytrungtam(List_Input, List_Output, Phrase) :-
	cum_dong_tu(List_Input, List_Output, Phrase_A),
	append_multiple([['caucaukhien_xulytrungtam'], [Phrase_A]], Phrase).

% giúp tôi mở bài lạc trôi
% caucaukhien_xulytrungtam -> giúp + cum_danh_tu
% return: [[caucaukhien_xulytrungtam, [tu_dat_biet, 'giúp'], [cum_danh_tu, ...]]].
caucaukhien_xulytrungtam(List_Input, List_Output, Phrase) :-
	tu_dat_biet('giúp', List_Input, List_Temp, Phrase_A),
	cum_danh_tu(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['caucaukhien_xulytrungtam'], [Phrase_Temp]], Phrase).

% mở giúp/giùm tôi bài lạc trôi
% caucaukhien_xulytrungtam -> dong_tu + photu_giupdo + dai_tu + cum_danh_tu
% return: [[caucaukhien_xulytrungtam, [dong_tu, ...], [photu_giupdo, ...], [dai_tu, ...], [cum_danh_tu, ...]]].
caucaukhien_xulytrungtam(List_Input, List_Output, Phrase) :-
	dong_tu(List_Input, List_Temp, Phrase_A),
	photu_giupdo(List_Temp, List_Temp2, Phrase_B),
	dai_tu(List_Temp2, List_Temp3, Phrase_C),
	cum_danh_tu(List_Temp3, List_Output, Phrase_D),
	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C], [Phrase_D]], Phrase_Temp),
	append_multiple([['caucaukhien_xulytrungtam'], [Phrase_Temp]], Phrase).

% mở giúp/giùm bài lạc trôi
% caucaukhien_xulytrungtam -> dong_tu + photu_giupdo + cum_danh_tu
% return: [[caucaukhien_xulytrungtam, [dong_tu, ...], [photu_giupdo, ...], [cum_danh_tu, ...]]].
caucaukhien_xulytrungtam(List_Input, List_Output, Phrase) :-
	dong_tu(List_Input, List_Temp, Phrase_A),
	photu_giupdo(List_Temp, List_Temp2, Phrase_B),
	cum_danh_tu(List_Temp2, List_Output, Phrase_C),
	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C]], Phrase_Temp),
	append_multiple([['caucaukhien_xulytrungtam'], [Phrase_Temp]], Phrase).

% mở lạc trôi giúp/giùm tôi
% caucaukhien_xulytrungtam -> cum_dong_tu + photu_giupdo + cum_danh_tu
% return: [[caucaukhien_xulytrungtam, [cum_dong_tu, ...], [photu_giupdo, ...], [cum_danh_tu, ...]]].
caucaukhien_xulytrungtam(List_Input, List_Output, Phrase) :-
	cum_dong_tu(List_Input, List_Temp, Phrase_A),
	photu_giupdo(List_Temp, List_Temp2, Phrase_B),
	cum_danh_tu(List_Temp2, List_Output, Phrase_C),
	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C]], Phrase_Temp),
	append_multiple([['caucaukhien_xulytrungtam'], [Phrase_Temp]], Phrase).

% mở lạc trôi giúp/giùm
% caucaukhien_xulytrungtam -> cum_dong_tu + photu_giupdo
% return: [[caucaukhien_xulytrungtam, [cum_dong_tu, ...], [photu_giupdo, ...]]].
caucaukhien_xulytrungtam(List_Input, List_Output, Phrase) :-
	cum_dong_tu(List_Input, List_Temp, Phrase_A),
	photu_giupdo(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['caucaukhien_xulytrungtam'], [Phrase_Temp]], Phrase).

% cho tôi nghe bài lạc trôi
% caucaukhien_xulytrungtam -> tu_dat_biet + cum_danh_tu + cum_dong_tu
% return: [[caucaukhien_xulytrungtam, [tu_dat_biet, cho], [cum_danh_tu, ...], [cum_dong_tu, ...]]].
caucaukhien_xulytrungtam(List_Input, List_Output, Phrase) :-
	tu_dat_biet('cho', List_Input, List_Temp, Phrase_A),
	cum_danh_tu(List_Temp, List_Temp2, Phrase_B),
	cum_dong_tu(List_Temp2, List_Output, Phrase_C),
	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C]], Phrase_Temp),
	append_multiple([['caucaukhien_xulytrungtam'], [Phrase_Temp]], Phrase).

% mở cho tôi nghe bài nhạc
% caucaukhien_xulytrungtam -> dong_tu + tu_dat_biet + cum_danh_tu + cum_dong_tu
% return: [[caucaukhien_xulytrungtam, [dong_tu, ...], [tu_dat_biet, cho], [cum_danh_tu, ...], [cum_dong_tu, ...]]].
caucaukhien_xulytrungtam(List_Input, List_Output, Phrase) :-
	dong_tu(List_Input, List_Temp, Phrase_A),
	tu_dat_biet('cho', List_Temp, List_Temp2, Phrase_B),
	cum_danh_tu(List_Temp2, List_Temp3, Phrase_C),
	cum_dong_tu(List_Temp3, List_Output, Phrase_D),
	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C], [Phrase_D]], Phrase_Temp),
	append_multiple([['caucaukhien_xulytrungtam'], [Phrase_Temp]], Phrase).

% mở bài lạc trôi cho tôi nghe
% caucaukhien_xulytrungtam -> cum_dong_tu + tu_dat_biet + cum_danh_tu
% return: [[caucaukhien_xulytrungtam, [[cum_dong_tu, ...], [tu_dat_biet, cho], [cum_danh_tu, ...]]]].
caucaukhien_xulytrungtam(List_Input, List_Output, Phrase) :-
	cum_dong_tu(List_Input, List_Temp, Phrase_A),
	tu_dat_biet('cho', List_Temp, List_Temp2, Phrase_B),
	cum_danh_tu(List_Temp2, List_Output, Phrase_C),
	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C]], Phrase_Temp),
	append_multiple([['caucaukhien_xulytrungtam'], [Phrase_Temp]], Phrase).

% mở cho tôi bài lạc trôi
% caucaukhien_xulytrungtam -> cum_dong_tu + tu_dat_biet + dai_tu + cum_danh_tu
% return: [[caucaukhien_xulytrungtam, [[cum_dong_tu, ...], [tu_dat_biet, cho], [dai_tu, ...], [cum_danh_tu, ...]]]].
caucaukhien_xulytrungtam(List_Input, List_Output, Phrase) :-
	cum_dong_tu(List_Input, List_Temp, Phrase_A),
	tu_dat_biet('cho', List_Temp, List_Temp2, Phrase_B),
	dai_tu(List_Temp2, List_Temp3, Phrase_C),
	cum_danh_tu(List_Temp3, List_Output, Phrase_D),
	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C], [Phrase_D]], Phrase_Temp),
	append_multiple([['caucaukhien_xulytrungtam'], [Phrase_Temp]], Phrase).
