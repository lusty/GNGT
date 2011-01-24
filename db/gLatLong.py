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

if __name__ == '__main__':
    loc = geocode(address="241 Moselle Ct., San Jose CA 95119",sensor="false")
    print 'lat: %(lat)f, long: %(lng)f' % loc