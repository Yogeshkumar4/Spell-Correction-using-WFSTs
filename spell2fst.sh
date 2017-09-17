#!/usr/bin/bash
# filename="dev.txt"
# while read -r spell_id corr_word wrong_word
# do
# 	num=0
#     for (( i=0; i<${#wrong_word}; i++ )); do
# 		echo "$i $((i + 1)) ${wrong_word:$i:1}" >> "./dev_word/"$spell_id".fsa.txt"
# 		num=$((i+1))
# 	done
# 	echo "$num" >> "./dev_word/"$spell_id".fsa.txt"
# done < "$filename"
IFS='=' read -a args1 <<< "$1"
make_dir=${args1[1]}
IFS="=" read -a args2 <<< "$2"
isymbol=${args2[1]}
inp_file="$3"
while read -r spell_id corr_word wrong_word
do
	num=0
    for (( i=0; i<${#wrong_word}; i++ )); do
		echo "$i $((i + 1)) ${wrong_word:$i:1}" >> "./"$make_dir"/"$spell_id".fsa.txt"
		num=$((i+1))
	done
	echo "$num" >> "./"$make_dir"/"$spell_id".fsa.txt"
	fstcompile --acceptor --isymbols=$isymbol "./"$make_dir"/"$spell_id".fsa.txt" "./"$make_dir"/"$spell_id".fsa"
done < "$inp_file"