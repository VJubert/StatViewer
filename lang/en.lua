local strings ={
StVaTITLE="StatViewer EN"
StVa_TOGGLE="Toogle StatViewer"
}

for stringId, stringValue in pairs(strings) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end