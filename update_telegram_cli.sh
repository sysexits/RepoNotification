#!/bin/bash

SendMessage() {
	cd /opt/tg
	(echo "contact_list" ; echo "msg Jaehyun_Jang $1 $2"; echo "safe_quit") | ./bin/telegram-cli -k ./tg-server.pub -W
}

#Notification for each repo
InitialNoti() {
	GITFILE="/.git"
	sudo git --git-dir=$1$GITFILE fetch origin
	RESLOG=$(sudo git --git-dir=$1$GITFILE log HEAD..origin/master --oneline)
	if [[ "${RESLOG}" != "" ]]; then
		echo $RESLOG
	else
		RESLOG=""
		echo ""
	fi
}

Notification() {
	GITFILE="/.git"
	sudo git --git-dir=$1$GITFILE fetch origin
	RESLOG=$(sudo git --git-dir=$1$GITFILE log HEAD..origin/master --oneline)
	if [[ $RESLOG=$2 ]]; then
		echo $RESLOG
	else
		if [[ "${RESLOG}" != "" ]]; then
			echo $RESLOG
		else
			RESLOG=""
			echo $RESLOG
		fi

	fi
}

while read folder; do
	i=0
	if [ -a "$folder/.hashes" ]; then
		while read -r repo && read -r hash <&3; do
			RETVAL=$(Notification $folder$repo $hash)
			hashes[$i]=$RETVAL
			if [[ "${RETVAL}" != "" && "${RETVAL}" != "$hash" ]]; then
				SendMessage $folder$repo "${RETVAL}"
			fi
			i=$(($i+1))
		done < "$folder/.repos" 3<"$folder/.hashes"
	else
		while read -r repo; do
			RETVAL=$(InitialNoti $folder$repo)
			hashes[$i]=$RETVAL
			if [[ "${RETVAL}" != "" ]]; then
				SendMessage $folder$repo "${RETVAL}"
			fi
			i=$(($i+1))
		done < "$folder/.repos"
	fi
	sudo printf "%s\n" "${hashes[@]}" > "$folder/.hashes"
	unset hashes
done < "./.folders"