import pymysql
import sys, datetime
import csv, json, xml.etree.ElementTree as ET
from PyQt5.QtWidgets import *

class DBUtil:
    def select(self, sql, params): # delete!!!!!!
        conn = pymysql.connect(host='localhost', user='guest', password='bemyguest', db='chicken', charset='utf8')

        try:
            with conn.cursor(pymysql.cursors.DictCursor) as cursor:
                cursor.execute(sql, params)
                rows = cursor.fetchall()
                return rows
        except Exception as e:
            print(e)
            print(type(e))
        finally:
            conn.close()
    def execute(self, sql, params):
        conn = pymysql.connect(host='localhost', user='guest', password='bemyguest', db='chicken', charset='utf8')

        try:
            with conn.cursor() as cursor:
                cursor.execute(sql, params)
            conn.commit()
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
            sql = f'SELECT DISTINCT name FROM administrator ORDER BY name'
        params = ()

        util = DBUtil()
        rows = util.select(sql=sql, params=params)
        return rows
    def selectContent(self, column, value):
        sql = f'''
        SELECT c.Title, c.Director, 
            a.name AS Administrator, o.name AS Original_Content_Producer, d.name AS Distributor,
            c.Published_Date, c.Expired_Date
        FROM content c
            INNER JOIN administrator a ON a.id = c.administrator_id
            INNER JOIN original_content_producer o ON o.id = c.original_content_producer_id
            INNER JOIN distributor d ON d.id = c.distributor_id  
        WHERE c.{column} = %s
        ORDER BY c.Title
        '''
        if column=='admin':
            sql = f'''
            SELECT c.Title, c.Director, 
                a.name AS Administrator, o.name AS Original_Content_Producer, d.name AS Distributor,
                c.Published_Date, c.Expired_Date
            FROM content c
                INNER JOIN administrator a ON a.id = c.administrator_id
                INNER JOIN original_content_producer o ON o.id = c.original_content_producer_id
                INNER JOIN distributor d ON d.id = c.distributor_id  
            WHERE a.name = %s
            ORDER BY c.Title
            '''
        params = (value, )

        if value=='all':
            sql = f'''
            SELECT c.Title, c.Director, 
                a.name AS Administrator, o.name AS Original_Content_Producer, d.name AS Distributor,
                c.Published_Date, c.Expired_Date
            FROM content c
                INNER JOIN administrator a ON a.id = c.administrator_id
                INNER JOIN original_content_producer o ON o.id = c.original_content_producer_id
                INNER JOIN distributor d ON d.id = c.distributor_id  
            ORDER BY c.Title
            '''
            params = ()

        util = DBUtil()
        rows = util.select(sql=sql, params=params)
        return rows
    def selectContentAndMemberEngagement(self, name, title, director):
        sql = f'''
            SELECT c.title, c.director, a.name AS Administrator,
                me.First_Watch_Date, me.Watch_Time, me.Completed, me.Replay_Count, me.Rating, me.Bookmark,
                m.name AS Member, s.grade AS Subscription_Grade
            FROM member_engagement me
                INNER JOIN content c ON c.administrator_id = me.content_administrator_Id and c.title = me.content_title and c.director = me.content_director
                INNER JOIN Administrator a ON a.id = c.administrator_id
                INNER JOIN member m ON m.id = me.member_id
                INNER JOIN subscription s ON s.id = m.subscription_id
            WHERE 
                a.name = %s and c.title = %s and c.director = %s    
            ORDER BY c.title, c.director, Administrator
        '''
        params = (name, title, director)

        util = DBUtil()
        rows = util.select(sql, params)
        return rows

class MainWindow(QWidget):
    def __init__(self):
        super().__init__()
        self.setupUI()
    def setupUI(self):
        self.setWindowTitle("Chicken Content")
        self.setGeometry(0, 0, 1200, 800)

        query = DBQuery()







def main():
    app = QApplication(sys.argv)
    mainWindow = MainWindow()
    mainWindow.show()
    sys.exit(app.exec_())

if __name__ == '__main__':
    main()
























