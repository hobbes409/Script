print "Executing k2 test script...".
print "Gathering science near KSC."

main().


function main 
    {
        SAS OFF.
        LIGHTS ON. 

        // count number of stages, only stage until parachutes.
        print ship:status.
        set radaralt to ALTITUDE - SHIP:GEOPOSITION:TERRAINHEIGHT.
        reportResources().
        listScienceParts().
        countdownthree().
        simpleLaunch().
        flightloop().
        guidance (270, 50, 45, 1).
        wait until alt:radar < 1500.
        print alt:radar.
        print radaralt.
        // chutes NOT DEPLOYING correctly
        safeChuteDeploy().
        stage.
        print ship:status.
        wait until ship:status = landed or ship:status = splashed.
        print ship:status.
        doAllScience().
    }

function flightloop
{
//      status    
//      guidance
//      staging
//      chutes
//      exit
}

function countdownthree
    {
        print "3...".
        wait 0.5.
        print "2...".
        wait 0.5.
        print "1...".
        wait 0.5.
    }

function simpleLaunch
    {
        lock throttle to 1. 
        stage.
        wait 0.1.
    }

function guidance 
    {
        parameter targetDirection.
        parameter minAlt.
        parameter ascentAngle.
        parameter newThrust.

        set currentAngle to 90.
        set prevThrust to maxThrust.

        until false 
            {
                if maxThrust < (prevThrust - 10)
                    {
                        Set currentThrottle to throttle.
                        lock throttle to 0.
                        // wait 0.1.  stage.  wait 0.1.
                        // don't stage until chutes are figured out
                        lock throttle to currentThrottle.
                        set prevThrust to maxThrust.
                    }
                if ship:altitude > minAlt
                    {
                        lock steering to heading(targetDirection, currentAngle).
                        if currentAngle > ascentAngle
                            {
                                set currentAngle to (currentAngle - 5).
                                print currentAngle.
                            }
                        lock throttle to newThrust.
                    }
                print "Alt:Radar: " + alt:radar + ", " + "    
                wait 0.5.     
            }    
    }

function safeChuteDeploy
    {
        print "Deploying chutes...".
        chutessafe on.
    }

// report pre-launch vehicle status

function reportResources
    {
        print "Ship resources: ".
        list resources in reslist.
        for res in reslist
        {   
            print "Resource " + RES:NAME.
            print "   value " + round(res:amount).
            print "      at " 
                + round(100*res:amount/res:capacity)
                + " percent.".
            print " ".
        }.
    }

function listAllParts
    {
        list parts in MyPartsList.
        for part in MyPartsList
        {
            print part:title.
        }.
    }


// ----------------------------------------------------------science-----+

// enumerate and list science parts on ship

function listScienceParts
    {
        list parts in allpartslist.
        set scienceparts to list().
        set sciencepartqty to 0.
        set index to 0.
        until index >= allpartslist:length()
        {
            set p to allpartslist[index].
            if p:hasmodule("ModuleScienceExperiment")
            {
                print p:title.
                scienceparts:add(p).
                set sciencepartqty to sciencepartqty + 1.
            }
            set index to index + 1.
        }        
        print "Total " + sciencepartqty + " science parts.".

    }

function doAllScience
    {
        list parts in allpartslist.
        set scienceparts to list().
        set index to 0.
        until index >= allpartslist:length()
        {
            set p to allpartslist[index].
            if p:hasmodule("ModuleScienceExperiment")
            {
                print p:title.
                set m to p:getmodule("ModuleScienceExperiment").
                m:deploy.
                wait until m:hasdata.
           }
            set index to index + 1.
        }        
    }


function collectAllScience
    {
        // if there is a science collector
        // trigger it to collect all science
        // else take no action
    }


// if rerunnable AND if data has value the transmit, else reset
// ModuleEnviroSensor
// ModuleScienceContainer
// ModuleScienceExperiment
//      evaReport
//      mysteryGoo
//      surfaceSample
//      mobileMaterialsLab
//      temperatureScan
//      barometerScan
//      seismicScan
//      gravityScan
//      atmosphereAnalysis
//      asteroidSample    

// ------------------------------------------------------end science------


// launch
// function doLaunch().


// ----------------------------------------------------------landing-----+

function doChuteSafe 
    {
    when (not chutesafe) then 
        {    
        chutesafe on.
        return (not chutes).
        }    
     wait until false.
    }

// ------------------------------------------------------end landing------

// ------------------------------------------------------shutdown--------+

function doShutdown
    {

    }

// ------------------------------------------------------shutdown---------

// ------------------------------------------------------staging---------+

// function doSafeStage
//    {
//        wait until stage:ready.
//        stage.
//    }

// ------------------------------------------------------staging----------


