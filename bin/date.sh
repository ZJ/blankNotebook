#!/bin/bash

OSCHECK="$(uname -s)"
if [ "$OSCHECK" = "Darwin" ]
then
	YEARONLY="$(date -j -f %Y%m%d $1 +%Y)"
	YEARMONTH="$(date -j -f %Y%m%d $1 +%Y%m)"
	YEARMONTHDAY="$(date -j -f %Y%m%d $1 +%Y%m%d)"
	ENTRYDATE="$(date -j -f %Y%m%d $1 +"%Y-%m-%d")"
else
	YEARONLY="$(date --date=$1 +%Y)"
	YEARMONTH="$(date --date=$1 +%Y%m)"
	YEARMONTHDAY="$(date --date=$1 +%Y%m%d)"
	ENTRYDATE="$(date --date=$1 +"%Y-%m-%d")"
fi

TEMPLATEPATH="./src/template/template"

BODYSUFFIX="-body.txt"
TODOSUFFIX="-todo.txt"
FILESUFFIX=".lbnb"

FOLDERPATH="./src/${YEARONLY}/${YEARMONTH}"
FILEPATH="${FOLDERPATH}/${YEARMONTHDAY}"

# Make today's todo section template, then edit it
if [ ! -f "${FILEPATH}${FILESUFFIX}" ]
then
	OLDEXPR=".*${YEARMONTHDAY}${FILESUFFIX}"
	# Today's file must exist before we can find the one before it
	touch "${FILEPATH}${FILESUFFIX}"
	# Use awk to print the filename lexically before today's file.  Our sorting scheme forces this to be the most recent todo
	OLDPATH="$(find src -mindepth 3 -maxdepth 3 -iname *${FILESUFFIX} | sort | awk '$0~p{print a}{a=$0}' p=${OLDEXPR})"	
	sed '1,/% end td section/d' "${OLDPATH}" | sed 's/\\startTodo/\\startDone/' | cat "${TEMPLATEPATH}${BODYSUFFIX}" - "${TEMPLATEPATH}${TODOSUFFIX}" | sed "s/@date@/${ENTRYDATE}/" > "${FILEPATH}${FILESUFFIX}"
fi
vim "${FILEPATH}${FILESUFFIX}" "+call cursor(4, 1)"

