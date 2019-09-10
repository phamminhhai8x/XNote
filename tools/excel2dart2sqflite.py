import pandas as pd
# from pandas import ExcelWriter
# from pandas import ExcelFile
# from xlrd import book
# from elementpath.xpath1_parser import axis

def checkExcelFormat():
    if (1):
        return True
    else:
        return False
def checkExcelFormat2():
    if (1):
        return True
    else:
        return False
def checkExcelFormat3():
    xl_file = pd.ExcelFile("../lib/DB/DBTables.xlsx")
 
    df = pd.read_excel('../lib/DB/DBTables.xlsx')
    print(df)
     
    #nul_rows = xl_file.book.sheet_by_index(0).nrows
    mybook = xl_file.book
    mySheet = mybook.sheet_by_index(0)
    nul_rows = mySheet.nrows
    print(nul_rows)
    print(df.iat[0,1])
     
    real_df = df.dropna(axis=1, how='all')
    if real_df.iat[0,0] != 'XNoteItem':
        print('Err')
    else:
        print(real_df.iloc[1:,1:])
        
    if (1):
        return True
    else:
        return False




