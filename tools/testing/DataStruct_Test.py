import pandas as pd
import unittest

from DataStruct import DataStruct as DS
import warnings
with warnings.catch_warnings():
    warnings.filterwarnings("ignore", category=PendingDeprecationWarning)
    warnings.filterwarnings("ignore", category=DeprecationWarning)

class TestDataStruct(unittest.TestCase):
    def test_init1(self):
        df = pd.read_excel('../lib/DB/DBTables.xlsx')
        theDS = DS(df) 
        self.assertTrue(theDS.getName() == 'XNoteItem','init by DataFrame object')
        
    def test_init2(self):
        theDS = DS('../lib/DB/DBTables.xlsx') 
        self.assertTrue(theDS.getName() == 'XNoteItem','init by path of xlsx file')
        self.assertTrue(theDS.elementsCount() == 22, 'element count') 
        self.assertTrue(theDS.fieldsCount() == 3, 'field count')
        
    def test_init3(self):
        with self.assertRaises(TypeError):
            theDS = DS()
            self.assertTrue(theDS.getName() == '','init by nothing')
                
    def test_toDarkClass(self):
        theDS = DS('../lib/DB/DBTables.xlsx')
        expect = """class XNoteItem {
    int             id;                             /// key identify
    String          summary;                        /// summary of note
    String          description;                    /// detail description
    bool            blocked;                        /// status view or not
    int             idTarget;                       /// index of parent note
    int             idUser;                         /// index of user create note
    int             xNoteType;                      /// note type
    int             createDate;                     /// create date (can't modify by user)
    int             startDatePlan;                  /// plan start date
    int             endDatePlan;                    /// plan end date
    int             startDateActual;                /// actual start date
    int             endDateActual;                  /// actual end date
    String          unitCost;                       /// unit of cost (day, hour, minute, second, dollar, lit , meter...)
    int             costEstimate;                   /// cost estimate
    int             costRemain;                     /// cost remain in-progress
    int             costUsed;                       /// cost used in-progress
    int             idUserOwner;                    /// id user detect or raise note
    int             idUserAssign;                   /// user follow to resolve this note
    int             level;                          /// level of note, at simple it 0, but if have a parent it is 1
    int             subNoteCount;                   /// if the note have child, this field will count it's children
    String          csvSubNoteList;                 /// the index of it children will store in this field
    int             status;                         /// status of note
}"""
        print(theDS.genDarkJson2Object())
        self.assertTrue(theDS.toDarkClass() == expect,'generate struct to dart class')
    def test_genDarkClassConstructor(self):
        theDS = DS('../lib/DB/DBTables.xlsx')
        expect = """XNoteItem({
    this.id,
    this.summary,
    this.description,
    this.blocked,
    this.idTarget,
    this.idUser,
    this.xNoteType,
    this.createDate,
    this.startDatePlan,
    this.endDatePlan,
    this.startDateActual,
    this.endDateActual,
    this.unitCost,
    this.costEstimate,
    this.costRemain,
    this.costUsed,
    this.idUserOwner,
    this.idUserAssign,
    this.level,
    this.subNoteCount,
    this.csvSubNoteList,
    this.status
});"""
        self.assertTrue(theDS.genDarkClassConstructor() == expect,'generate constructor dart class')
    
if __name__ == '__main__':
    unittest.main()