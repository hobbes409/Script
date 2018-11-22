print "executing k1 test script...".

main().


function main 
    {
        SAS OFF.
        LIGHTS ON. 
        reportResources().
        listScienceParts().
        countdownthree().
        simpleLaunch().
        wait until alt:radar > 1000 and ship:verticalspeed < 10.     
        doAllScience().
        safeChuteDeploy().

    }

function countdownthree
    {
        print "3...".
        wait 1.
        print "2..".
        wait 1.
        print "1...".
        wait 1.
    }

function simpleLaunch
    {
        stage.
        wait 0.1.
    }

function safeChuteDeploy
    {
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




// Launch
// Ascent
// Circularize if needed
// Deorbit if needed
// Braking burn if needed
// Descent
// Landing


// function doSafeStage
//    {
//        wait until stage:ready.
//        stage.
//    }



// loops:
//      craft control
//      report in-flight vehicle status
//      gather renewable science and collect
//      save telemetry

// gather non-renewable science set one
// gather non-renewable science set two
// collect all science

// boostback burn


// deorbit
// braking burn


// landing:
// deploy chutes
//  or
// powered landing


// shutdown
function doShutdown
    {

    }.


// panic mode

