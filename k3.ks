print "Executing k3 test script...".
print "Launch, deploy chutes and recover science".

print "loading chutes code".
runoncepath("0:/chutes.ks").
wait 0.5.
print "loading telemetry code".
runoncepath("0:/telemetry.ks").
wait 0.5.
print "loading science code".
runoncepath("0:/science.ks").
wait 0.5.


main().


function main 
    {
        SAS OFF.
        LIGHTS ON. 

        // count number of stages, only stage until parachutes.
       
        reportResources().
        listScienceParts().
        listChutes().
        // countdownthree().
        // simpleLaunch().
        // enter flight loop               
        // displaytelemetry().
        print "recording telemetry...".
        recordtelemetry(). // try to do this once per second minimum
        print "deploying chutes...".
        deploychutes().
        print ship:status.
        if ship:status = "landed" or ship:status = "splashed"
        {
            print ship:status.
            print "Doing post launch science...".
            doAllScience().
        }.
        // if flight end conditions met
        print "Doing pre launch science...".
        doAllScience().
        print "Program end.".
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
        wait 0.01.
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
                                set currentAngle to (currentAngle * 0.9).
                                print currentAngle.
                            }
                        lock throttle to newThrust.
                    }
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


