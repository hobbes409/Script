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