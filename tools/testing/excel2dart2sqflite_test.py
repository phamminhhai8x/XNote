import pandas as pd
import unittest

import excel2dart2sqflite as testTarget
from DataFrameOp import DataFrameOp

class TestExcel2dart2sqflite(unittest.TestCase):
    def test_1(self):
        self.assertTrue(testTarget.checkExcelFormat())
    def test_2(self):
        self.assertTrue(testTarget.checkExcelFormat())
    def test_3(self):
        self.assertTrue(testTarget.checkExcelFormat())
if __name__ == '__main__':
    unittest.main()