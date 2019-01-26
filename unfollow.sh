#!/bin/bash
# Author : Agus Kurniawan (Guzz)
# FB : アグスクルニアワン (facebook.com/agusu.des)
# Github : https://github.com/Lmintcoder
# Recode ? OK but Don't Change Author OK
# Any Error ? Tell Me On Facebook
# Request Another Tools ? Contact me On Facebook
checkdepeden(){
	cekdep=$(dpkg -l | grep -o 'curl\|grep' | uniq)
	if [[ ! $cekdep =~ "curl" ]]
	then
		sudo apt install curl -y 2>/dev/null
		#for termux
		apt install curl -y 2>/dev/null
		elif [[ ! $cekdep =~ "grep" ]]
			then
				sudo apt install grep -y 2>/dev/null
				#termux
				apt install grep -y 2>/dev/null
	fi
}
checkdepeden
clear
merah='\e[31m'
ijo='\e[1;32m'
kuning='\e[1;33m'
biru='\e[1;34m'
NC='\e[0m'
#intro
printf "${ijo}
	 ██████╗ ██╗   ██╗███████╗███████╗
	██╔════╝ ██║   ██║╚══███╔╝╚══███╔╝
	██║  ███╗██║   ██║  ███╔╝   ███╔╝
	██║   ██║██║   ██║ ███╔╝   ███╔╝
	╚██████╔╝╚██████╔╝███████╗███████╗
	 ╚═════╝  ╚═════╝ ╚══════╝╚══════╝                                 ${biru}
	     Instagram Mass Unfollow
	       Code By : Nasir Ali
	          (NasirDev)
"
printf "${kuning}__________________________________________________${NC}\n\n"
rm followedlist.txt 2>/dev/null
printf "${kuning}[+]${NC} Username : ";read uname
printf "${kuning}[+]${NC} Password : "; read -s pw
printf "\n${kuning}[+]${NC} Logining in..\n"
ambil=$(curl -D - 'https://www.instagram.com/accounts/login/' -H 'authority: www.instagram.com' -H 'cache-control: max-age=0' -H 'upgrade-insecure-requests: 1' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' --compressed -s)
rur=$(echo "$ambil" | grep -Po '(?<=rur=)[^;]*')
mid=$(echo "$ambil" | grep -Po '(?<=mid=)[^;]*')
csrf=$(echo "$ambil" | grep -Po '(?<=csrftoken=)[^;]*')
mcd=$(echo "$ambil" | grep -Po '(?<=mcd=)[^;]*')
rolout=$(echo "$ambil" | grep -Po '(?<=rollout_hash":")[^"]*')
login=$(curl -D - 'https://www.instagram.com/accounts/login/ajax/' -H 'origin: https://www.instagram.com' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'x-requested-with: XMLHttpRequest' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' -H "cookie: rur=$rur; mid=$mid; csrftoken=$csrf; mcd=$mcd" -H "x-csrftoken: $csrf" -H "x-instagram-ajax: $rolout" -H 'content-type: application/x-www-form-urlencoded' -H 'accept: */*' -H 'referer: https://www.instagram.com/accounts/login/' -H 'authority: www.instagram.com' --data "username=$uname&password=$pw&queryParams=%7B%7D" --compressed -s -L)
check=$(echo "$login" | grep -Po '(?<=checkpoint_url": ")[^"]*')
usid=$(echo "$login" | grep -Po '(?<=userId": ")[^"]*')
isauth=$(echo "$login" | grep -Po '(?<=authenticated": )[^,]*')
session=$(echo "$login" | grep -Po '(?<=sessionid=)[^;]*')
if [[ $isauth == "true" ]]
then
	printf "${ijo}[+]${NC} Login Success..\n"
	printf "${ijo}[+]${NC} User ID : $usid\n"
else
	if [[ $check == '' ]]
	then
		printf "${merah}[+]${NC} Login Failed \n"
		exit
	else
		printf "${kuning}[+]${NC} Verification Needed..\n"
		ntd=$(curl "https://www.instagram.com$check" -H 'origin: https://www.instagram.com' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'x-requested-with: XMLHttpRequest' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' -H "cookie: mcd=$mcd; mid=$mid; csrftoken=$csrf; rur=$rur" -H "x-csrftoken: $csrf" -H "x-instagram-ajax: $rolout" -H 'content-type: application/x-www-form-urlencoded' -H 'accept: */*' -H 'referer: https://www.instagram.com$check' -H 'authority: www.instagram.com' --data 'choice=1' --compressed -s)
		printf "${kuning}[+]${NC} Input Verification Code : "; read verif
		stats=$(curl "https://www.instagram.com$check" -H 'origin: https://www.instagram.com' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'x-requested-with: XMLHttpRequest' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' -H "cookie: mcd=$mcd; mid=$mid; csrftoken=$csrf; rur=$rur" -H "x-csrftoken: $csrf" -H "x-instagram-ajax: $rolout" -H 'content-type: application/x-www-form-urlencoded' -H 'accept: */*' -H "referer: https://www.instagram.com$check" -H 'authority: www.instagram.com' --data "security_code=$verif" --compressed -s | grep -Po '(?<=status": ")[^"]*')
		if [[ $stats == "fail" ]]
			then
				printf "${merah}[+]${NC} Verification Failed\n"
				exit
			fi

	fi
fi
grabfollowing=$(curl -s "https://www.instagram.com/graphql/query/?query_hash=c56ee0ae1f89cdbd1c89e2bc6b8f3d18&variables=%7B%22id%22%3A%22$usid%22%2C%22include_reel%22%3Atrue%2C%22fetch_mutual%22%3Afalse%2C%22first%22%3A24%7D" -H "cookie: mcd=$mcd; csrftoken=$csrf; ds_user_id=$usid; sessionid=$session; rur=$rur" -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' -H 'accept: */*' -H 'authority: www.instagram.com' -H 'x-requested-with: XMLHttpRequest' --compressed -s)
followingcount=$(echo "$grabfollowing" | grep -Po '(?<=count":)[^,]*')
followingid=$(echo "$grabfollowing" | grep -Po '(?<=id":")[^"]*' | uniq)
echo "$followingid" >> followedlist.txt
sort -u -o followedlist.txt followedlist.txt
printf "${ijo}[+]${NC} You Are Following $followingcount Account\n"
unfoll(){
	followedname=$(echo "$grabfollowing" | grep "$followinglist" | grep -Po "(?<=id\":\"$followinglist\",\"username\":\")[^\"]*")
	followed=$(echo "$followinglist" | cut -f1 -d ':')
	dounfol=$(curl -s "https://www.instagram.com/web/friendships/$followed/unfollow/" -X POST -H 'origin: https://www.instagram.com' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'x-requested-with: XMLHttpRequest' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' -H "cookie: mcd=$mcd; csrftoken=$csrf; ds_user_id=$usid; sessionid=$session; rur=$rur" -H "x-csrftoken: $csrf" -H "x-instagram-ajax: $rolout" -H 'content-type: application/x-www-form-urlencoded' -H 'accept: */*' -H 'authority: www.instagram.com' -H 'content-length: 0' --compressed)
	statuss=$(echo "$dounfol" | grep -Po '(?<=status": ")[^"]*')
	if [[ $statuss == 'ok' ]]
	then
		printf "${ijo}[+]${NC} $followedname [Unfollowed]\n"
	elif [[ $dounfol =~ "Please wait a few minutes" ]];then
		printf "${merah}[+]${NC} Can't Unfollow $followedname [Sleeping 90sec]\n"
		sleep 1
	else
		printf "${merah}[+]${NC} $followedname Can't be Unfollowed Using This Tool\n"
	fi
}
for followinglist in $(cat followedlist.txt)
do
	unfoll
	sleep 2
done
rm followedlist.txt 2>/dev/null