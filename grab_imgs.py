import re
import urllib.request
import time

## Grabs all the images off a scribd page
# requires html source to be downloaded into a local file

## Inputs
bookname = "Balanis-Advanced-EM"	# base output file name
htmlfile = "file.html"				# html input file name
#outfile = "linklist.txt"			# output file for all links (currently unused)

img = re.compile("^<img class.+ orig=\"(\S+)\"\/>")
img_firsthalf = re.compile('(http\S+/images/)\S+.jpg')
json = re.compile("^\s+pageParams\.contentUrl = \"\S+pages/(\S+)\.jsonp\";")
jpg = re.compile(".+(http\S+\.jpg)")


f = open(htmlfile)
#out = open(outfile,'w')


## Get all image links
img_links = []

linecounter = 0
img_count = 0
urlpre = []
print("Parsing html file for image linkes...")
for line in f:

	mi = img.match(line)
	mj = json.match(line)
	
	if mi: # we found an HTML img tag! easy peasy
		link = mi.group(1)
		mi2 = img_firsthalf.match(link)
		urlpre = mi2.group(1)

	elif mj: #jsonp! Crap!
		link = urlpre + mj.group(1) + ".jpg"
		"""
		f = urllib.request.urlopen(link)
		s = f.read()
		s = s.decode('cp1252')  # ugly codepage hack! This probably won't be the same from machine to machine
		f.close()
		"""

		#mp = jpg.match(s)
		#if mp:
		#	link = mp.group(1)
		
		
	if mi or mj:
		# wait periodically to keep websites from being mad =(
		if (img_count % 100 == 0):
			time.sleep(15)

		#out.write(link + "\n")
		img_links.append(link)
		print("...found " + link)

		img_num_str = str(img_count).zfill(4)
		img_name = bookname + "_" + img_num_str + ".jpg"
		urllib.request.urlretrieve(link, filename = img_name)
		img_count = img_count + 1
	
	linecounter = linecounter + 1
	


print("Finished grabbing files!")
print("Total images grabbed: " + str(len(img_links)) )

"""
for img in img_links:
	img_num_str = str(img_count).zfill(4)
	img_name = bookname + "_" + img_num_str + ".jpg"
	urllib.request.urlretrieve(img, filename = img_name)
"""

	
f.close()
#out.close()

