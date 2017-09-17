import math
'''
# Question A part 1
f = open("./words.vocab","r").readlines()
fst_file = open("./fst_text.fst","w")
state_counter = 1
for line in f:
	word = line.split("\t")
	fst_file.write("0 " + str(state_counter) + " " + str(word[0]) + " " + str(word[0][0]) + " 0.0\n")
	state_counter += 1
	for elem in word[0][1:]:
		fst_file.write(str(state_counter - 1) + " " + str(state_counter) + " - " + str(elem) + " 0\n")
		state_counter += 1
	fst_file.write(str(state_counter - 1) +  " 1.0\n")	
'''
################################
'''
# Question A part 2
f = open("./wordcounts.txt","r").readlines()
fst_file = open("./grammar.txt","w")
vocab_len = len(f)
for line in f:
	word = line.split(" ")
	fst_file.write("0 0 " + str(word[0]) + " " + str(word[0]) + " " + str((-1)*math.log(float(word[1])/vocab_len)) + "\n")
fst_file.write("0 0.0")	
'''
###############################

f = open("./lets.vocab","r").readlines()
fst_file = open("./E_swap.txt","w")
letters = set()
for line in f:
	letters.add(line.split("\t")[0])
letters = list(letters)
state_counter = 2
for elem in letters:	
	for out_elem in letters:
		if out_elem == elem:
			if elem == "-":
				continue
			fst_file.write("0 0 " + str(elem) + " " + str(out_elem) + " 0\n")
			fst_file.write("1 1 " + str(elem) + " " + str(out_elem) + " 0\n")
		else:
			fst_file.write("0 1 " + str(elem) + " " + str(out_elem) + " 1\n")
			if elem != "-" and out_elem != "-":
				fst_file.write("0 " + str(state_counter) + " " + str(elem) + " " + str(out_elem) + " 0\n")
				fst_file.write(str(state_counter) + " 1 " + str(out_elem) + " " + str(elem) + " 1\n")
				state_counter += 1
	# if elem != "-":			
		# fst_file.write("0 2 " + str(elem) + " " + str(elem) + " 0.5\n")
		# fst_file.write("2 1 - " + str(elem) + " 0.0\n")
		# fst_file.write("0 3 " + str(elem) + " " + str(elem) + " 0.5\n")
		# fst_file.write("3 1 " + str(elem) + " - 0.0\n")
fst_file.write("1 0.0\n")			
fst_file.write("0 1.0")		

