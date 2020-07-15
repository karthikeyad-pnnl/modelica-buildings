"""
milicag, may 2020
"""
import re
import pathlib

from pdb import set_trace as bp

class StripModelicaTypes(object):
	"""Finds any parameters specified
	as modelica standard library units 
	and converts to using a CDL supported 
	type and unit specification.
	For example, replaces:
	parameter Modelica.SIunits.Time rotationPeriod(final displayUnit="h") = 1209600
	By:
	parameter Real rotationPeriod(final unit="s", final quantity="Time", displayUnit="h") = 1209600
	Note: This will currently not catch parameters that are
	defined with a Modelica.SIunit, but also have an argument such 
	as 'displayUnit' passed to it.
	"""
	def __init__(self, path, overwrite=False):

		self.to_replace = {
			# "Modelica.SIunits.Time" : "(\n    final unit=\"s\",\n    final quantity=\"Time\",\n    final displayUnit=\"h\")",
			'  CDL.' : '  Buildings.Controls.OBC.CDL.',
			' \"' : '\n    \"'
		}

		paths = []
		# single file
		if re.split(r'\.',path)[-1] == 'mo':
			paths.append(path)

		else:
			# it is a package, make a list of paths
			for item in pathlib.Path(path).glob('**/*'):
				try:
					if re.split(r'\.',str(item))[-1] == 'mo':
						paths.append(str(item))
				except:
					print("Not able to check if this is a model file: {}".format(item))
		
		for file_name in paths:
			self.global_paths(file_name, overwrite=True)
			# self.line_breaks(file_name, overwrite=True)		
	
	def global_paths(self, path, overwrite=False):
		lines = tuple(open(path, 'r'))

		file_with_units_replaced = ""

		# for key in list(self.to_replace.keys()):
		# 	for line in lines:
		# 		try:
		# 			if key in line:
		# 				line = line.replace(key, self.to_replace[key])
		# 				text = line

		# 			else:
		# 				# append to the new file unchanged
		# 				text = line

		# 			file_with_units_replaced = \
		# 					file_with_units_replaced + \
		# 					text
		# 		except:
		# 			print("In {} not able to replace for {} line".format(path, line))


		for line in lines:
			index = lines.index(line)
			# print(index)
			try:
				if "  CDL." in line:
					line = line.replace('  CDL.', '  Buildings.Controls.OBC.CDL.')
					text = line

				if ((";" in line) and not('end' in line)):
					if  not(lines[index+1]=="\n"):
						# print(index)
						line = line.replace(';', ';\n')
						# print("Found it")
						text = line

				if ("(final" in line):
					# print(line[line.index("final")-1])
					line=line.replace('(final', '(\n    final')
					text = line

				if (('"' in line) and not (('    "') in line)):
					line = line.replace(' "', '\n    "')

				if 'nChi' in line:
					line=line.replace('nChi','nBoi')
					text=line

				if 'chiller' in line:
					line=line.replace('chiller', 'boiler')
					text=line

				if 'Chiller' in line:
					line=line.replace('Chiller', 'Boiler')
					text=line

				if 'Chilled water' in line:
					line=line.replace('Chilled water', 'Hot water')
					text=line

				if 'chilled water' in line:
					line=line.replace('chilled water', 'hot water')
					text=line

				# if (("final" in line) and (',' in line) and ((line[line.index(",")+2] =="f"))):# and ((line[line.index("final")-1] ==" "))):
				# 	print(index)
				# 	line=line.replace(', final',',\n    final')
				# 	text = line

				else:
					# append to the new file unchanged
					text = line

				file_with_units_replaced = \
						file_with_units_replaced + \
						text
			except:
				print("In {} not able to replace for {} line".format(path, line))

		if overwrite:
			outpath=path
		else:
			outpath=re.split(r'\.mo',path)[0] + \
				'_converted' + '.mo'

		file_out = open(outpath, "w")
		file_out.write(file_with_units_replaced)
		file_out.close()

		return file_with_units_replaced
