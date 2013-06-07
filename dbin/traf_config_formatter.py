#!/usr/bin/python
import xml.etree.ElementTree as TREE
import sys

def formattree(level, element, currentoutput):
	indent = ''
	for i in range(0,level):
		indent += '	'
	childstring = ''
	for child in sorted(element.getchildren()):
		cur = formattree(level + 1, child, '')
		childstring = childstring + cur
	optag = indent + '<' + element.tag
	prefix = '\n'
	for k in sorted(element.attrib):
		optag = optag + prefix + indent + '	' + k + '="' + element.attrib[k] + '"\n'
		prefix = ''
	if len(element.getchildren()) == 0:
		optag = optag + indent + '/>\n'
		return currentoutput + optag
	else:
		optag = optag + indent + '>\n'
		return currentoutput + optag + childstring + indent + '</' + element.tag + '>\n'

if __name__ == '__main__':	
	filename = sys.argv[1]
	tree = TREE.parse(filename)
	print formattree(0, tree.getroot(), '')
