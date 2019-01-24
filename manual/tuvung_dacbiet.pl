tuvung_dacbiet('phiền', '706869e1bb816e'). 	tuvung_dacbiet('706869e1bb816e', '706869e1bb816e').
tuvung_dacbiet('giúp', '6769c3ba70'). 		tuvung_dacbiet('6769c3ba70', '6769c3ba70').
tuvung_dacbiet('cho', '63686f'). 			tuvung_dacbiet('63686f', '63686f').
tuvung_dacbiet('bởi', '62e1bb9f69'). 		tuvung_dacbiet('62e1bb9f69', '62e1bb9f69').
tuvung_dacbiet('của', '63e1bba761'). 		tuvung_dacbiet('63e1bba761', '63e1bba761').
tuvung_dacbiet('mà', '6dc3a0'). 			tuvung_dacbiet('6dc3a0', '6dc3a0').

% tu_dat_biet
% return: [[tu_dat_biet, 'phiền']]
tu_dat_biet(Word_In, List_Input, List_Output, Phrase) :-
	tuvung_dacbiet(Word_In, Word_Out),
	sublist(List_Input, [Word_Out], List_Output),
	atomics_to_string(["'", Word_Out, "'"], Word),
	append_multiple([['tu_dat_biet'], [Word]], Phrase).