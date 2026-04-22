#!/bin/sh
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // ""')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
in_tok=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
cache_create=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')

rl5_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
rl5_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
rl7_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
rl7_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

# Color thresholds: pick green/yellow/red based on percentage
# Context: yellow >=80, red >=95 (compact threshold)
# Rate limit: yellow >=70, red >=90
color_for_pct() {
  pct=$1
  yellow=$2
  red=$3
  # Integer compare after stripping decimals
  n=$(printf '%.0f' "$pct" 2>/dev/null || echo 0)
  if [ "$n" -ge "$red" ]; then
    printf '\033[31m'
  elif [ "$n" -ge "$yellow" ]; then
    printf '\033[33m'
  else
    printf '\033[32m'
  fi
}

# Format large token counts as e.g. 116k
format_tokens() {
  n=$1
  if [ "$n" -ge 1000000 ]; then
    awk -v n="$n" 'BEGIN { printf "%.1fM", n/1000000 }'
  elif [ "$n" -ge 1000 ]; then
    awk -v n="$n" 'BEGIN { printf "%dk", n/1000 }'
  else
    echo "$n"
  fi
}

# Format seconds-until as e.g. 2h14m, 5d3h, 45m
format_until() {
  secs=$1
  if [ "$secs" -le 0 ]; then
    echo "now"
    return
  fi
  days=$((secs / 86400))
  hours=$(((secs % 86400) / 3600))
  mins=$(((secs % 3600) / 60))
  if [ "$days" -gt 0 ]; then
    if [ "$hours" -gt 0 ]; then
      printf '%dd%dh' "$days" "$hours"
    else
      printf '%dd' "$days"
    fi
  elif [ "$hours" -gt 0 ]; then
    if [ "$mins" -gt 0 ]; then
      printf '%dh%dm' "$hours" "$mins"
    else
      printf '%dh' "$hours"
    fi
  else
    printf '%dm' "$mins"
  fi
}

now=$(date +%s)
sep=""

if [ -n "$model" ]; then
  printf '\033[36m%s\033[0m' "$model"
  sep="  "
fi

if [ -n "$used_pct" ] && [ -n "$ctx_size" ]; then
  used_tok=$((in_tok + cache_create + cache_read))
  used_fmt=$(format_tokens "$used_tok")
  size_fmt=$(format_tokens "$ctx_size")
  color=$(color_for_pct "$used_pct" 80 95)
  pct_int=$(printf '%.0f' "$used_pct")
  printf '%s%sctx:%s%% (%s/%s)\033[0m' "$sep" "$color" "$pct_int" "$used_fmt" "$size_fmt"
  sep="  "
fi

if [ -n "$rl5_pct" ]; then
  color=$(color_for_pct "$rl5_pct" 70 90)
  pct_int=$(printf '%.0f' "$rl5_pct")
  printf '%s%s5h:%s%%\033[0m' "$sep" "$color" "$pct_int"
  if [ -n "$rl5_reset" ]; then
    secs=$((rl5_reset - now))
    printf '\033[2m \xe2\x86\xbb%s\033[0m' "$(format_until "$secs")"
  fi
  sep="  "
fi

if [ -n "$rl7_pct" ]; then
  color=$(color_for_pct "$rl7_pct" 70 90)
  pct_int=$(printf '%.0f' "$rl7_pct")
  printf '%s%s7d:%s%%\033[0m' "$sep" "$color" "$pct_int"
  if [ -n "$rl7_reset" ]; then
    secs=$((rl7_reset - now))
    printf '\033[2m \xe2\x86\xbb%s\033[0m' "$(format_until "$secs")"
  fi
fi

printf '\n'
