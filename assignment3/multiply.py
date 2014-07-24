import MapReduce
import sys

"""
Word Count Example in the Simple Python MapReduce Framework
"""

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: document identifier
    # value: document contents
    if record[0]=="a":
        i=record[1]
        j=record[2]
        a_ij=record[3]
        for k in range (0,5):
            mr.emit_intermediate((i,k),("a",j,a_ij))
    else:
        j=record[1]
        k=record[2]
        b_jk=record[3]
        for i in range (0,5):
            mr.emit_intermediate((i,k),("b",j,b_jk))
    

            
def reducer(key, list_of_values):
    # key: word
    # value: list of occurrence counts
    dictA={}
    dictB={}
    for v in list_of_values:
        if v[0]=="a":
            dictA[v[1]]=v[2]
        else:
            dictB[v[1]]=v[2]

    result=0
    for j in range (0,5):
        if j in dictA:
            a_ij=dictA[j]
        else:
            a_ij=0
        if j in dictB:
            b_jk=dictB[j]
        else:
            b_jk=0    
        result = result + a_ij*b_jk
        mr.emit((key[0],key[1],result))

    
# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)
