#!/bin/bash

YEARONLY="$(date +%Y)"
YEARMONTH="$(date +%Y%m)"
YEARMONTHDAY="$(date +%Y%m%d)"
ENTRYDATE="$(date +"%Y-%m-%d")"

TEMPLATEPATH="./src/template/template"

BODYSUFFIX="-body.txt"
TODOSUFFIX="-todo.txt"
FILESUFFIX=".lbnb"

FOLDERPATH="./src/${YEARONLY}/${YEARMONTH}"
FILEPATH="${FOLDERPATH}/${YEARMONTHDAY}"

mkdir -p "${FOLDERPATH}"

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

