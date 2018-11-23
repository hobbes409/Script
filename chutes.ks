print "Chutes.ks, testing chute deployment.".

// main ().


// function main
// {
//     print "Ship name: " + ship:name.
//     listAllParts().
//     listModules().
//     listChutes().
//     deployChutes().
//     print "End test.".
// }


function deployChutes
{
    set droguechutesdeployed to 0.
    set parachutesdeployed to 0.
    print "Arming chutes...".
    wait 0.5.
    set index to 0.
    print "Deploying drogue chutes...".
    until index >=  droguechutes:length()
    {
        set p to droguechutes[index].
        set m to p:getmodule("moduleparachute").
        if p:tag <> "deployed" and m:hasfield("safe to deploy?")
        {
            if m:getfield("safe to deploy?") = "safe"
            {
                m:setfield("min pressure", 0.01).
                m:doevent("deploy chute").
                set p:tag to "deployed".
                set droguechutesdeployed to droguechutesdeployed + 1.
            }
        }
        print p:name + " deployed".
        set index to index + 1.
        wait 0.5.
    }.
    set index to 0.
    print "Deploying main chutes...".
    until index >= parachutes:length()
    {
        set p to parachutes[index].
        set m to p:getmodule("moduleparachute").
        if p:tag <> "deployed" and m:hasfield("safe to deploy?")
        {
            if m:getfield("safe to deploy?") = "safe"
            {
                m:setfield("min pressure", 0.01).
                m:doevent("deploy chute").
                set p:tag to "deployed".
                set parachutesdeployed to parachutesdeployed + 1.
            }
        }

        print p:name + " deployed".
        set index to index + 1.
        wait 0.5.
    }.
    
}


function listModules
{
    for p in ship:parts
    {
        print p:name.
        for m in p:modules
        {
            set thismodule to p:getmodule(m).
            print "  " + thismodule:name.
            set m to m + 1.
        }.
        

    }.
}

function listChutes
{
    list parts in allpartslist.
    set parachutes to list().
    set allchutes to list().
    set allchutesqty to 0.
    set parachutesqty to 0.
    set droguechutes to list().
    set droguechutesqty to 0.
    set index to 0.
    until index >= allpartslist:length()
    {
        set p to allpartslist[index].
        if p:hasmodule("ModuleParachute")
        {
            
            print p:title.
            allchutes:add(p).
            set allchutesqty to allchutesqty + 1.
        }.
        
        if p:name:contains("drogue")
        {
            droguechutes:add(p).
            set droguechutesqty to droguechutesqty + 1.
        }.
        if p:name:contains("parachute")
        {
            parachutes:add(p).
            set parachutesqty to parachutesqty + 1.
        }.

        set index to index + 1.
    }        
    print "Total " + allchutesqty + " chutes.".
    print droguechutesqty + " Drogue chutes".
    print parachutesqty + " Parachutes".
}


// every parachute includes ModuleParachute
// drogues are named radialDrogue
// radial chutes are named parachuteRadial