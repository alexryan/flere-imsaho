import os
import sys
import glob

thePath = str(os.environ['FLERE_IMSAHO'])
#print("thePath=" + thePath)

#print('Number of arguments:' + str(len(sys.argv)))
#print('Argument List:' + str(sys.argv))

directory=sys.argv[1]
print('directory=' + directory)

fileList = os.listdir(directory)
#print('Files: ' + str(fileList))

#filter = directory + '/*.png'
#print("filter = " + filter)

#fileList = glob.glob(filter)
#print('Files: ' + str(fileList))

os.chdir(directory)
fileList = glob.glob('*.png')

writeThisFile = directory + '/images.html'

# Open a file
fo = open(writeThisFile, "w")

for aFile in fileList:
    tag = '<img src="' + aFile + '"></img>\n'
    fo.write(tag)
    #print(aFile)

plaintext = "Python is a great language.\nYeah its great!!\n"
#fo.write(plaintext)
fo.close()

