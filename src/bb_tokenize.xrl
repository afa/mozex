Definitions.

Rules.

\[ : {token, {'[', TokenLoc}}.
\] : {token, {']', TokenLoc}}.
\/ : {token, {slash, TokenLoc, TokenChars}}.
[bB] : {token, {b_token_name, TokenLoc, TokenChars}}.
.  : {token, {text, TokenLoc, TokenChars}}.

Erlang code.
