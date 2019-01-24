:- reconsult('lib.pl').
:- reconsult('../tuvung/tuvung_dongtu.pl').
:- reconsult('../tuvung/tuvung_dongtu_encoded.pl').

% cum_dong_tu -> dong_tu
% return: [[cum_dong_tu, [dong_tu, ...]]].
cum_dong_tu(List_Input, List_Output, Phrase) :-
	dong_tu(List_Input, List_Output, Phrase_A),
	append_multiple([['cum_dong_tu'], [Phrase_A]], Phrase).

% cum_dong_tu -> dong_tu + cum_danh_tu
% return: [[cum_dong_tu, [dong_tu, ...], [cum_danh_tu, ...]]].
cum_dong_tu(List_Input, List_Output, Phrase) :-
	dong_tu(List_Input, List_Temp, Phrase_A),
	cum_danh_tu(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['cum_dong_tu'], [Phrase_Temp]], Phrase).

% cum_dong_tu -> dong_tu + bởi + cumtu_dacbiet
% return: [[cum_dong_tu, [dong_tu, 'phiền'], [tu_dat_biet, 'bởi'], [cumtu_dacbiet, ...]]].
cum_dong_tu(List_Input, List_Output, Phrase) :-
	dong_tu(List_Input, List_Temp, Phrase_A),
	tu_dat_biet('bởi', List_Temp, List_Temp2, Phrase_B),
	cumtu_dacbiet(List_Temp2, List_Output, Phrase_C),
	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C]], Phrase_Temp),
	append_multiple([['cum_dong_tu'], [Phrase_Temp]], Phrase).

% trình bày bởi ca sĩ sơn tùng mtp
% cum_dong_tu -> dong_tu + bởi + cum_danh_tu + cumtu_dacbiet
% return: [[cum_dong_tu, [dong_tu, ...], [tu_dat_biet, bởi], [cum_danh_tu, ...], [cumtu_dacbiet, ...]]].
cum_dong_tu(List_Input, List_Output, Phrase) :-
	dong_tu(List_Input, List_Temp, Phrase_A),
	tu_dat_biet('bởi', List_Temp, List_Temp2, Phrase_B),
	danh_tu(List_Temp2, List_Temp3, Phrase_C),
	cumtu_dacbiet(List_Temp3, List_Output, Phrase_D),
	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C], [Phrase_D]], Phrase_Temp),
	append_multiple([['cum_dong_tu'], [Phrase_Temp]], Phrase).

% dong_tu -> dong_tu_temp
% return: [[dong_tu, [dong_tu_temp, ...]]].
dong_tu(List_Input, List_Output, Phrase) :-
	dong_tu_temp(List_Input, List_Output, Phrase_A),
	append_multiple([['dong_tu'], [Phrase_A]], Phrase).

% dong_tu -> photu_truoc + dong_tu_temp
% return: [[dong_tu, [photu_truoc, ...], [dong_tu_temp, ...]]].
dong_tu(List_Input, List_Output, Phrase) :-
	photu_truoc(List_Input, List_Temp, Phrase_A),
	dong_tu_temp(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['dong_tu'], [Phrase_Temp]], Phrase).

% dong_tu_temp -> loai_dongtu
% return: [[dong_tu_temp, [loai_dongtu, ...]]].
dong_tu_temp(List_Input, List_Output, Phrase) :-
	loai_dongtu(List_Input, List_Output, Phrase_A),
	append_multiple([['dong_tu_temp'], [Phrase_A]], Phrase).

% dong_tu_temp -> dongtu_phudinh + loai_dongtu
% return: [[dong_tu_temp, [dongtu_phudinh, ...], [loai_dongtu, ...]]].
dong_tu_temp(List_Input, List_Output, Phrase) :-
	dongtu_phudinh(List_Input, List_Temp, Phrase_A),
	loai_dongtu(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['dong_tu_temp'], [Phrase_Temp]], Phrase).

% dong_tu_temp -> dongtu_kethop + loai_dongtu
% return: [[dong_tu_temp, [dongtu_kethop, ...], [loai_dongtu, ...]]].
dong_tu_temp(List_Input, List_Output, Phrase) :-
	dongtu_kethop(List_Input, List_Temp, Phrase_A),
	loai_dongtu(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['dong_tu_temp'], [Phrase_Temp]], Phrase).

% dong_tu_temp -> dongtu_phudinh + dongtu_kethop + loai_dongtu
% return: [[dong_tu_temp, [dongtu_phudinh, ...], [dongtu_kethop, ...], [loai_dongtu, ...]]].
dong_tu_temp(List_Input, List_Output, Phrase) :-
	dongtu_phudinh(List_Input, List_Temp, Phrase_A),
	dongtu_kethop(List_Temp, List_Temp2, Phrase_B),
	loai_dongtu(List_Temp2, List_Output, Phrase_C),
	append_multiple([[Phrase_A], [Phrase_B], [Phrase_C]], Phrase_Temp),
	append_multiple([['dong_tu_temp'], [Phrase_Temp]], Phrase).

% loai_dongtu -> dongtu_chihanhdong
% return: [[loai_dongtu, [dongtu_chihanhdong, ...]]].
loai_dongtu(List_Input, List_Output, Phrase) :-
	dongtu_chihanhdong(List_Input, List_Output, Phrase_A),
	append_multiple([['loai_dongtu'], [Phrase_A]], Phrase).

% loai_dongtu -> dongtu_chitrangthai
% return: [[loai_dongtu, [dongtu_chitrangthai, ...]]].
loai_dongtu(List_Input, List_Output, Phrase) :-
	dongtu_chitrangthai(List_Input, List_Output, Phrase_A),
	append_multiple([['loai_dongtu'], [Phrase_A]], Phrase).

% loai_dongtu -> dongtu_dacbiet
% return: [[loai_dongtu, [dongtu_dacbiet, ...]]].
loai_dongtu(List_Input, List_Output, Phrase) :-
	dongtu_dacbiet(List_Input, List_Output, Phrase_A),
	append_multiple([['loai_dongtu'], [Phrase_A]], Phrase).

% dongtu_chihanhdong -> dongtu_chihanhdong
% return: [[dongtu_chihanhdong, '']]
dongtu_chihanhdong(List_Input, List_Output, Phrase) :-
	dongtu_chihanhdong(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['dongtu_chihanhdong'], [Word]], Phrase).

% dongtu_chitrangthai -> dongtu_chitrangthai
% return: [[dongtu_chitrangthai, '']]
dongtu_chitrangthai(List_Input, List_Output, Phrase) :-
	dongtu_chitrangthai(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['dongtu_chitrangthai'], [Word]], Phrase).

% dongtu_dacbiet -> dongtu_dacbiet
% return: [[dongtu_dacbiet, '']]
dongtu_dacbiet(List_Input, List_Output, Phrase) :-
	dongtu_dacbiet(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['dongtu_dacbiet'], [Word]], Phrase).

% dongtu_kethop -> dongtu_kethop
% return: [[dongtu_kethop, '']]
dongtu_kethop(List_Input, List_Output, Phrase) :-
	dongtu_kethop(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['dongtu_kethop'], [Word]], Phrase).

% dongtu_phudinh -> dongtu_phudinh
% return: [[dongtu_phudinh, '']]
dongtu_phudinh(List_Input, List_Output, Phrase) :-
	dongtu_phudinh(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['dongtu_phudinh'], [Word]], Phrase).