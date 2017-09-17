#!/usr/bin/bash
IFS='=' read -a args1 <<< "$1"
make_dir=${args1[1]}
IFS="=" read -a args2 <<< "$2"
e_fst=${args2[1]}
IFS="=" read -a args3 <<< "$3"
t_fst=${args3[1]}
IFS="=" read -a args4 <<< "$4"
g_fst=${args4[1]}
inp_file="$5"
D="P1.fst"
P="P2.fst"
T_inv="T_inv.fst"
temp_fst="temp.fst"
fstinvert $t_fst $T_inv
fstarcsort --sort_type=ilabel $g_fst $g_fst
fstarcsort --sort_type=olabel $T_inv $T_inv
fstcompose $T_inv $g_fst $D
fstarcsort --sort_type=ilabel $D $D
fstarcsort --sort_type=olabel $e_fst $e_fst
fstcompose $e_fst $D $P
fstarcsort --sort_type=ilabel $P $P
correct_counter=0
all_counter=0
while read -r spell_id corr_word wrong_word
do
	# num=0
 #    for (( i=0; i<${#wrong_word}; i++ )); do
	# 	echo "$i $((i + 1)) ${wrong_word:$i:1}" >> "./"$make_dir"/"$spell_id".fsa.txt"
	# 	num=$((i+1))
	# done
	# echo "$num" >> "./"$make_dir"/"$spell_id".fsa.txt"
	fstcompose $make_dir"/"$spell_id".fsa" $P $temp_fst
	fstshortestpath $temp_fst $temp_fst
	check=`fstprint --isymbols="lets.vocab" --osymbols="words.vocab" $temp_fst | head -n1 | cut -f4`
	all_counter=$((all_counter+1))
	if [ "$check" == "$corr_word" ]
		then
		correct_counter=$((correct_counter+1))
	fi
done < "$inp_file"
echo $correct_counter
echo $all_counter