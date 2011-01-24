import sqlite3;
from datetime import datetime, date;
 
def mysplit (string):
    quote = False
    retval = []
    current = ""
    for char in string:
        if char == '"':
            quote = not quote
        elif char == ',' and not quote:
            retval.append(current)
            current = ""
        else:
            current += char
    retval.append(current)
    return retval


conn = sqlite3.connect('gardenList.sqlite3')
c = conn.cursor()
c.execute('drop table if exists gardens')
c.execute('create table gardens(id integer primary key autoincrement, garden_number integer, garden_name text, nospacename text, street text, city text, plant_sale text, showcase text, other text, wildlife text, designer text, installer text, year_installed integer, garden_size text, sqft integer, directions text, email text)')
# Read lines from file, skipping first line
data = open("dks_export.csv", "r").readlines()[1:]
for entry in data:
    # Parse values
    vals = mysplit(entry.strip())
    # Insert the row!
    print "Inserting %s..." % (vals[0])
    sql = "insert into gardens values(NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    c.execute(sql, vals)
 
# Done!
conn.commit()


