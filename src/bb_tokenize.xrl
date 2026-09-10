Definitions.

Rules.

% \[ : {token, {'[', TokenLoc}}.
% \] : {token, {']', TokenLoc}}.
% \/ : {token, {slash, TokenLoc, TokenChars}}.
\r\n : {token, {new_line, TokenLoc}}.
\n\r : {token, {new_line, TokenLoc}}.
\r : {token, {new_line, TokenLoc}}.
\n : {token, {new_line, TokenLoc}}.
\[[bB]\] : {token, {b_token, TokenLoc, TokenChars}}.
\[\/[bB]\] : {token, {slash_b_token, TokenLoc, TokenChars}}.
.  : {token, {text, TokenLoc, TokenChars}}.

Erlang code.
