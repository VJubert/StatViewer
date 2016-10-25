StatViewer = {}

StatViewer.name="StatViewer"
StatViewer.maxHealth="YoloTest"

function StatViewer:Initiliaze()
  EVENT_MANAGER:RegisterForEvent(StatViewer.name, EVENT_STATS_UPDATED, StatViewer.UpdateStats)
  
end

function StatViewer.OnAddOnLoaded(event, addonName)
  if addonName==StatViewer.name then
    StatViewer.Initiliaze()
  end
end

function StatViewer.UpdateStats(event)
  StatViewer.maxHealth=GetPlayerStat(STAT_HEALTH_MAX,STAT_BONUS_OPTION_APPLY_BONUS)
  SVIndicatorLabel:SetText(StatViewer.maxHealth)
end

EVENT_MANAGER:RegisterForEvent(StatViewer.name, EVENT_ADD_ON_LOADED, StatViewer.OnAddOnLoaded)