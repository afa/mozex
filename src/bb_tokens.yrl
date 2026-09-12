% list: {token kind [open]}
Nonterminals texts list token.
% Nonterminals texts opentoken closetoken list.
Terminals text new_line
    u_token slash_u_token
    s_token slash_s_token
    i_token slash_i_token
    b_token slash_b_token.
% Terminals '[' ']' '/' text.
Rootsymbol list.

list -> texts : '$1'.
texts -> '$empty' : [].
texts -> token texts : ['$1' | '$2'].
token -> b_token texts slash_b_token : {b, '$2', []}.
token -> i_token texts slash_i_token : {i, '$2', []}.
token -> u_token texts slash_u_token : {u, '$2', []}.
token -> s_token texts slash_s_token : {s, '$2', []}.
token -> new_line : {new_line, [], []}.
texts -> text texts : [extract_value('$1') | '$2'].

Erlang code.

extract_value({_Token, _Loc, Value}) -> Value.
