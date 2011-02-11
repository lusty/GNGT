import sqlite3
from datetime import datetime
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

gardens = []
maxId = 0
inCursor.execute("select * from gardens")
for row in inCursor:
    if row[0] > maxId:
        maxId = row[0]

    address = "%(street)s, %(city)s, CA" % ({'street':row[4], 'city':row[5]})
    loc = geocode(address, "false")

    location = dict({'latitude':loc['lat'], 'longitude':loc['lng'], 'streetAddress':row[4]});
    info =  dict({'gardenNumber':row[1], 'plantSale':row[6], 'designer':row[10], 'installer':row[11], 'sqft':row[14], 'yearInstalled':row[12], 'directions':row[15], 'showcase':row[7], 'wildlife':row[9], 'other':row[8]})
    garden = dict({'name':row[2], 'city':row[5], 'location':location, 'infoArray':info})
    gardens.append(garden)

tour = dict({'tourName':'Going Native Garden Tour', 'url':'www.goingnativegardentour.com', 'tourDate':'2011-04-17', 'gardens':gardens})
header = dict({'updated':datetime.now().isoformat(), 'format':2})

f = open('tour-app-db-01.json', 'w')
f.write("{\"file\":%(header)s,\n\"tour\":%(tour)s\n}\n" % ({'header':json.dumps(header), 'tour':json.dumps(tour)}))
f.close()



