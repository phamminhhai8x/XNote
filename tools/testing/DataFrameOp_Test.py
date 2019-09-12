#!/usr/bin/env python -W ignore::PendingDeprecationWarning
#!/usr/bin/env python -W ignore::DeprecationWarning
import pandas as pd
import unittest

from DataFrameOp import DataFrameOp as DFO


class TestDataFrameOp(unittest.TestCase):
    def test_init1(self):
        df = pd.read_excel('../lib/DB/DBTables.xlsx')
        theDFO = DFO(df) 
        self.assertTrue(theDFO.getName() == 'XNoteItem','init by DataFrame object')
#         print(theDFO.theDF)
    def test_init2(self):
        theDFO = DFO('../lib/DB/DBTables.xlsx') 
        self.assertTrue(theDFO.getName() == 'XNoteItem','init by path of xlsx file')
    def test_init3(self):
        with self.assertRaises(TypeError):
            DFO()
            
if __name__ == '__main__':
    unittest.main()