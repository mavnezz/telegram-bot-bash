#!/bin/bash
# Edit your commands in this file.

# This file is public domain in the USA and all free countries.
# Elsewhere, consider it to be WTFPLv2. (wtfpl.net/txt/copying)
			
if [ "$1" = "source" ];then
	# Place the token in the token file
	TOKEN=$(cat token)
	# Set INLINE to 1 in order to receive inline queries.
	# To enable this option in your bot, send the /setinline command to @BotFather.
	INLINE=0
	# Set to .* to allow sending files from all locations
	FILE_REGEX='/home/user/allowed/.*'
else
	if ! tmux ls | grep -v send | grep -q $copname; then
		[ ! -z ${URLS[*]} ] && {
			curl -s ${URLS[*]} -o $NAME
			send_file "${CHAT[ID]}" "$NAME" "$CAPTION"
			rm "$NAME"
		}
		[ ! -z ${LOCATION[*]} ] && send_location "${CHAT[ID]}" "${LOCATION[LATITUDE]}" "${LOCATION[LONGITUDE]}"

		# Inline
		if [ $INLINE == 1 ]; then
			# inline query data
			iUSER[FIRST_NAME]=$(echo "$res" | sed 's/^.*\(first_name.*\)/\1/g' | cut -d '"' -f3 | tail -1)
			iUSER[LAST_NAME]=$(echo "$res" | sed 's/^.*\(last_name.*\)/\1/g' | cut -d '"' -f3)
			iUSER[USERNAME]=$(echo "$res" | sed 's/^.*\(username.*\)/\1/g' | cut -d '"' -f3 | tail -1)
			iQUERY_ID=$(echo "$res" | sed 's/^.*\(inline_query.*\)/\1/g' | cut -d '"' -f5 | tail -1)
			iQUERY_MSG=$(echo "$res" | sed 's/^.*\(inline_query.*\)/\1/g' | cut -d '"' -f5 | tail -6 | head -1)

			# Inline examples
			if [[ $iQUERY_MSG == photo ]]; then
				answer_inline_query "$iQUERY_ID" "photo" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg" "http://blog.techhysahil.com/wp-content/uploads/2016/01/Bash_Scripting.jpeg"
			fi

			if [[ $iQUERY_MSG == sticker ]]; then
				answer_inline_query "$iQUERY_ID" "cached_sticker" "BQADBAAD_QEAAiSFLwABWSYyiuj-g4AC"
			fi

			if [[ $iQUERY_MSG == gif ]]; then
				answer_inline_query "$iQUERY_ID" "cached_gif" "BQADBAADIwYAAmwsDAABlIia56QGP0YC"
			fi
			if [[ $iQUERY_MSG == web ]]; then
				answer_inline_query "$iQUERY_ID" "article" "GitHub" "http://github.com/topkecleon/telegram-bot-bash"
			fi
		fi &
	fi
	case $MESSAGE in
		########################################################################
		######## bittrex
		########################################################################	

		'/bittrex')
			timestamp=$(date +%s)			
			DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
			DIR="$DIR/antispam/"

			filestamp=$(stat -c %Y "$DIR/${CHAT[ID]}_bittrex.csv")
			if [ -z "$filestamp" ]; then
				filestamp=1024465892
			fi
			
			diff=$(($timestamp - $filestamp))
			
			if [ $diff -gt 300 ]; then		
				send_action "${CHAT[ID]}" "typing"
				btc=$(curl -s https://bittrex.com/api/v1.1/public/getticker?market=USDT-BTC | jq '.["result"]["Last"]' | awk '{ print sprintf("%.2f", $1); }')
					
				high=$(curl -s https://bittrex.com/api/v1.1/public/getmarketsummary?market=BTC-SHIFT | jq '.["result"][]["High"]')
				low=$(curl -s https://bittrex.com/api/v1.1/public/getmarketsummary?market=BTC-SHIFT | jq '.["result"][]["Low"]')
				last=$(curl -s https://bittrex.com/api/v1.1/public/getmarketsummary?market=BTC-SHIFT | jq '.["result"][]["Last"]')
				volume=$(curl -s https://bittrex.com/api/v1.1/public/getmarketsummary?market=BTC-SHIFT | jq '.["result"][]["Volume"]'| awk '{ print sprintf("%.2f", $1); }')
				basevolume=$(curl -s https://bittrex.com/api/v1.1/public/getmarketsummary?market=BTC-SHIFT | jq '.["result"][]["BaseVolume"]' | awk '{ print sprintf("%.2f", $1); }')
				prevday=$(curl -s https://bittrex.com/api/v1.1/public/getmarketsummary?market=BTC-SHIFT | jq '.["result"][]["PrevDay"]')
				percent_change_24h=$(curl -s https://api.coinmarketcap.com/v1/ticker/shift/ | jq ".[0].percent_change_24h" | sed 's/\"/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//')
				
				shift_dollar=$(echo "$btc * $last" | bc)
				shift_dollar=$(printf %.3f $(echo "$shift_dollar" | bc -l))
				change=$(echo "scale=3; $last / $prevday" | bc)
				
									
				send_markdown_message "${CHAT[ID]}"	"*Bittrex: $last BTC | $shift_dollar$ *
*Vol:* $volume SHIFT | $basevolume BTC
*Low:* $low | *High:* $high
*24h* change: $percent_change_24h%
"
				echo $timestamp > "$DIR/${CHAT[ID]}_bittrex.csv"
			fi
			;;

		########################################################################
		######## votingguide
		########################################################################			
		'/votingguide')
			timestamp=$(date +%s)			
			DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
			DIR="$DIR/antispam/"

			filestamp=$(stat -c %Y "$DIR/${CHAT[ID]}_votingguide.csv")
			if [ -z "$filestamp" ]; then
				filestamp=1024465892
			fi
			
			diff=$(($timestamp - $filestamp))
			
			if [ $diff -gt 300 ]; then		
				send_action "${CHAT[ID]}" "typing"
				send_markdown_message "${CHAT[ID]}" "*Quickstart guide for voting mechanism* 
â€¢ http://telegra.ph/Quickstart-Guide-Voting-in-Shift-02-10"
				echo $timestamp > "$DIR/${CHAT[ID]}_votingguide.csv"
			fi
		;;
		
		########################################################################
		######## nanoguide
		########################################################################
		'/nanoguide')
			timestamp=$(date +%s)			
			DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
			DIR="$DIR/antispam/"

			filestamp=$(stat -c %Y "$DIR/${CHAT[ID]}_nanoguide.csv")
			if [ -z "$filestamp" ]; then
				filestamp=1024465892
			fi
			
			diff=$(($timestamp - $filestamp))
			
			if [ $diff -gt 300 ]; then		
				send_action "${CHAT[ID]}" "typing"
				send_markdown_message "${CHAT[ID]}" "*Quickstart guide for nano wallet* 
â€¢ http://telegra.ph/Quickstart-Guide-Instructions-for-the-Nano-wallet-02-10"
				echo $timestamp > "$DIR/${CHAT[ID]}_nanoguide.csv"
			fi
		;;
		
		########################################################################
		######## start
		########################################################################		
		'/start')
			timestamp=$(date +%s)			
			DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
			DIR="$DIR/antispam/"

			filestamp=$(stat -c %Y "$DIR/${CHAT[ID]}_start.csv")
			if [ -z "$filestamp" ]; then
				filestamp=1024465892
			fi
			
			diff=$(($timestamp - $filestamp))
			
			if [ $diff -gt 300 ]; then			
				send_action "${CHAT[ID]}" "typing"
				send_markdown_message "${CHAT[ID]}" "This is mavBOT, the Telegram bot for shift coin project.
										*Available commands*:
										*â€¢ /start*: _Start bot and get this message_.
										*â€¢ /bittrex*: _Get shift data from bittrex_.
										*â€¢ /cmc*: _Get shift data from Coinmarketcap_.
										*â€¢ /votingguide*: _Quickstart guide for voting mechanism_.
										*â€¢ /nanoguide*: _Quickstart guide for nano wallet_.
										"
				echo $timestamp > "$DIR/${CHAT[ID]}_start.csv"
			fi
		;;
     			
		########################################################################
		######## cmc
		########################################################################				
		'/cmc')
			timestamp=$(date +%s)			
			DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
			DIR="$DIR/antispam/"

			filestamp=$(stat -c %Y "$DIR/${CHAT[ID]}_cmc.csv")
			if [ -z "$filestamp" ]; then
				filestamp=1024465892
			fi
			
			diff=$(($timestamp - $filestamp))
			
			if [ $diff -gt 300 ]; then		
				send_action "${CHAT[ID]}" "typing"
				#if tmux ls | grep -q $copname; then killproc && send_message "${CHAT[ID]}" "Command canceled.";else send_message "${CHAT[ID]}" "No command is currently running.";fi
				price_usd=$(curl -s https://api.coinmarketcap.com/v1/ticker/shift/ | jq ".[0].price_usd" | sed 's/\"/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//')
				price_btc=$(curl -s https://api.coinmarketcap.com/v1/ticker/shift/ | jq ".[0].price_btc" | sed 's/\"/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//')
				rank=$(curl -s https://api.coinmarketcap.com/v1/ticker/shift/ | jq ".[0].rank" | sed 's/\"/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//')
				percent_change_24h=$(curl -s https://api.coinmarketcap.com/v1/ticker/shift/ | jq ".[0].percent_change_24h" | sed 's/\"/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//')
				percent_change_7d=$(curl -s https://api.coinmarketcap.com/v1/ticker/shift/ | jq ".[0].percent_change_7d" | sed 's/\"/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//')

				price_usd=$(printf %.3f $(echo "$price_usd" | bc -l))	
				send_markdown_message "${CHAT[ID]}"	"*CMC: $price_btc BTC | $price_usd$ *
*Rank:* $rank
*24h*: $percent_change_24h% | *7d*: $percent_change_7d%
"
				echo $timestamp > "$DIR/${CHAT[ID]}_cmc.csv"
			fi
		;;
			
			
		########################################################################
		######## all messages
		########################################################################			
		*)
			timestamp=$(date +%s)
			DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
			DIR="$DIR/antispam/"

			filestamp=$(stat -c %Y "$DIR/cmc_timestamp.csv")
			if [ -z "$filestamp" ]; then
				filestamp=1024465892
			fi
			diff=$(($timestamp - $filestamp))

			if [ $diff -gt 21600 ]; then
			
							send_action "${CHAT[ID]}" "typing"
							#if tmux ls | grep -q $copname; then killproc && send_message "${CHAT[ID]}" "Command canceled.";else send_message "${CHAT[ID]}" "No command is currently running.";fi
							price_usd=$(curl -s https://api.coinmarketcap.com/v1/ticker/shift/ | jq ".[0].price_usd" | sed 's/\"/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//')
							price_btc=$(curl -s https://api.coinmarketcap.com/v1/ticker/shift/ | jq ".[0].price_btc" | sed 's/\"/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//')
							rank=$(curl -s https://api.coinmarketcap.com/v1/ticker/shift/ | jq ".[0].rank" | sed 's/\"/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//')
							percent_change_24h=$(curl -s https://api.coinmarketcap.com/v1/ticker/shift/ | jq ".[0].percent_change_24h" | sed 's/\"/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//')
							percent_change_7d=$(curl -s https://api.coinmarketcap.com/v1/ticker/shift/ | jq ".[0].percent_change_7d" | sed 's/\"/ /g' | sed 's/^[ \t]*//;s/[ \t]*$//')

							price_usd=$(printf %.3f $(echo "$price_usd" | bc -l))	
			send_markdown_message "${CHAT[ID]}"	"*CMC: $price_btc BTC | $price_usd$ *
*Rank:* $rank
*24h*: $percent_change_24h% | *7d*: $percent_change_7d%
"			
				echo $timestamp > "$DIR/cmc_timestamp.csv"
			fi
		;;
	esac
fi
