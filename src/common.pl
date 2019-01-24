:- reconsult('lib.pl').
:- reconsult('danhtu.pl').
:- reconsult('dongtu.pl').
:- reconsult('daitu.pl').
:- reconsult('photu.pl').
:- reconsult('camtu.pl').
:- reconsult('maotu.pl').
:- reconsult('trotu.pl').
:- reconsult('sohuu.pl').
:- reconsult('tinhtu.pl').
:- reconsult('caucaukhien.pl').
:- reconsult('../manual/tuvung_dacbiet.pl').

% cau -> cau_don
% return: [[cau, [cau_don, ...]]].
cau(List_Input, List_Output, Phrase) :-
	cau_don(List_Input, List_Output, Phrase_A),
	append_multiple([['cau'], [Phrase_A]], Phrase).

% cau -> cau_cau_khien
% return: [[cau, [cau_cau_khien, ...]]].
cau(List_Input, List_Output, Phrase) :-
	cau_cau_khien(List_Input, List_Output, Phrase_A),
	append_multiple([['cau'], [Phrase_A]], Phrase).

% cau_don -> cum_danh_tu + vi_ngu
% return: [[cau_don, [cum_danh_tu, ...], [vi_ngu, ...]]].
cau_don(List_Input, List_Output, Phrase) :-
	cum_danh_tu(List_Input, List_Temp, Phrase_A),
	vi_ngu(List_Temp, List_Output, Phrase_B),
	append_multiple([['cau_don'], [Phrase_A], [Phrase_B]], Phrase).

% vi_ngu -> cum_dong_tu
% return: [[vi_ngu, [cum_dong_tu, ...]]].
vi_ngu(List_Input, List_Output, Phrase) :-
	cum_dong_tu(List_Input, List_Output, Phrase_A),
	append_multiple([['vi_ngu'], [Phrase_A]], Phrase).

%% shorten_lists(dongtu).
%% shorten_lists(danhtu).
%% shorten_lists(dongtu_chihanhdong).
shorten_lists(cau_cau_khien).
shorten_lists(cum_danh_tu).
shorten_lists(cum_dong_tu).
shorten_lists(caucaukhien_xulytrungtam).

% [danh_tu, [C, []]]
% Nếu C là atom return true
shorten_phrase_check_atom1([[C|[_]]|_]) :-
	(atom(C) ; string(C)),!.

% [loai_dongtu,[dongtu_chihanhdong,'đá']
% Nếu C là atom return true
shorten_phrase_check_atom2([[_|[C]]|_]) :-
	(atom(C) ; string(C)),!.

shorten_phrase([],[]).

shorten_phrase([AH|[AT]], [AH|[AT]]) :-
	(atom(AT) ; string(AT)),!.

shorten_phrase([AH|AT], [BH|BT]) :-
	atom(AH) ->
	(
		shorten_lists(AH) -> 
		(
			[AT_Temp] = AT,
			shorten_phrase(AT_Temp, B_Temp),
			(
				shorten_phrase_check_atom1(AT) ->
				(
					[B_Temp_H|[B_Temp_T]] = B_Temp,
					(
						shorten_lists(B_Temp_H) -> 
						(
							[BH|BT] = [AH|[B_Temp]]
						);
						not(shorten_lists(B_Temp_H)) ->
						(
							[BH|BT] = [AH|[B_Temp_T]]
						)
					)
				);
				not(shorten_phrase_check_atom1(AT)) -> [BH|BT] = [AH|[B_Temp]]
			)
		);
		not(shorten_phrase_check_atom1(AT)) -> 
		(
			[AT_Temp] = AT,
			shorten_phrase(AT_Temp, B_Temp),
			[BH|BT] = [AH|[B_Temp]]
		);
		shorten_phrase_check_atom2(AT) -> 
		(
			[AT_Temp] = AT,
			shorten_phrase(AT_Temp, B_Temp),
			[BH|BT] = [AH|[B_Temp]]
		);
		not(shorten_lists(AH)) -> 
		(
			[AT_Temp] = AT,
			shorten_phrase(AT_Temp, [BH|BT])
		)
	);
	not(atom(AH)) ->
	(
		shorten_phrase(AH, BH),
		shorten_phrase(AT, BT)
	).

convert_json([],'').

convert_json([AH|[AT]], Json) :-
	atom(AT) -> 
	atomics_to_string(["'", AH, "'", ":", "'", AT, "'"], Json);
	string(AT) -> 
	atomics_to_string(["'", AH, "'", ":", AT], Json).

convert_json([AH|AT], Json) :-
	atom(AH) ->
	(
		(shorten_phrase_check_atom2(AT) ; shorten_phrase_check_atom1(AT)) -> 
		(
			[AT_Temp] = AT,
			convert_json(AT_Temp, Json_Temp),
			atomics_to_string(["'", AH, "'", ":", "{", Json_Temp, "}"], Json)
		);
		not(shorten_phrase_check_atom1(AT)) -> 
		(
			[AT_Temp] = AT,
			convert_json(AT_Temp, Json_Temp),
			atomics_to_string(["'", AH, "'", ":", "{", Json_Temp, "}"], Json)
		)
	);
	not(atom(AH)) ->
	(
		convert_json(AH, Json_Temp),
		convert_json(AT, Json_Temp2),
		(
			Json_Temp2 == '' ->
			(
				Json = Json_Temp
			);
			Json_Temp2 \== '' ->
			(
				atomics_to_string([Json_Temp, "," ,Json_Temp2], Json)
			)
		)
	).

process_nlp(List_Input, Json) :-
	write("========================================"),nl,
	cau(List_Input, [], P),
	write("Pass ==> parse sentence"),nl,
	write(P),nl,
	shorten_phrase(P, L),
	write("Pass ==> shorten_phrase()"),nl,
	write(L),nl,
	convert_json(L, J),
	atomics_to_string(["{", J, "}"], Json),
	write("Pass ==> convert_json()"),nl,
	write("----------------------------------------"),nl.


test :-
	%% L = [cau_cau_khien,[[caucaukhien_xulytrungtam,[cum_dong_tu,[[loai_dongtu,[dongtu_chihanhdong,'6de1bb9f']],[cum_danh_tu,[danhtu_khongdemduoc,'6e68e1baa163']]]]],[trotu_cuoicau,'c49169'],[caucaukhien_daitu,[danhtu_ten,'6d61696b61']]]],
	%% L = [cum_danh_tu,[cum_dong_tu1,[cum_dong_tu,[loai_dongtu,[dongtu_chihanhdong,"'6de1bb9f'"]]]]],
	L = [[caucaukhien_tienxuly,[caucaukhien_xulytrungtam,[[cum_dong_tu,[[dong_tu,[dong_tu_temp,[loai_dongtu,[dongtu_chihanhdong,'6de1bb9f']]]]]]]]]],
	shorten_phrase(L, P),
	convert_json(P, J),
	atomics_to_string(["{", J, "}"], Json),
	write(Json).

/*
test :-
	%% P = [cau,[cau_cau_khien,[cau_cau_khien_temp,[[caucaukhien_xulytrungtam,[cum_dong_tu,[[dong_tu,[dong_tu_temp,[loai_dongtu,[dongtu_chihanhdong,'6de1bb9f']]]],[cum_danh_tu,[cumdanhtu1_temp,[cumdanhtu2_temp,[danh_tu,[danh_tu1_temp,[danhtu_khongdemduoc,'6e68e1baa163']]]]]]]]],[trotu_cuoicau,'c49169'],[caucaukhien_daitu,[danhtu_ten,'6d61696b61']]]]]],
	%% P = [cau,[cau_cau_khien,[cau_cau_khien_temp,[[caucaukhien_tienxuly,[[tu_dat_biet,'706869e1bb816e'],[caucaukhien_daitu,[danhtu_ten,'6d61696b61']],[caucaukhien_xulytrungtam,[[dong_tu,[dong_tu_temp,[loai_dongtu,[dongtu_chihanhdong,'6de1bb9f']]]],[photu_giupdo,'6769c3ba70'],[cum_danh_tu,[cumdanhtu1_temp,[cumdanhtu2_temp,[dai_tu,[daitu_nhanxung_ngoithunhat,'74c3b469']]]]],[cum_danh_tu,[cumdanhtu1_temp,[cumdanhtu2_temp,[danh_tu,[danh_tu1_temp,[danhtu_demduoc,[danhtuchung_demduoc,'62c3a069 6e68e1baa163']]]]]]]]]]],[trotu_cuoicau,'c49169']]]]],
	%% P = [dong_tu,[loai_dongtu,[dongtu_chihanhdong,'đá']],[loai_dongtu,[dongtu_chihanhdong,'ăn']],[loai_dongtu,[dongtu_chihanhdong,'chạy']]],
	%% P = [dongtu,[dongtu3,[dongtu_chihanhdong,'đá']]],
	%% P = [dongtu,[dongtu1,[danhtu,[loai_dongtu,[dongtu_chihanhdong,'đá']]]]],
	%% P = [dongtu_chihanhdong,'đá'],
	%% P = [[danhtu_chinguoi,'6361 73c4a9']],
	%% P = [[danhtu_chinguoi,'6361 73c4a9'],[dongtu_chitrangthai,'6275e1bb936e']],
	%% P = [danhtu,[danhtu_chinguoi1,[[loai_dongtu,[dongtu_chihanhdong,'đá']],[dongtu_chitrangthai,'6275e1bb936e'],[dongtu_chitrangthai,'6275e1bb936e']]]],
	%% P = [cau,[cau_cau_khien,[cau_cau_khien_temp,[[caucaukhien_daitu,[[danhtu_ten,'6d61696b61'],[camtu_oi,'c6a169']]],[caucaukhien_xulytrungtam,[[tu_dat_biet,'6769c3ba70'],[cum_danh_tu,[cumdanhtu1_temp,[cumdanhtu2_temp,[dai_tu,[daitu_nhanxung_ngoithunhat,'74c3b469']]]]],[cum_dong_tu,[[dong_tu,[dong_tu_temp,[loai_dongtu,[dongtu_chihanhdong,'6de1bb9f']]]],[cum_danh_tu,[cumdanhtu1_temp,[cumdanhtu2_temp,[danh_tu,[danh_tu1_temp,[danhtu_demduoc,[danhtuchung_demduoc,'62c3a069 6e68e1baa163']]]]]]]]]]]]]]];
	%% P = [caucaukhien_xulytrungtam,[[tu_dat_biet,'6769c3ba70'],[cum_danh_tu,[cumdanhtu1_temp,[cumdanhtu2_temp,[dai_tu,[daitu_nhanxung_ngoithunhat,'74c3b469']]]]],[cum_dong_tu,[[dong_tu,[dong_tu_temp,[loai_dongtu,[dongtu_chihanhdong,'6de1bb9f']]]],[cum_danh_tu,[cumdanhtu1_temp,[cumdanhtu2_temp,[danh_tu,[danh_tu1_temp,[danhtu_demduoc,[danhtuchung_demduoc,'62c3a069 6e68e1baa163']]]]]]]]]]],
	%% P = [cau,[cau_cau_khien,[cau_cau_khien_temp,[[caucaukhien_tienxuly,[[tu_dat_biet,'706869e1bb816e'],[caucaukhien_daitu,[danhtu_ten,'6d61696b61']],[caucaukhien_xulytrungtam,[[dong_tu,[dong_tu_temp,[loai_dongtu,[dongtu_chihanhdong,'6de1bb9f']]]],[photu_giupdo,'6769c3ba70'],[cum_danh_tu,[cumdanhtu1_temp,[cumdanhtu2_temp,[dai_tu,[daitu_nhanxung_ngoithunhat,'74c3b469']]]]],[cum_danh_tu,[cumdanhtu1_temp,[cumdanhtu2_temp,[danh_tu,[danh_tu1_temp,[danhtu_demduoc,[danhtuchung_demduoc,'62c3a069 6e68e1baa163']]]]]]]]]]],[trotu_cuoicau,'c49169']]]]],
	%% P = [caucaukhien_xulytrungtam,[[loai_dongtu,[dongtu_chihanhdong,'6de1bb9f']],[photu_giupdo,'6769c3ba70'],[cum_danh_tu,[dai_tu,[daitu_nhanxung_ngoithunhat,'74c3b469']]],[cum_danh_tu,[danhtu_demduoc,[danhtuchung_demduoc,'62c3a069 6e68e1baa163']]]]],
	%% P = [dongtu,['dongtu_chihanhdong','6de1bb9f']],
	%% P = [dongtu,[['dongtu_chihanhdong','6de1bb9f']]],
	%% P = [danhtu,[dongtu,[['dongtu_chihanhdong','6de1bb9f'],['dongtu_chihanhdong2','6de1bb9f']]]],
	shorten_phrase(P, L),
	write(L),nl,
	convert_json(L, J),
	atomics_to_string(["{", J, "}"], Json),
	write(Json),nl,
	write("Success.").
*/

/*
[
	[caucaukhien_tienxuly,
		[caucaukhien_xulytrungtam,
			[
				[cum_dong_tu,
					[
						[dong_tu,
							[dong_tu_temp,
								[loai_dongtu,
									[dongtu_chihanhdong,'6de1bb9f']
								]
							]
						]
					]
				]
			]
		]
	]
]
*/

