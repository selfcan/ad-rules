#!/bin/sh

remove_line(){
    [ -e "${1}" ] || exit 0
    [ -e "${2}" ] || exit 0

    cat ${2} | while read line;do
        str=${line}
        echo "$str"
        [ ! -z "$str" ] && sed -i "/$str/d" ${1}
    done
}

clear_ill(){
	 grep -E '\$[~]{0,1}(image|script|object|media|domain=.*|subdocument|third-party|xmlhttprequest)(,(important|third-party|domain=[0-9a-zA-Z\.\~\|]+))?$' ${1} > /tmp/cl1.txt
	 sed -i '/+js(/d' ${1}
	 sed -i -r '/\$.+/d' ${1}
	 echo "" >> ${1}
	 cat /tmp/cl1.txt >> ${1}
}

clear_ill /tmp/myrules/lazy.txt
clear_ill /tmp/myrules/video.txt
remove_line /tmp/myrules/video.txt /tmp/patches/remove1.txt
