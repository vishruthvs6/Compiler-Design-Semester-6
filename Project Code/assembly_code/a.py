def assembly(code):
	#dictionary to store 'var:register' mapping
	registers = {}
	reg_count = 0
	for instr in code:
		#remove newlines 
		if "" == instr:
			pass
		
		#conditional jump
		elif "ifFalse" in instr:
			#ifFalse t5 goto L1
			global cond_flag
			instr = instr.strip().split()
			print("\t" + cond_flag + instr[3])
			
		#unconditional jump statements
		elif "goto" in instr:
			#goto L0
			instr = instr.strip().split()
			print("\tBR " + instr[1])
		
		#labels : L1,L2...
		elif ":" in instr:
			print(instr)
		
		#icg
		else:
			instrn = instr.split()
			dest = instrn[0]
			
			#2 operands
			if(len(instrn)==3):
				src = instrn[2]
				
				if src in registers:
						registers[dest] = registers[src]
						print("\tST " + dest + ",R" + str(registers[src]))
				else:
					reg_count = (reg_count%13) + 1		
					registers = check_reg_taken(registers,reg_count)
					registers[dest] = reg_count
					registers[src] = reg_count
					if src.isdigit():
						print("\tMOV R" + str(reg_count) + ",#" + src)
					else:
						print("\tLD R" + str(reg_count) + "," + src)
					print("\tST " + dest + ",R" + str(reg_count))
					
				
			#3 operands	
			else:
				operator = instrn[3]
				src1 = instrn[2]
				src2 = instrn[4]
				
				registers,reg_count,r1 = load_reg(registers,reg_count,src1)
				registers,reg_count,r2 = load_reg(registers,reg_count,src2)
				if operator in ['<','>','<=','>=','==','!=']:
					registers,reg_count = cond_operation(registers,reg_count,operator,r1,r2)
				else:
					registers,reg_count = arith_operation(registers,reg_count,dest,operator,r1,r2)
					
				
			
#load into registers
def load_reg(registers,reg_count,variable):
	#already in some register....so dont create another register
	if variable in registers:
		return registers,reg_count,registers[variable]
	else:
		reg_count = (reg_count%13) + 1		
		registers = check_reg_taken(registers,reg_count)
		registers[variable] = reg_count
		if variable.isdigit():
			print("\tMOV R" + str(reg_count) + ",#" + variable)
		else:
			print("\tLD R" + str(reg_count) + "," + variable)
		return registers,reg_count,reg_count
		
			
#check if the register is already taken and delete the old value if taken
def check_reg_taken(registers,reg_count):
	for var in registers.copy():
		if registers[var]==reg_count:
			registers.pop(var)
	return registers
	

#perform arithmetic operations
def arith_operation(registers,reg_count,dest,operator,r1,r2):
	#create a new register to store result
	reg_count = (reg_count%13) + 1		
	registers = check_reg_taken(registers,reg_count)
	registers[dest] = reg_count
	operators = {"+":"ADD","-":"SUB","*":"MUL","/":"DIV"}
	print("\t" + operators[operator] +" R" + str(reg_count) + "," + "R"+ str(r1) + ",R" + str(r2))
	
	return registers,reg_count


#conditional branches
def cond_operation(registers,reg_count,operator,r1,r2):
	global cond_flag
	#conditions = {"<":"BGE ",">":"BLE ","<=":"BGT ",">=":"BLT ","==":"BNE ","!=":"BE "}
	#print("\tCMP R" + str(r1) + ",R" + str(r2))
	
	conditions = {"<":"BGEZ ",">":"BLEZ ","<=":"BGZ ",">=":"BLZ ","==":"BNEZ ","!=":"BEZ "}
	#create a new register to store result
	reg_count = (reg_count%13) + 1		
	registers = check_reg_taken(registers,reg_count)
	print("\tSUB R" + str(reg_count) + ",R" + str(r1) + ",R" + str(r2))
	cond_flag = conditions[operator]
	return registers,reg_count
	  


if __name__ == "__main__":
	f = open("icg.txt")
	code = f.read()
	code = code.split('\n')
	cond_flag = ""
	print("MAIN:")
	assembly(code)


