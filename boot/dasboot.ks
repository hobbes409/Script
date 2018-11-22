core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
print "dasboot loaded, kOS version " + core:version + ", status: " + core:mode.
runpath("0:/hello.ks").
wait 1.
runpath("0:/k1.ks").