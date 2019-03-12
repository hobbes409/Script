// Kerbal Space Programming
// For logging position data to plot trajectories
// Testing various craft configurations for a SpaceX-style return to the launchpad


// set telemetryfilename to (timespan:calendar + "," + timespan:clock) // date, time, craft_name, flight_number
set telemetryfilename to ("kos002test1.csv").

SET startTime TO TIME:SECONDS.
SET startLon TO SHIP:LONGITUDE.
set startLat to ship:latitude.  
SET startAltitude TO SHIP:ALTITUDE.  // altitude from sea level, adequate for telemetry but not for guidance
SET currentLon TO 0.
SET elapsedTime TO 0. 
SET currentAltitude TO 0.
set radarAltitude to 0.
SET altimeter_max to -1.  //initialize altimeter to below surface


function recordtelemetry
{
SWITCH TO 0.  //set environment to user folder for recording data
IF (altimeter_max < SHIP:ALTITUDE) SET altimeter_max TO SHIP:ALTITUDE.
SET elapsedTime TO (TIME:SECONDS - startTime).
SET currentLon TO (SHIP:LONGITUDE - startLon).
set currentLat to (ship:LATITUDE - startLat).
SET currentAltitude TO (SHIP:ALTITUDE - startAltitude).
set radarAltitude to (ship:ALTITUDE - SHIP:GEOPOSITION:TERRAINHEIGHT).
LOG elapsedTime + "," + currentLon + "," + currentLat + "," + currentAltitude + "," + radarAltitude + "," + SHIP:AIRSPEED + "," + altimeter_max  + "," + SHIP:LIQUIDFUEL TO telemetryfilename.
SWITCH to 1.  //set environment back to local craft
}

// function displaytelemetry
// {
//     // print telemetry in terminal
// }