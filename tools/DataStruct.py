# -*- coding: utf-8 -*-
from DataFrameOp import DataFrameOp as Base

class DataStruct(Base):
    MAX_TYPE_NAME_LENGTH = 16
    MAX_MEMBER_NAME_LENGTH = 32
    def __init__(self,theDataFrame ):
        """ Base on DataFrameOp and remove Unnamed column indexer"""
        Base.__init__(self, theDataFrame)
        unNameCol = [col for col in self.theDF.columns if 'Unnamed' in col]
        if not unNameCol is None:
            
#             myDic = dict(zip(self.theDF.columns.values.tolist(),self.theDF.iloc[0].values.tolist())) 
#             df = self.theDF.rename(columns = myDic)

#             myDic = {self.theDF.columns.values[i] : self.theDF.iloc[0].values[i] for i in range(self.theDF.columns.size)}
#             df = self.theDF.rename(columns = myDic)
#             use first row for column indexer
            df = self.theDF.rename(columns = dict(zip(self.theDF.columns.values.tolist(),self.theDF.iloc[0].values.tolist())))
            df = df.drop(df.index[0])
            self.theDF = df
            
        
    def getType(self):
        return self.theDF['Type']
    def elementsCount(self):
        return len(self.theDF.index)
    def fieldsCount(self):
        return len(self.theDF.columns)
    
    def toDarkClass(self):
        rs = "class " + self.theName + " {"
        rs = rs + self.genDarkClassMember()
        rs = rs + "\n}"
        return rs
    def genDarkClassMember(self):
        rs = ''.join(\
                     [''.join(\
                              "\n" + ''.ljust(4) + \
                              str(self.theDF.iloc[i]['Type']).ljust(self.MAX_TYPE_NAME_LENGTH if len(self.theDF.iloc[i]['Type']) < self.MAX_TYPE_NAME_LENGTH else len(self.theDF.iloc[i]['Type']) + 1) +\
                              (str(self.theDF.iloc[i]['Name']) + ";").ljust(self.MAX_MEMBER_NAME_LENGTH if len(self.theDF.iloc[i]['Name']) < self.MAX_MEMBER_NAME_LENGTH else len(self.theDF.iloc[i]['Name']) + 1) +\
                              "/// " + str(self.theDF.iloc[i]['Description'])) \
                       for i in range(self.elementsCount())\
                       ]\
                     )
        return rs
    def genDarkClassConstructor(self):
        rs = self.theName + "({"
        rs = rs + ''.join([''.join("\n" + ''.ljust(4) +"this." + \
                                   str(self.theDF.iloc[i]['Name'] + (',' if i < self.elementsCount()-1 else '')) \
                                   for i in range (self.elementsCount()))])
        rs = rs + "\n});"
        return rs
    def genDarkJson2Object(self):
        rs = 'factory ' + self.theName + '.fromMap(Map<String, dynamic> json) {'
        rs = rs + '\n' + ''.ljust(4) + 'return new ' + self.theName + '('
        
        rs = rs + ''.join(["\n" + ''.ljust(4) + str(self.theDF.iloc[i]['Name'])+': json["'+ str(self.theDF.iloc[i]['Name']) +'"],' \
                 for i in range (self.elementsCount())\
                 ])
        
        rs = rs + '\n' + ''.ljust(4) + ');'
        rs = rs + '\n}'
        return rs