% tinhtu_chimucdo -> tinhtu_chimucdo
% return: [[tinhtu_chimucdo, '']]
tinhtu_chimucdo(List_Input, List_Output, Phrase) :-
	tinhtu_chimucdo(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['tinhtu_chimucdo'], [Word]], Phrase).


% caucaukhien_tienxuly -> phiền + caucaukhien_daitu + caucaukhien_xulytrungtam
% return: [[caucaukhien_tienxuly, [tu_dat_biet, 'phiền'], [caucaukhien_daitu, ...], [caucaukhien_xulytrungtam, ...]]].
caucaukhien_tienxuly(List_Input, List_Output, Phrase) :-
	tu_dat_biet('phiền', List_Input, List_Temp, Phrase_A),
	caucaukhien_daitu(List_Temp, List_Temp2, Phrase_B),
	caucaukhien_xulytrungtam(List_Temp2, List_Output, Phrase_C),
	append_multiple([['caucaukhien_tienxuly'], [Phrase_A], [Phrase_B], [Phrase_C]], Phrase).




% test(['6361', '73c4a9', '6275e1bb936e'],[],P).
test(List_Input, List_Output, Phrase) :-
	danhtu_chinguoi(List_Input, List_Temp, Phrase_A),
	dongtu_chitrangthai(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['test'], [Phrase_Temp]], Phrase).

	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['test'], [Phrase_Temp]], Phrase).

	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C]], Phrase_Temp),
	append_multiple([['test'], [Phrase_Temp]], Phrase).

	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C], [Phrase_D]], Phrase_Temp),
	append_multiple([['test'], [Phrase_Temp]], Phrase).


% cam_tu -> camtu_oi
% return: [[cam_tu, [camtu_oi, ...]]].
cam_tu(List_Input, List_Output, Phrase) :-
	camtu_oi(List_Input, List_Output, Phrase_A),
	append_multiple([['cam_tu'], [Phrase_A]], Phrase).

% cau_cau_khien_temp -> caucaukhien_tienxuly + trotu_cuoicau
% return: [[cau_cau_khien_temp, [caucaukhien_tienxuly, ...], [trotu_cuoicau, ...]]].
cau_cau_khien_temp(List_Input, List_Output, Phrase) :-
	caucaukhien_tienxuly(List_Input, List_Temp, Phrase_A),
	trotu_cuoicau(List_Temp, List_Output, Phrase_B),
	append_multiple([['cau_cau_khien_temp'], [Phrase_A], [Phrase_B]], Phrase).

% cau_cau_khien -> cum_danh_tu + dongtu_kethop + cau_cau_khien_temp
% return: [[cau_cau_khien, [cum_danh_tu, ...], [dongtu_kethop, ...], [cau_cau_khien_temp, ...]]].
cau_cau_khien(List_Input, List_Output, Phrase) :-
	cum_danh_tu(List_Input, List_Temp, Phrase_A),
	dongtu_kethop(List_Temp, List_Temp2, Phrase_B),
	cau_cau_khien_temp(List_Temp2, List_Output, Phrase_C),
	append_multiple([['cau_cau_khien'], [Phrase_A], [Phrase_B], [Phrase_C]], Phrase).

% caucaukhien_xulytrungtam -> dong_tu + photu_giupdo + cum_danh_tu + cum_danh_tu
% return: [[caucaukhien_xulytrungtam, [dong_tu, ...], [photu_giupdo, ...], [cum_danh_tu, ...], [cum_danh_tu, ...]]].
caucaukhien_xulytrungtam(List_Input, List_Output, Phrase) :-
	dong_tu(List_Input, List_Temp, Phrase_A),
	photu_giupdo(List_Temp, List_Temp2, Phrase_B),
	cum_danh_tu(List_Temp2, List_Temp3, Phrase_C),
	cum_danh_tu(List_Temp3, List_Output, Phrase_D),
	append_multiple([['caucaukhien_xulytrungtam'], [Phrase_A], [Phrase_B], [Phrase_C], [Phrase_D]], Phrase).





