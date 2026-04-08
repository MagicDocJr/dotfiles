#!/usr/bin/env bash
# Claude Code status line — Catppuccin Mocha theme

input=$(cat)

# ---------------------------------------------------------------------------
# Parse JSON — python3 only (jq not available)
# ---------------------------------------------------------------------------
_parsed=$(python3 - "$input" <<'PYEOF'
import sys, json

raw = sys.argv[1] if len(sys.argv) > 1 else sys.stdin.read()
d = json.loads(raw)

model    = d.get('model', {}).get('display_name', 'unknown')
cwd      = d.get('workspace', {}).get('current_dir') or d.get('cwd', '')

cw       = d.get('context_window', {})
cur      = cw.get('current_usage') or {}
win_size = cw.get('context_window_size')
in_tok   = cur.get('input_tokens')
out_tok  = cur.get('output_tokens', 0)

# used tokens = input + output tokens for the current context
ctx_used  = ''
ctx_total = ''
ctx_pct   = ''
if win_size and in_tok is not None:
    used      = in_tok + out_tok
    ctx_used  = str(used)
    ctx_total = str(win_size)
    ctx_pct   = str(round(used / win_size * 100, 1))
elif cw.get('used_percentage') is not None:
    ctx_pct = str(round(cw['used_percentage'], 1))

rl = d.get('rate_limits', {})

five_pct = ''
fh = rl.get('five_hour', {})
if fh.get('used_percentage') is not None:
    five_pct = str(round(fh['used_percentage'], 1))

week_pct = ''
sd = rl.get('seven_day', {})
if sd.get('used_percentage') is not None:
    week_pct = str(round(sd['used_percentage'], 1))

# Output one field per line to avoid word-splitting on spaces in model/cwd
for val in [model, cwd, ctx_used, ctx_total, ctx_pct, five_pct, week_pct]:
    print(val)
PYEOF
)

# Read one value per line — safe even when model name or cwd contains spaces
IFS= read -r model    <<< "$(sed -n '1p' <<< "$_parsed")"
IFS= read -r cwd      <<< "$(sed -n '2p' <<< "$_parsed")"
IFS= read -r ctx_used <<< "$(sed -n '3p' <<< "$_parsed")"
IFS= read -r ctx_total <<< "$(sed -n '4p' <<< "$_parsed")"
IFS= read -r ctx_pct  <<< "$(sed -n '5p' <<< "$_parsed")"
IFS= read -r five_pct <<< "$(sed -n '6p' <<< "$_parsed")"
IFS= read -r week_pct <<< "$(sed -n '7p' <<< "$_parsed")"

# ---------------------------------------------------------------------------
# Catppuccin Mocha palette — $'...' ANSI C quoting so \e is always expanded
# ---------------------------------------------------------------------------
reset=$'\e[0m'
bold=$'\e[1m'
# Mocha named colours (true-colour)
lavender=$'\e[38;2;180;190;254m'   # model
mauve=$'\e[38;2;203;166;247m'      # label / icon accents
sapphire=$'\e[38;2;116;199;236m'   # context bar fill
sky=$'\e[38;2;137;220;235m'        # context bar label
peach=$'\e[38;2;250;179;135m'      # orange warning
red=$'\e[38;2;243;139;168m'        # red alert
green=$'\e[38;2;166;227;161m'      # green ok
teal=$'\e[38;2;148;226;213m'       # branch
overlay=$'\e[38;2;108;112;134m'    # dim / separators
subtext=$'\e[38;2;166;173;200m'    # secondary text
fg=$'\e[38;2;205;214;244m'         # main foreground

# ---------------------------------------------------------------------------
# Context block bar (10 chars) — coloured fill + dim empty
# ---------------------------------------------------------------------------
ctx_bar() {
  local pct="${1:-0}"
  local filled
  filled=$(python3 -c "import math; print(min(10,max(0,round(${pct}/10))))" 2>/dev/null || echo 0)
  local empty=$(( 10 - filled ))
  local out="" i
  for i in $(seq 1 $filled);  do out="${out}${sapphire}█"; done
  for i in $(seq 1 $empty);   do out="${out}${overlay}░"; done
  printf "%s" "$out"
}

# ---------------------------------------------------------------------------
# Rate-limit colour based on percentage
# ---------------------------------------------------------------------------
rl_color() {
  local pct_int="${1:-0}"
  if   [ "$pct_int" -ge 80 ]; then printf "%s" "$red"
  elif [ "$pct_int" -ge 50 ]; then printf "%s" "$peach"
  else                              printf "%s" "$green"
  fi
}

sep="${overlay} │ ${reset}"

# ---------------------------------------------------------------------------
# 1. Model
# ---------------------------------------------------------------------------
printf "${lavender}${bold}⬡ %s${reset}" "$model"

# ---------------------------------------------------------------------------
# 2. Context window bar
# ---------------------------------------------------------------------------
if [ -n "$ctx_pct" ]; then
  ctx_pct_int=$(python3 -c "print(round(float('${ctx_pct}')))" 2>/dev/null || echo 0)
  bar=$(ctx_bar "$ctx_pct")
  printf "%s${sky}ctx ${reset}%s${reset}" "$sep" "$bar"
  if [ -n "$ctx_used" ] && [ -n "$ctx_total" ]; then
    # Format with k suffix for readability
    label=$(python3 -c "
u=int('${ctx_used}'); t=int('${ctx_total}')
def k(n): return f'{n//1000}k' if n>=1000 else str(n)
print(f'{k(u)}/{k(t)}')
" 2>/dev/null || echo "${ctx_pct}%")
    printf " ${subtext}%s${reset}" "$label"
  else
    printf " ${subtext}%s%%${reset}" "$ctx_pct_int"
  fi
fi

# ---------------------------------------------------------------------------
# 3. 5-hour rate limit
# ---------------------------------------------------------------------------
if [ -n "$five_pct" ]; then
  five_int=$(python3 -c "print(round(float('${five_pct}')))" 2>/dev/null || echo 0)
  col=$(rl_color "$five_int")
  printf "%s${mauve}5h ${col}%d%%${reset}" "$sep" "$five_int"
fi

# ---------------------------------------------------------------------------
# 4. 7-day rate limit
# ---------------------------------------------------------------------------
if [ -n "$week_pct" ]; then
  week_int=$(python3 -c "print(round(float('${week_pct}')))" 2>/dev/null || echo 0)
  col=$(rl_color "$week_int")
  printf "%s${mauve}7d ${col}%d%%${reset}" "$sep" "$week_int"
fi

# ---------------------------------------------------------------------------
# 5. Git branch
# ---------------------------------------------------------------------------
branch=""
if [ -n "$cwd" ] && git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
           || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi
if [ -n "$branch" ]; then
  printf "%s${teal} %s${reset}" "$sep" "$branch"
fi

printf "\n"
