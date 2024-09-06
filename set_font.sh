#!/bin/bash
source mycolor
PS3="Select the operation: "
font_list=$(ls /usr/share/consolefonts | grep CyrAsia)
font_list="$font_list quit"
list_count=$(echo $font_list | wc -w)
select opt in $font_list; do
		
	font_selected=$opt
	if (( $REPLY > $list_count )); then 
		echo -e "${BRed}Select Valid Option. $REPLY is greater than $list_count ${Color_Off}"
		continue
	fi
	if [[ "$opt" == "quit" ]]; then
		exit 0
	else
		setfont /usr/share/consolefonts/${opt}
	fi
		
done
