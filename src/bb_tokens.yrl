% list: {token kind [open]}
Nonterminals texts list token.
% Nonterminals texts opentoken closetoken list.
Terminals text b_token slash_b_token.
% Terminals '[' ']' '/' text.
Rootsymbol list.

list -> texts : '$1'.
texts -> '$empty' : [].
texts -> token texts : ['$1' | '$2'].
token -> b_token texts slash_b_token : {b, ['$2']}.
texts -> text texts : [extract_value('$1') | '$2'].

Erlang code.

extract_value({_Token, _Loc, Value}) -> Value.
