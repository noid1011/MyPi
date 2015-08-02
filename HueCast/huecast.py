import datetime
import forecastio
from phue import Bridge
b = Bridge('192.168.0.55')

def tempcolor(mintemp=0,maxtemp=32,mincolor=44000,maxcolor=3200,ctemp=10,c=0,toffset=-3500):
    tempdiff=(mincolor-maxcolor) / (maxtemp-mintemp)
    #Current temp (ctemp) is the var you submit when calling the function.  The Hue colour was a bit inaccurate (too green for the temperature), so use toffset to offset it.
    #Bigger = colder. Smaller = warmer (a negative number)
    ccolor=(ctemp-mintemp) * tempdiff
    ctouse=(mincolor-ccolor)+toffset
    #print ctouse
    return ctouse;
    
def raincolor(minrain=0.1,maxrain=8,minx=0.1711,maxx=0.3177,miny=0.047,maxy=0.1241,crain=0):
    xdiff=(maxx-minx) / (maxrain-minrain)
    #print xdiff
    ydiff=(maxy-miny) / (maxrain-minrain)
    #Current rain (crain) is the var you submit when calling the function.  The Hue colour was a bit inaccurate (too green for the temperature), so use toffset to offset it.
    #Bigger = colder. Smaller = warmer (a negative number)
    xcolor=(maxrain-crain) * xdiff
    ycolor=(maxrain-crain) * ydiff
    xctouse=(maxx-xcolor)
    yctouse=(maxy-ycolor)
    #print ctouse
    return xctouse,yctouse;


def main():
    #dohour is a flag. If it's raining, we don't want to bother checking the temperature.
    dohour=1
    api_key = "--------------------"

    lat = 50.9000
    lng = -1.4000
	
    forecast = forecastio.load_forecast(api_key, lat, lng)
    
    min_rain_intensity=0.017
    min_rain_probability=0.35
    
    
    print "===========minute========="
    #byMinute = forecast.get_minutely()
    byMinute = forecast.minutely()
    print byMinute.summary
    print "Printing the minutely data"
    
    #Check for rain in the next hour by using Minutely data. 0=no rain
    rain=0
    rainprob=0
    #How many data points (minutes) do we want to look at?
    num_minutes=40
    for minutelyData in byMinute.data[0:num_minutes]:
        #minutelyData.precipIntensity contains how much rainfall is expected.
        
        rain+=minutelyData.precipIntensity
        if minutelyData.precipProbability:
            rainprob+=minutelyData.precipProbability
            print minutelyData.time, ": minutelyData.precipIntensity",minutelyData.precipIntensity, " (Probability: ",minutelyData.precipProbability
       
    rain = rain/num_minutes
    rainprob = rainprob/num_minutes
    print "Rain: ",rain, ". Probability: ", rainprob
    if rain>min_rain_intensity and rainprob > min_rain_probability:
        dohour=0

        #Get the average forecasted rainfall, then do something with it. 0.4 is considered heavy rainfall. 0.017
        #is light precipitation. 0.1 moderate
        #For this script, rain over 0.017 should take precedence over the temperature, changing the bulb to a shade
        #of blue until the forecast falls below 0.017 again. We'll also adjust the saturation depending on other factors
        #such as intensity or cloud cover 
        print "There's rain: ", rain
        thesat=raincolor(crain=rain)
        print "The sat (rain) colour ", thesat
        hue_go = {'on':True, 'xy':[thesat[0], thesat[1]], 'bri':80}
      
    print "===========hour========="
    byHour = forecast.hourly()
    hl=len(byHour.data)
    print "byHour length is ",hl
    print byHour.summary
    limitforecast=3
    limitvar=0
    theforecast=0
    done=False
    # limitforecast is the number of hours in the future that we want to forecast. We'll take an average reading
    # based on that limit. forcast.io issues 49 data points in the future - we only want the immediate future (2 or 3 hrs)
    # Limitvar is just a counter. theforecast is the temperature counter
          
    if dohour>0:
        for hourlyData in byHour.data[0:3]:
            #print hourlyData.time, " and windspeed ", hourlyData.windspeed, "icon: ",hourlyData.icon, " (temp ",hourlyData.temperature, ")"
            print hourlyData.time, "icon: ",hourlyData.icon, " (temp ",hourlyData.temperature, ")"
            theforecast+=(hourlyData.temperature)
            limitvar+=1
        theforecast=theforecast/limitforecast
        print "the forecast ",theforecast    
        thecol = round(tempcolor(ctemp=theforecast))
        print "Thecol= ",int(thecol)
        hue_go = {'on':True, 'hue':int(thecol), 'bri':80, 'sat':255}
    print "Setting the light with: ", hue_go
        
    b.set_light(2,hue_go)   
       
    print "light set! dohour=",dohour                
    
    

if __name__ == "__main__":
    main()
