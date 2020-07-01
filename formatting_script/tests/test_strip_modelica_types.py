"""
milicag, may 2020
"""

import unittest
import os

from strip_modelica_types import StripModelicaTypes

from pdb import set_trace as bp

class StripModelicaTypesTests(unittest.TestCase):
	"""Tests conversion of parameter type definition
	"""

	@classmethod
	def setUp(self):

		self.file_path = "C:/Users/deva713/OneDrive - PNNL/Documents/Git_repos/modelica-buildings/formatting_script/tests/test.mo"
		# make a copy of the modelica library
		self.package_path = "C:/Users/deva713/OneDrive - PNNL/Documents/Git_repos/modelica-buildings_issue1916/Buildings/Controls/OBC/ASHRAE/PrimarySystem"


	def test_single_file(self):
		"""
		"""
		result = StripModelicaTypes(
			self.file_path, overwrite=False)

		bp()

	def test_tree(self):
		"""
		"""
		result = StripModelicaTypes(
			self.package_path, overwrite=True)