# -*- coding: utf-8 -*-
import pandas as pd

class DataFrameOp:
    def __init__(self,theDataFrame ):
        if isinstance(theDataFrame, pd.DataFrame):
            self.theDF = theDataFrame.dropna(axis=1, how='all')
        elif isinstance(theDataFrame, str):
            df = pd.read_excel(theDataFrame)
            self.theDF = df.dropna(axis=1, how='all')
        self.theName = self.theDF.iat[0,0]
    
        self.theDF = self.theDF.dropna(thresh=len(self.theDF.columns)-1)
        self.theDF = self.theDF.dropna(axis=1, how='all')
            
    def getName(self):
        return self.theName