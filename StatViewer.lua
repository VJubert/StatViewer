StatViewer = {}

StatViewer.name="StatViewer"


function StatViewer:Initiliaze()

end

function StatViewer.OnAddOnLoaded(event, addonName)
  if addonName==StatViewer.name then
    StatViewer.Initiliaze()
  end
end

EVENT_MANAGER:RegisterForEvent(StatViewer.name, EVENT_ADD_ON_LOADED, StatViewer.OnAddOnLoaded)