Definitions.

Rules.

\[ : {token, {'[', TokenLoc}}.
\] : {token, {']', TokenLoc}}.
\/ : {token, {slash, TokenLoc, TokenChars}}.
\[[bB]\] : {token, {b_token, TokenLoc, TokenChars}}.
\[\/[bB]\] : {token, {slash_b_token, TokenLoc, TokenChars}}.
.  : {token, {text, TokenLoc, TokenChars}}.

Erlang code.
