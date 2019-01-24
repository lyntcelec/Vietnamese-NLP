:- reconsult('lib.pl').
:- reconsult('../cache/nhac.pl').
:- reconsult('../cache/nhac_encoded.pl').
:- reconsult('../cache/ten.pl').
:- reconsult('../cache/ten_encoded.pl').

% cache -> cache_nhac
% return: [[cache, [cache_nhac, ...]]].
cache(List_Input, List_Output, Phrase) :-
	cache_nhac(List_Input, List_Output, Phrase_A),
	append_multiple([['cache'], [Phrase_A]], Phrase).

% cache -> cache_ten
% return: [[cache, [cache_ten, ...]]].
cache(List_Input, List_Output, Phrase) :-
	cache_ten(List_Input, List_Output, Phrase_A),
	append_multiple([['cache'], [Phrase_A]], Phrase).

% cache_nhac -> cache_nhac
% return: [[cache_nhac, '']]
cache_nhac(List_Input, List_Output, Phrase) :-
	cache_nhac(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['cache_nhac'], [Word]], Phrase).

% cache_ten -> cache_ten
% return: [[cache_ten, '']]
cache_ten(List_Input, List_Output, Phrase) :-
	cache_ten(List_Input, List_Output),
	sublist(List_Input, List_Temp, List_Output),
	atomics_to_string(List_Temp, ' ', Word_Temp),
	atomics_to_string(["'", Word_Temp, "'"], Word),
	append_multiple([['cache_ten'], [Word]], Phrase).