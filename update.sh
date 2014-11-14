#!/bin/bash

#Notification for each repo
InitialNoti() {
	GITFILE="/.git"
	git --git-dir=$1$GITFILE fetch origin
	RESLOG=$(git --git-dir=$1$GITFILE log HEAD..origin/master --oneline)
	if [[ "${RESLOG}" != "" ]]; then
		/usr/bin/osascript -e "display notification \"need to update\" with title \"$1\" subtitle \"$RESLOG\""
		echo $RESLOG
	else
		echo "_"
	fi
}

Notification() {
	GITFILE="/.git"
	git --git-dir=$1$GITFILE fetch origin
	RESLOG=$(git --git-dir=$1$GITFILE log HEAD..origin/master --oneline)
	if [[ $RESLOG=$2 ]]; then
		echo "_"
	else
		if [[ "${RESLOG}" != "" ]]; then
			/usr/bin/osascript -e "display notification \"need to update\" with title \"$1\" subtitle \"$RESLOG\""
			echo $RESLOG
		else
			echo "_"
		fi

	fi
}

while read folder; do
	cd $folder
	i=0
	if [ -a "./.hashes" ]; then
		while read -r repo && read -r hash <&3; do
			RETVAL=$(Notification $repo $hash)
			hashes[$i]=$RETVAL
			i=$(($i+1))
		done < "./.repos" 3<"./.hashes"
	else
		while read -r repo; do
			RETVAL=$(InitialNoti $repo)
			hashes[$i]=$RETVAL
			i=$(($i+1))
		done < "./.repos"
	fi
	printf "%s\n" "${hashes[@]}" > ".hashes"
done < "./.folders"
