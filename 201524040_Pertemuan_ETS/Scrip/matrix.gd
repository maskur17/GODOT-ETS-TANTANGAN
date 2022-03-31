extends Node2D

func _ready():
	pass # Replace with function body.

func matrix3x3SetIdentity():
	var m = [[0,0,0],[0,0,0],[0,0,0]]
	
	for i in range (3):
		for j in range(3):
			if(i == j):
				m[i][j] = 1
			else :
				m[i][j] = 0
				
	return m
		
# Multiplies matrix a times b, putting result in b
func matrix3x3PreMultiply(a, b):
	var temp = [[0,0,0],[0,0,0],[0,0,0]]
	
	for r in range (3):
		for c in range (3):
			temp[r][c] = a[r][0]*b[0][c] + a[r][1]*b[1][c] + a[r][2]*b[2][c]
			
	for r in range (3):
		for c in range (3):
			b[r][c] = temp[r][c]
			

# Adding matrix a + b, putting result in b 
func matrixTambah (a, b):
	for r in range (3):
		for c in (3):
			b[r][c] += a[r][c]

func matrixKurang (a, b):
	for r in range (3):
		for c in (3):
			b[r][c] -= a[r][c]
