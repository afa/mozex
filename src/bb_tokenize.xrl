Definitions.

Rules.

\r\n : {token, {new_line, TokenLoc}}.
\n\r : {token, {new_line, TokenLoc}}.
\r : {token, {new_line, TokenLoc}}.
\n : {token, {new_line, TokenLoc}}.
\[[bB]\] : {token, {b_token, TokenLoc, TokenChars}}.
\[\/[bB]\] : {token, {slash_b_token, TokenLoc, TokenChars}}.
\[[iI]\] : {token, {i_token, TokenLoc, TokenChars}}.
\[\/[iI]\] : {token, {slash_i_token, TokenLoc, TokenChars}}.
.  : {token, {text, TokenLoc, TokenChars}}.

Erlang code.
