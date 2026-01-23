import pymysql
import sys, datetime
import csv, json, xml.etree.ElementTree as ET
from PyQt5.QtWidgets import *

class DBUtil:
    def select(self, sql, params):
        conn = pymysql.connect(host='localhost', user='guest', password='', db='chicken', charset='utf8')

        try:
            with conn.cursor(pymysql.cursors.DictCursor) as cursor:
                cursor.execute(sql, params)
                rows = cursor.fetchall()
                return rows
        except pymysql.MySQLError as e:
            print(e)
            print(type(e))
        except Exception as e:
            print(e)
            print(type(e))
        finally:
            conn.close()

class DBQuery:
    def selectUniqueListForContent(self, column):
        sql = f'SELECT DISTINCT {column} FROM content ORDER BY {column}'
        if column=='admin':
            sql = f'''
            SELECT a.name AS admin
            FROM administrator a
            WHERE a.id in (SELECT DISTINCT c.administrator_id FROM content c)
            ORDER BY a.name
            '''
        params = ()

        util = DBUtil()
        rows = util.select(sql=sql, params=params)
        return rows
    def selectContentJoin(self, column, value):
        sql = f'''
        SELECT c.Title, c.Director, 
            a.name AS Admin,
            (SELECT name FROM original_content_producer o where o.id = c.original_content_producer_id) AS Original_Content_Producer,
            (SELECT name FROM distributor d where d.id = c.distributor_id) AS Distributor,
            c.Published_Date, c.Expired_Date
        FROM content c
            INNER JOIN administrator a ON a.id = c.administrator_id  
        WHERE c.{column} = %s
        ORDER BY c.Title
        '''
        if column=='admin':
            sql = f'''
           SELECT c.Title, c.Director, 
                a.name AS Admin, 
                (SELECT name FROM original_content_producer o where o.id = c.original_content_producer_id) AS Original_Content_Producer,
                (SELECT name FROM distributor d where d.id = c.distributor_id) AS Distributor,
                c.Published_Date, c.Expired_Date
            FROM content c
                INNER JOIN administrator a ON a.id = c.administrator_id  
            WHERE a.name = %s
            ORDER BY c.Title
            '''
        params = (value)

        if value=='ALL':
            sql = f'''
            SELECT c.Title, c.Director, 
                a.name AS Admin, 
                (SELECT name FROM original_content_producer o where o.id = c.original_content_producer_id) AS Original_Content_Producer,
                (SELECT name FROM distributor d where d.id = c.distributor_id) AS Distributor,
                c.Published_Date, c.Expired_Date
            FROM content c
                INNER JOIN administrator a ON a.id = c.administrator_id
            ORDER BY c.Title
            '''
            params = ()

        util = DBUtil()
        rows = util.select(sql=sql, params=params)
        return rows
    def selectMemberEngagementJoin(self, title, director, admin):
        sql = f'''
            SELECT c.title, c.director, a.name AS Admin,
                me.First_Watch_Date, me.Watch_Time, me.Completed, me.Replay_Count, me.Rating, me.Bookmark,
                m.name AS Member, s.grade AS Subscription_Grade
            FROM member_engagement me
                INNER JOIN content c ON c.administrator_id = me.content_administrator_id and c.title = me.content_title and c.director = me.content_director
                INNER JOIN Administrator a ON a.id = c.administrator_id
                INNER JOIN member m ON m.id = me.member_id
                INNER JOIN subscription s ON s.id = m.subscription_id
            WHERE 
                c.title = %s and c.director = %s and a.name = %s
            ORDER BY c.title, c.director, Admin
        '''
        params = (title, director, admin)

        util = DBUtil()
        rows = util.select(sql, params)
        return rows

class MainWindow(QWidget):
    def __init__(self):
        super().__init__()
        self.setupUI()
    def setupUI(self):
        self.setWindowTitle('Chicken Content')
        self.setGeometry(0, 0, 1200, 800)

        # data import
        query = DBQuery()
        titleDB = query.selectUniqueListForContent('title')
        directorDB = query.selectUniqueListForContent('director')
        adminDB = query.selectUniqueListForContent('admin')

        # widget configuration
        self.lbContentSearch = QLabel("Content Search")

        ALL = ['ALL']
        title = ALL + [row['title'] for row in titleDB]
        director = ALL + [row['director'] for row in directorDB]
        admin = ALL + [row['admin'] for row in adminDB]

        self.lbTitle = QLabel('Title: ' )
        self.cbTitle = QComboBox(self)
        self.cbTitle.addItems(title)
        self.cbTitle.activated.connect(self.cbTitle_Activated)

        self.lbDirector = QLabel('Director:' )
        self.cbDirector = QComboBox(self)
        self.cbDirector.addItems(director)
        self.cbDirector.activated.connect(self.cbDirector_Activated)

        self.lbAdmin = QLabel('Admin: ')
        self.cbAdmin = QComboBox(self)
        self.cbAdmin.addItems(admin)
        self.cbAdmin.activated.connect(self.cbAdmin_Activated)

        self.pbSearch = QPushButton('Search')
        self.contentSearchCount = 1 # to initialize title's ALL
        self.positionValue = 'ALL'
        self.rows = 0
        self.pbSearch.clicked.connect(self.pbSearch_Clicked)

        self.lbNumberOfContent = QLabel('Number of Content: ')
        self.lbResultOfNumberOfContent = QLabel()
        self.pbClear = QPushButton('clear')
        self.pbClear.clicked.connect(self.pbClear_Clicked)

        self.twContent = QTableWidget(self)
        self.twContent.cellClicked.connect(self.twContent_CellClicked)

        self.lbFileOut = QLabel('File Out')

        self.rbCSV = QRadioButton('CSV', self)
        self.rbCSV.setChecked(True)
        self.rbJSON = QRadioButton('JSON', self)
        self.rbXML = QRadioButton('XML', self)

        self.pbStore = QPushButton('Store')
        self.pbStore.clicked.connect(self.pbStore_Clicked)

        # layout alignment
        ## trash widget
        self.lbT1 = QLabel()
        self.lbT2 = QLabel()
        self.lbT3 = QLabel()
        self.lbT4 = QLabel()
        self.lbT5 = QLabel()
        self.lbT6 = QLabel()

        ## layout alignment
        vblFull = QVBoxLayout()

        glContentSearch = QGridLayout()
        glContentSearch.addWidget(self.lbContentSearch, 0, 0)
        glContentSearch.addWidget(self.lbTitle, 1, 1)
        glContentSearch.addWidget(self.cbTitle, 1, 2)
        glContentSearch.addWidget(self.lbT1, 1, 3)
        glContentSearch.addWidget(self.lbDirector, 1, 4)
        glContentSearch.addWidget(self.cbDirector, 1, 5)
        glContentSearch.addWidget(self.lbT2, 1, 6)
        glContentSearch.addWidget(self.lbAdmin, 1, 7)
        glContentSearch.addWidget(self.cbAdmin, 1, 8)
        glContentSearch.addWidget(self.lbT3, 1, 9)
        glContentSearch.addWidget(self.pbSearch, 1, 10)
        glContentSearch.addWidget(self.lbNumberOfContent, 2, 1)
        glContentSearch.addWidget(self.lbResultOfNumberOfContent, 2, 2)
        glContentSearch.addWidget(self.lbT4, 2, 3)
        glContentSearch.addWidget(self.pbClear, 2, 10)

        vblContent = QVBoxLayout()
        vblContent.addWidget(self.twContent)

        glFileOut = QGridLayout()
        glFileOut.addWidget(self.lbFileOut, 0, 0)
        glFileOut.addWidget(self.rbCSV, 1, 1)
        glFileOut.addWidget(self.rbJSON, 1, 2)
        glFileOut.addWidget(self.rbXML, 1, 3)
        glFileOut.addWidget(self.lbT5, 1, 4)
        glFileOut.addWidget(self.lbT5, 1, 5)
        glFileOut.addWidget(self.pbStore, 1, 6)

        vblFull.addLayout(glContentSearch)
        vblFull.addLayout(vblContent)
        vblFull.addLayout(glFileOut)
        self.setLayout(vblFull)
    def cbTitle_Activated(self):
        self.contentSearchCount = 1
        self.positionValue = self.cbTitle.currentText()
    def cbDirector_Activated(self):
        self.contentSearchCount = 2
        self.positionValue = self.cbDirector.currentText()
    def cbAdmin_Activated(self):
        self.contentSearchCount = 3
        self.positionValue = self.cbAdmin.currentText()
    def pbSearch_Clicked(self):
        query = DBQuery()

        match self.contentSearchCount:
            case 1:
                column = 'title'
            case 2:
                column = 'director'
            case 3:
                column = 'admin'

        self.rows = query.selectContentJoin(column, self.positionValue)

        rows = self.rows

        if not rows:
            self.twContent.clear()
            self.twContent.setRowCount(0)
            self.twContent.setColumnCount(0)
            self.lbResultOfNumberOfContent.setText(str(0))
            return

        self.twContent.clearContents()
        self.twContent.setRowCount(len(rows))
        self.twContent.setColumnCount(len(rows[0]))

        columnNames = list(rows[0].keys())
        self.twContent.setHorizontalHeaderLabels(columnNames)
        self.twContent.setEditTriggers(QAbstractItemView.NoEditTriggers)

        for rowIDX, row in enumerate(rows):
            for columnIDX, v in enumerate(row.values()):
                if v == None:
                    continue
                elif isinstance(v, datetime.date):
                    item = QTableWidgetItem(v.strftime('%Y-%m-%d'))
                else:
                    item = QTableWidgetItem(str(v))
                self.twContent.setItem(rowIDX, columnIDX, item)

        self.twContent.resizeColumnsToContents()
        self.twContent.resizeRowsToContents()

        self.lbResultOfNumberOfContent.setText(str(len(rows)))
    def pbClear_Clicked(self):
        self.ContentSearchCount = 1
        self.positionValue = 'ALL'
        self.rows = 0

        self.cbTitle.setCurrentIndex(0)
        self.cbDirector.setCurrentIndex(0)
        self.cbAdmin.setCurrentIndex(0)

        self.twContent.clear()
        self.twContent.setRowCount(0)
        self.twContent.setColumnCount(0)
        self.lbResultOfNumberOfContent.setText(str(0))
    def CSVWriter(self):
        with open(f'{self.fileName}.csv', 'w', encoding='utf-8', newline='') as f:
            rows = self.rows
            wr = csv.writer(f)

            columnNames = list(rows[0].keys())
            wr.writerow(columnNames)

            for row in rows:
                wr.writerow(list(row.values()))
    def JSONWriter(self):
        rows = self.rows

        for row in rows:
            for k,v in row.items():
                if isinstance(v, datetime.date):
                    row[k] = v.strftime('%Y-%m-%d')

        newDict = dict(ContentJoin = rows)

        with open(f'{self.fileName}.json', 'w', encoding='utf-8') as f:
            json.dump(newDict, f, indent=4, ensure_ascii=False)
    def XMLWriter(self):
        rows = self.rows

        for row in rows:
            for k,v in row.items():
                if isinstance(v, datetime.date):
                    row[k] = v.strftime('%Y-%m-%d')

        rootElement = ET.Element('Table')
        rootElement.attrib['name'] = 'ContentJoin'

        for row in rows:
            rowElement = ET.Element('Row')
            rootElement.append(rowElement)

            for columnName in row.keys():
                if row[columnName] == None:
                    rowElement.attrib[columnName] = ''
                elif type(row[columnName]) == int:
                    rowElement.attrib[columnName] = str(row[columnName])
                else:
                    rowElement.attrib[columnName] = row[columnName]

        ET.ElementTree(rootElement).write(f'{self.fileName}.xml', encoding='utf-8', xml_declaration=True)
    def pbStore_Clicked(self):
        if not self.rows:
            print('no row')
            return

        self.fileName = f'{self.cbTitle.currentText()}, {self.cbDirector.currentText()}, {self.cbAdmin.currentText()}'

        if self.rbCSV.isChecked():
            self.CSVWriter()
        elif self.rbJSON.isChecked():
            self.JSONWriter()
        elif self.rbXML.isChecked():
            self.XMLWriter()
    def twContent_CellClicked(self, row, column):
        titleValue = self.twContent.item(row, 0).text()
        directorValue = self.twContent.item(row, 1).text()
        adminValue = self.twContent.item(row, 2).text()

        self.subWindow = SubWindow(titleValue, directorValue, adminValue)
        self.subWindow.show()

class SubWindow(QWidget):
    def __init__(self, titleValue, directorValue, adminValue):
        super().__init__()

        self.titleValue = titleValue
        self.directorValue = directorValue
        self.adminValue = adminValue
        self.setupUI()

    def setupUI(self):
        self.setWindowTitle('Member Engagement')
        self.setGeometry(0,0, 1000,600)

        # data import
        query = DBQuery()
        rows = query.selectMemberEngagementJoin(title=self.titleValue, director=self.directorValue, admin=self.adminValue)

        if not rows:
            return

        # widget configuration
        self.twMemberEngagement = QTableWidget()
        self.twMemberEngagement.clearContents()
        self.twMemberEngagement.setRowCount(len(rows))
        self.twMemberEngagement.setColumnCount(len(rows[0]))

        columnNames = list(rows[0].keys())
        self.twMemberEngagement.setHorizontalHeaderLabels(columnNames)
        self.twMemberEngagement.setEditTriggers(QAbstractItemView.NoEditTriggers)

        for rowIDX, row in enumerate(rows):
            for columnIDX, v in enumerate(row.values()):
                if v == None:
                    continue
                elif isinstance(v, datetime.date):
                    item = QTableWidgetItem(v.strftime('%Y-%m-%d'))
                else:
                    item = QTableWidgetItem(str(v))
                self.twMemberEngagement.setItem(rowIDX, columnIDX, item)

        self.twMemberEngagement.resizeColumnsToContents()
        self.twMemberEngagement.resizeRowsToContents()

        self.lbMemberEngagement = QLabel('Member Engagement')

        # layout alignment
        vblFull = QVBoxLayout()

        vblFull.addWidget(self.lbMemberEngagement)
        vblFull.addWidget(self.twMemberEngagement)

        self.setLayout(vblFull)

def main():
    app = QApplication(sys.argv)
    mainWindow = MainWindow()
    mainWindow.show()
    sys.exit(app.exec_())

if __name__ == '__main__':
    main()