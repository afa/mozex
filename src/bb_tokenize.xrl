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
\[[uU]\] : {token, {u_token, TokenLoc, TokenChars}}.
\[\/[uU]\] : {token, {slash_u_token, TokenLoc, TokenChars}}.
\[[sS]\] : {token, {s_token, TokenLoc, TokenChars}}.
\[\/[sS]\] : {token, {slash_s_token, TokenLoc, TokenChars}}.
\[(left|LEFT)\] : {token, {left_token, TokenLoc, TokenChars}}.
\[\/(left|LEFT)\] : {token, {slash_left_token, TokenLoc, TokenChars}}.
\[(center|CENTER)\] : {token, {center_token, TokenLoc, TokenChars}}.
\[\/(center|CENTER)\] : {token, {slash_center_token, TokenLoc, TokenChars}}.
\[(right|RIGHT)\] : {token, {right_token, TokenLoc, TokenChars}}.
\[\/(right|RIGHT)\] : {token, {slash_right_token, TokenLoc, TokenChars}}.
\[(indent|INDENT)\] : {token, {indent_token, TokenLoc, TokenChars}}.
\[\/(indent|INDENT)\] : {token, {slash_indent_token, TokenLoc, TokenChars}}.
\[(highlite|HIGHLITE)\] : {token, {highlite_token, TokenLoc, TokenChars}}.
\[\/(highlite|HIGHLITE)\] : {token, {slash_highlite_token, TokenLoc, TokenChars}}.
.  : {token, {text, TokenLoc, TokenChars}}.

Erlang code.
