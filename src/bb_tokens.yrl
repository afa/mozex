% list: {token kind [open]}
Nonterminals texts list.
% Nonterminals texts opentoken closetoken list.
Terminals text.
% Terminals '[' ']' '/' text.
Rootsymbol list.

list -> texts : '$1'.
texts -> '$empty' : [].
texts -> text texts : [extract_value('$1') | '$2'].

Erlang code.

extract_value({_Token, _Loc, Value}) -> Value.
