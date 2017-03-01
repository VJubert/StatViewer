local strings = {
StVaTITLE="StatViewer EN",
StVaTOGGLE="Toogle StatViewer",
StVaOPTIONSHEADER="Options",
StVaOPTIONSRESIST="Show all resists",
StVaOPTIONSRESISTTOOLTIP="All resistances will be shown on the UI with a new column",
}

for stringId, stringValue in pairs(strings) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end