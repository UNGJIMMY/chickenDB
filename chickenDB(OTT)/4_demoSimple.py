import pymysql

def db_connect():
    conn = pymysql.connect(
        host='',
        user='',
        password='',
        database='chicken',
        charset='utf8mb4'
    )
    return conn

def show_menu():
    print('''
    Welcome Chicken Member List
    0. Quit
    1. Viewing
    2. Add
    3. Update
    4. Delete
    ''')


def view_member(conn):
    while 1:
        try:
            select_choice = int(input("Press 0 for All members or 1 for the Specific member with id: "))
        except ValueError:
            print('hey!')
            continue
        if select_choice == 1:
            print('''
            Notice Data Bins
            ID(Integer): 1-30
            ''')
            while 1:
                try:
                    member_id = int(input('ID: '))
                    break
                except ValueError:
                    print("Member_id should be of Integer type.")
            
            with conn.cursor() as cursor:
                select_sql = "SELECT * FROM member WHERE id=%s;"
                cursor.execute(select_sql, (member_id,))
        
                row = cursor.fetchone()
                if row:
                    print(row)
                else:
                    print(f"member {member_id} does not exist.")
            return 
        
        elif select_choice == 0:
            with conn.cursor() as cursor:
                cursor.execute('SELECT * FROM member')
                rows = cursor.fetchall()
                
                print('\n[The List of members]')
                for row in rows:
                    print(row)
            return
            
        else:
            print('Could you please check your input?\nchoice bins: 0,1')

def add_member(conn):
    print('''
    Notice Data Bins
    ID(Integer): !(1-30)
    Subscription_ID(Integer): 1-4
    * Date Type Format: yyyy-mm-dd
    ''')
    while True:
        try:
            member_id = int(input('ID: '))
            subscription_id = int(input('Subscription_ID: '))
            break
        except ValueError:
            print("Member_ID, Subscription_ID should be of Integer type.")

    while True:
        name = input('Name: ').strip()
        email = input('Email: ').strip()
        if not (name and email)  :
            print("Please provide the member's name and email")
        else: break
    date_of_birth = input('Date_of_Birth: ')
    subscription_start_date = input('Subscription_Start_Date: ')
    subscription_end_date = input('Subscription_End_Date: ')
    
    insert_sql = """
    INSERT INTO member (id, name, email, date_of_birth, subscription_start_date, subscription_end_date, subscription_id)
    VALUES (%s, %s, %s, %s, %s, %s, %s);
            """
    
    try:
        with conn.cursor() as cursor:
            cursor.execute(insert_sql, (member_id, name, email, date_of_birth, subscription_start_date, subscription_end_date, subscription_id))
        conn.commit()
        print('New member is successfully appended.')
    except pymysql.MySQLError as e:
        print(f'Hey!! your fault -> {e}')

def update_member_birthday(conn):
    print('''
    Notice Data Bins
    ID: 1-30
    * Date Type Format: yyyy-mm-dd
    ''')
    while True:
        try:
            member_id = int(input('ID: '))
            break
        except ValueError:
            print("Member_ID should be of Integer type.")

    while True:
        date_of_birth = input('Date_of_Birth: ')
    
        if not date_of_birth  :
            print("Please provide birthday")
        else: break

    update_sql = """
    UPDATE member SET date_of_birth=%s
    WHERE id=%s;
    """
    
    try:
        with conn.cursor() as cursor: 
            exist_rows = cursor.execute(update_sql, (date_of_birth, member_id))
        if exist_rows:
            conn.commit()
        else:
            print('No Rows Update, please check your input')
            return
        print(f'Information of {member_id} is successfully updated.')
    except pymysql.MySQLError as e:
        print(f'Hey!! your fault -> {e}')

def delete_member(conn):
    print('''
    Notice Data Bins
    ID: 1-30
    ''')
    while True:
        try:
            member_id = int(input('ID: '))
            break
        except ValueError:
            print("Member_ID should be of Integer type.")

    delete_sql = "DELETE FROM member WHERE id=%s;"

    try:
        with conn.cursor() as cursor:
            delete_row = cursor.execute(delete_sql, (member_id,))
        if delete_row:
            conn.commit()
        else:
            print('No Row was deleted, please check your input')
            return
        print(f'member {member_id} is successfully removed.')
    except pymysql.MySQLError as e:
        print(f'Hey!! your fault -> {e}')

def main():
    conn = db_connect()
    
    while True:
        show_menu()
        
        try:
            choice = int(input('Choose the Menu: '))
        except ValueError:
            print('please enter a number from 0-4')
            continue
                  
        if choice == 1:
            print('View Member')
            view_member(conn)
        elif choice == 2:
            print('Add Member')
            add_member(conn)
        elif choice == 3:
            print("Update Member's birthday")
            update_member_birthday(conn)
        elif choice == 4:
            print('Delete Member')
            delete_member(conn)
        elif choice == 0:
            print('Terminating...')
            conn.close()
            break

if __name__ == '__main__':
    main()