import sqlite3;
from datetime import datetime, date;
import time
import json, urllib

GEOCODE_BASE_URL = 'http://maps.googleapis.com/maps/api/geocode/json'

def geocode(address,sensor, **geo_args):
    geo_args.update({
        'address': address,
        'sensor': sensor  
    })

    url = GEOCODE_BASE_URL + '?' + urllib.urlencode(geo_args)
    result = json.load(urllib.urlopen(url))
    return result['results'][0]['geometry']['location']

inConn = sqlite3.connect('gardenList.sqlite3')
outConn = sqlite3.connect('GNGT.sqlite')
 
inCursor = inConn.cursor()
outCursor = outConn.cursor()
 
outConn.execute("DELETE FROM ZGARDENINFO")
outConn.execute("DELETE FROM ZGARDENDESCRIPTION")
 
maxId = 0
inCursor.execute("select * from gardens")
for row in inCursor:
    if row[0] > maxId:
        maxId = row[0]
 
    # Create ZGARDENINFO entry
	address = "%(street)s, %(city)s, CA" % ({'street':row[4], 'city':row[5]})
	loc = geocode(address, "false")
    print "Inserting %s..." % (row[0])
	
    vals = []
    vals.append(row[0]) # Z_PK
    vals.append(2) # Z_ENT
    vals.append(1) # Z_OPT
    vals.append(row[1]) # ZGARDENNUMBER
    vals.append(row[0]) # ZGARDENDESCRIPTION
    vals.append(loc['lat']) # ZLATITUDE
    vals.append(loc['lng']) # ZLONGITUDE
    vals.append(row[5]) # ZCITY
    vals.append(row[2]) # ZGARDENNAME
    vals.append(row[6]) # ZPLANTSALE
    vals.append(row[4]) # ZSTREET
    outConn.execute("insert into ZGARDENINFO values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", vals)
 
    # Create ZGARDENDESCRIPTION entry
    vals = []
    vals.append(row[0]) # Z_PK
    vals.append(1) # Z_ENT
    vals.append(1) # Z_OPT
    vals.append(row[14]) # ZSQFT
    vals.append(row[12]) # ZYEARINSTALLED
    vals.append(row[0]) # ZINFO
    vals.append(row[8]) # ZOTHER
    vals.append(row[11]) # ZGARDENINSTALLER
    vals.append(row[9]) # ZWILDLIFE
    vals.append(row[7]) # ZSHOWCASE
    vals.append(row[15]) # ZDIRECTIONS
    vals.append(row[10]) # ZDESIGNER
    outConn.execute("insert into ZGARDENDESCRIPTION values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", vals)
 
outConn.execute("update Z_PRIMARYKEY set Z_MAX=?", [maxId])
 
outConn.commit()
