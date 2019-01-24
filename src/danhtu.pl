:- reconsult('lib.pl').
:- reconsult('../src/cache.pl').
:- reconsult('../tuvung/tuvung_danhtu.pl').
:- reconsult('../tuvung/tuvung_danhtu_encoded.pl').

% cum_danh_tu -> cumdanhtu1_temp
% return: [[cum_danh_tu, [cumdanhtu1_temp, ...]]].
cum_danh_tu(List_Input, List_Output, Phrase) :-
	cumdanhtu1_temp(List_Input, List_Output, Phrase_A),
	append_multiple([['cum_danh_tu'], [Phrase_A]], Phrase).

% cum_danh_tu -> cumdanhtu1_temp + cum_dong_tu
% return: [[cum_danh_tu, [cumdanhtu1_temp, ...], [cum_dong_tu, ...]]].
cum_danh_tu(List_Input, List_Output, Phrase) :-
	cumdanhtu1_temp(List_Input, List_Temp, Phrase_A),
	cum_dong_tu(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['cum_danh_tu'], [Phrase_Temp]], Phrase).

% cumdanhtu1_temp -> cumdanhtu2_temp
% return: [[cumdanhtu1_temp, [cumdanhtu2_temp, ...]]].
cumdanhtu1_temp(List_Input, List_Output, Phrase) :-
	cumdanhtu2_temp(List_Input, List_Output, Phrase_A),
	append_multiple([['cumdanhtu1_temp'], [Phrase_A]], Phrase).

% cumdanhtu1_temp -> cumdanhtu2_temp + so_huu
% return: [[cumdanhtu1_temp, [cumdanhtu2_temp, ...], [so_huu, ...]]].
cumdanhtu1_temp(List_Input, List_Output, Phrase) :-
	cumdanhtu2_temp(List_Input, List_Temp, Phrase_A),
	so_huu(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['cumdanhtu1_temp'], [Phrase_Temp]], Phrase).

% cumdanhtu2_temp -> dai_tu
% return: [[cumdanhtu2_temp, [dai_tu, ...]]].
cumdanhtu2_temp(List_Input, List_Output, Phrase) :-
	dai_tu(List_Input, List_Output, Phrase_A),!,
	append_multiple([['cumdanhtu2_temp'], [Phrase_A]], Phrase).

% cumdanhtu2_temp -> danh_tu
% return: [[cumdanhtu2_temp, [danh_tu, ...]]].
cumdanhtu2_temp(List_Input, List_Output, Phrase) :-
	danh_tu(List_Input, List_Output, Phrase_A),
	append_multiple([['cumdanhtu2_temp'], [Phrase_A]], Phrase).

% cumdanhtu2_temp -> danh_tu + tinh_tu
% return: [[cumdanhtu2_temp, [danh_tu, ...], [tinh_tu, ...]]].
cumdanhtu2_temp(List_Input, List_Output, Phrase) :-
	danh_tu(List_Input, List_Temp, Phrase_A),
	tinh_tu(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['cumdanhtu2_temp'], [Phrase_Temp]], Phrase).

cumtu_dacbiet_temp([_|B], B).
cumtu_dacbiet_temp([_|B], C) :-
	cumtu_dacbiet_temp(B, C).

% cumtu_dacbiet
cumtu_dacbiet(List_Input, List_Output, Phrase) :-
	cumtu_dacbiet_temp(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Phrase_Temp),
	atomics_to_string(["'", Phrase_Temp, "'"], Phrase_A),
	append_multiple([['cumtu_dacbiet'], [Phrase_A]], Phrase).

% danh_tu -> danh_tu_loop
% return: [[danh_tu, [danh_tu_loop, ...]]].
danh_tu(List_Input, List_Output, Phrase) :-
	danh_tu_loop(List_Input, List_Output, Phrase_A),
	append_multiple([['danh_tu'], [Phrase_A]], Phrase).

% danh_tu -> maotu_dacbiet + cumtu_dacbiet
% return: [[danh_tu, [maotu_dacbiet, ...], [cumtu_dacbiet, ...]]].
danh_tu(List_Input, List_Output, Phrase) :-
	maotu_dacbiet(List_Input, List_Temp, Phrase_A),
	cumtu_dacbiet(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['danh_tu'], [Phrase_Temp]], Phrase).

% danh_tu -> cumtu_dacbiet
% return: [[danh_tu, [cumtu_dacbiet, ...]]].
danh_tu(List_Input, List_Output, Phrase) :-
	cumtu_dacbiet(List_Input, List_Output, Phrase_A),
	append_multiple([['danh_tu'], [Phrase_A]], Phrase).

% danh_tu -> danh_tu_loop + cumtu_dacbiet
% return: [[danh_tu, [danh_tu_loop, ...], [cumtu_dacbiet, ...]]].
danh_tu(List_Input, List_Output, Phrase) :-
	danh_tu_loop(List_Input, List_Temp, Phrase_A),
	cumtu_dacbiet(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['danh_tu'], [Phrase_Temp]], Phrase).

danh_tu_loop_temp() :-
	nb_getval(danh_tu_loop_list_input, List_Input),
	danh_tu1_temp(List_Input, List_Temp, Phrase_A),
	nb_getval(danh_tu_loop_phrase, List_Phrase_Temp),
	(
		List_Phrase_Temp == [] -> Phrase = [Phrase_A];
		List_Phrase_Temp \== [] -> append_multiple([[Phrase_A], List_Phrase_Temp], Phrase)
	),
	nb_setval(danh_tu_loop_list_output, List_Temp),
	nb_setval(danh_tu_loop_list_input, List_Temp),
	nb_setval(danh_tu_loop_phrase, Phrase).
	
% danh_tu_loop -> danh_tu1_temp + ...	
danh_tu_loop(List_Input, List_Output, Phrase) :-
	nb_setval(danh_tu_loop_list_input, List_Input),
	nb_setval(danh_tu_loop_list_output, []),
	nb_setval(danh_tu_loop_phrase, []),
	repeat,
	(
		not(call(danh_tu_loop_temp)),!
	),
	nb_getval(danh_tu_loop_list_output, List_Output),
	nb_getval(danh_tu_loop_phrase, Phrase_Temp),
	length(Phrase_Temp, L),
	(
		L == 1 -> [Phrase] = Phrase_Temp;
		L \== 1 -> Phrase = Phrase_Temp
	),
	(
		Phrase == [] -> fail;
		Phrase \== [] -> !
	).

% danh_tu1_temp -> maotu_dacbiet + cache_nhac
% return: [[danh_tu1_temp, [maotu_dacbiet, ...], [cache_nhac, ...]]].
danh_tu1_temp(List_Input, List_Output, Phrase) :-
	maotu_dacbiet(List_Input, List_Temp, Phrase_A),
	cache_nhac(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['danh_tu1_temp'], [Phrase_Temp]], Phrase).

% danh_tu1_temp -> cache_nhac
% return: [[danh_tu1_temp, [cache_nhac, ...]]].
danh_tu1_temp(List_Input, List_Output, Phrase) :-
	cache_nhac(List_Input, List_Output, Phrase_A),
	append_multiple([['danh_tu1_temp'], [Phrase_A]], Phrase).

% danh_tu1_temp -> cache_ten
% return: [[danh_tu1_temp, [cache_ten, ...]]].
danh_tu1_temp(List_Input, List_Output, Phrase) :-
	cache_ten(List_Input, List_Output, Phrase_A),
	append_multiple([['danh_tu1_temp'], [Phrase_A]], Phrase).

% danh_tu1_temp -> danhtu_ten
% return: [[danh_tu1_temp, [danhtu_ten, ...]]].
danh_tu1_temp(List_Input, List_Output, Phrase) :-
	danhtu_ten(List_Input, List_Output, Phrase_A),
	append_multiple([['danh_tu1_temp'], [Phrase_A]], Phrase).

% danh_tu1_temp -> danhtu_rieng
% return: [[danh_tu1_temp, [danhtu_rieng, ...]]].
danh_tu1_temp(List_Input, List_Output, Phrase) :-
	danhtu_rieng(List_Input, List_Output, Phrase_A),
	append_multiple([['danh_tu1_temp'], [Phrase_A]], Phrase).

% danh_tu1_temp -> danhtu_demduoc
% return: [[danh_tu1_temp, [danhtu_demduoc, ...]]].
danh_tu1_temp(List_Input, List_Output, Phrase) :-
	danhtu_demduoc(List_Input, List_Output, Phrase_A),
	append_multiple([['danh_tu1_temp'], [Phrase_A]], Phrase).

% danh_tu1_temp -> danhtu_khongdemduoc
% return: [[danh_tu1_temp, [danhtu_khongdemduoc, ...]]].
danh_tu1_temp(List_Input, List_Output, Phrase) :-
	danhtu_khongdemduoc(List_Input, List_Output, Phrase_A),
	append_multiple([['danh_tu1_temp'], [Phrase_A]], Phrase).

% danhtu_demduoc -> danhtu_chinguoi
% return: [[danhtu_demduoc, [danhtu_chinguoi, ...]]].
danhtu_demduoc(List_Input, List_Output, Phrase) :-
	danhtu_chinguoi(List_Input, List_Output, Phrase_A),
	append_multiple([['danhtu_demduoc'], [Phrase_A]], Phrase).

% danhtu_demduoc -> danhtu_chicaycoi
% return: [[danhtu_demduoc, [danhtu_chicaycoi, ...]]].
danhtu_demduoc(List_Input, List_Output, Phrase) :-
	danhtu_chicaycoi(List_Input, List_Output, Phrase_A),
	append_multiple([['danhtu_demduoc'], [Phrase_A]], Phrase).

% danhtu_demduoc -> loai_maotu + danhtu_chicaycoi
% return: [[danhtu_demduoc, [loai_maotu, ...], [danhtu_chicaycoi, ...]]].
danhtu_demduoc(List_Input, List_Output, Phrase) :-
	loai_maotu(List_Input, List_Temp, Phrase_A),
	danhtu_chicaycoi(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['danhtu_demduoc'], [Phrase_Temp]], Phrase).

% danhtu_demduoc -> danhtu_chidovat
% return: [[danhtu_demduoc, [danhtu_chidovat, ...]]].
danhtu_demduoc(List_Input, List_Output, Phrase) :-
	danhtu_chidovat(List_Input, List_Output, Phrase_A),
	append_multiple([['danhtu_demduoc'], [Phrase_A]], Phrase).

% danhtu_demduoc -> loai_maotu + danhtu_chidovat
% return: [[danhtu_demduoc, [loai_maotu, ...], [danhtu_chidovat, ...]]].
danhtu_demduoc(List_Input, List_Output, Phrase) :-
	loai_maotu(List_Input, List_Temp, Phrase_A),
	danhtu_chidovat(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['danhtu_demduoc'], [Phrase_Temp]], Phrase).

% danhtu_demduoc -> danhtu_chiconvat
% return: [[danhtu_demduoc, [danhtu_chiconvat, ...]]].
danhtu_demduoc(List_Input, List_Output, Phrase) :-
	danhtu_chiconvat(List_Input, List_Output, Phrase_A),
	append_multiple([['danhtu_demduoc'], [Phrase_A]], Phrase).

% danhtu_demduoc -> loai_maotu + danhtu_chiconvat
% return: [[danhtu_demduoc, [loai_maotu, ...], [danhtu_chiconvat, ...]]].
danhtu_demduoc(List_Input, List_Output, Phrase) :-
	loai_maotu(List_Input, List_Temp, Phrase_A),
	danhtu_chiconvat(List_Temp, List_Output, Phrase_B),
	append_multiple([[Phrase_A], [Phrase_B]], Phrase_Temp),
	append_multiple([['danhtu_demduoc'], [Phrase_Temp]], Phrase).

% danhtu_demduoc -> danhtuchung_demduoc
% return: [[danhtu_demduoc, [danhtuchung_demduoc, ...]]].
danhtu_demduoc(List_Input, List_Output, Phrase) :-
	danhtuchung_demduoc(List_Input, List_Output, Phrase_A),
	append_multiple([['danhtu_demduoc'], [Phrase_A]], Phrase).

% danhtu_ten -> danhtu_ten
% return: [[danhtu_ten, '']]
danhtu_ten(List_Input, List_Output, Phrase) :-
	danhtu_ten(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['danhtu_ten'], [Word]], Phrase).

% danhtu_rieng -> danhtu_rieng
% return: [[danhtu_rieng, '']]
danhtu_rieng(List_Input, List_Output, Phrase) :-
	danhtu_rieng(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['danhtu_rieng'], [Word]], Phrase).

% danhtu_chinguoi -> danhtu_chinguoi
% return: [[danhtu_chinguoi, '']]
danhtu_chinguoi(List_Input, List_Output, Phrase) :-
	danhtu_chinguoi(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['danhtu_chinguoi'], [Word]], Phrase).

% danhtu_chicaycoi -> danhtu_chicaycoi
% return: [[danhtu_chicaycoi, '']]
danhtu_chicaycoi(List_Input, List_Output, Phrase) :-
	danhtu_chicaycoi(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['danhtu_chicaycoi'], [Word]], Phrase).

% danhtu_chidovat -> danhtu_chidovat
% return: [[danhtu_chidovat, '']]
danhtu_chidovat(List_Input, List_Output, Phrase) :-
	danhtu_chidovat(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['danhtu_chidovat'], [Word]], Phrase).

% danhtu_chiconvat -> danhtu_chiconvat
% return: [[danhtu_chiconvat, '']]
danhtu_chiconvat(List_Input, List_Output, Phrase) :-
	danhtu_chiconvat(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['danhtu_chiconvat'], [Word]], Phrase).

% danhtuchung_demduoc -> danhtuchung_demduoc
% return: [[danhtuchung_demduoc, '']]
danhtuchung_demduoc(List_Input, List_Output, Phrase) :-
	danhtuchung_demduoc(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['danhtuchung_demduoc'], [Word]], Phrase).

% danhtu_khongdemduoc -> danhtu_khongdemduoc
% return: [[danhtu_khongdemduoc, '']]
danhtu_khongdemduoc(List_Input, List_Output, Phrase) :-
	danhtu_khongdemduoc(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['danhtu_khongdemduoc'], [Word]], Phrase).