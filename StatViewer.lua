local StatViewer = {}
local TESOStat={
STAT_ARMOR_RATING=STAT_ARMOR_RATING,
STAT_ATTACK_POWER=STAT_ATTACK_POWER,
-- STAT_BLOCK=STAT_BLOCK,
STAT_CRITICAL_RESISTANCE=STAT_CRITICAL_RESISTANCE,
STAT_CRITICAL_STRIKE=STAT_CRITICAL_STRIKE,
--STAT_DODGE=STAT_DODGE,
STAT_HEALTH_MAX=STAT_HEALTH_MAX,
STAT_HEALTH_REGEN_COMBAT=STAT_HEALTH_REGEN_COMBAT,
STAT_HEALTH_REGEN_IDLE=STAT_HEALTH_REGEN_IDLE,
STAT_MAGICKA_MAX=STAT_MAGICKA_MAX,
STAT_MAGICKA_REGEN_COMBAT=STAT_MAGICKA_REGEN_COMBAT,
STAT_MAGICKA_REGEN_IDLE=STAT_MAGICKA_REGEN_IDLE,
-- STAT_MISS=STAT_MISS,
-- STAT_MITIGATION=STAT_MITIGATION,
STAT_PHYSICAL_PENETRATION=STAT_PHYSICAL_PENETRATION,
STAT_PHYSICAL_RESIST=STAT_PHYSICAL_RESIST,
STAT_POWER=STAT_POWER,
STAT_SPELL_CRITICAL=STAT_SPELL_CRITICAL,
STAT_SPELL_MITIGATION=STAT_SPELL_MITIGATION,
STAT_SPELL_PENETRATION=STAT_SPELL_PENETRATION,
STAT_SPELL_POWER=STAT_SPELL_POWER,
STAT_SPELL_RESIST=STAT_SPELL_RESIST,
STAT_STAMINA_MAX=STAT_STAMINA_MAX,
STAT_STAMINA_REGEN_COMBAT=STAT_STAMINA_REGEN_COMBAT,
STAT_STAMINA_REGEN_IDLE=STAT_STAMINA_REGEN_IDLE,
STAT_WEAPON_AND_SPELL_DAMAGE=STAT_WEAPON_AND_SPELL_DAMAGE,
}
local TESOStatResist={
STAT_DAMAGE_RESIST_COLD=STAT_DAMAGE_RESIST_COLD,
STAT_DAMAGE_RESIST_DISEASE=STAT_DAMAGE_RESIST_DISEASE,
STAT_DAMAGE_RESIST_DROWN=STAT_DAMAGE_RESIST_DROWN,
STAT_DAMAGE_RESIST_EARTH=STAT_DAMAGE_RESIST_EARTH,
STAT_DAMAGE_RESIST_FIRE=STAT_DAMAGE_RESIST_FIRE,
STAT_DAMAGE_RESIST_GENERIC=STAT_DAMAGE_RESIST_GENERIC,
STAT_DAMAGE_RESIST_MAGIC=STAT_DAMAGE_RESIST_MAGIC,
STAT_DAMAGE_RESIST_OBLIVION=STAT_DAMAGE_RESIST_OBLIVION,
STAT_DAMAGE_RESIST_PHYSICAL=STAT_DAMAGE_RESIST_PHYSICAL,
STAT_DAMAGE_RESIST_POISON=STAT_DAMAGE_RESIST_POISON,
STAT_DAMAGE_RESIST_SHOCK=STAT_DAMAGE_RESIST_SHOCK,
STAT_DAMAGE_RESIST_START=STAT_DAMAGE_RESIST_START,
}
--Addon's name
StatViewer.name="StatViewer"
--Boolean for the config, to show all resistance
StatViewer.showRes=false

local function Initiliaze()
end

local function OnIndicatorMoveStop()
	StatViewer.savedVariables.left = StVaIndicator:GetLeft()
	StatViewer.savedVariables.top = StVaIndicator:GetTop()
end

local function RestorePosition()
	local left = StatViewer.savedVariables.left
	local top = StatViewer.savedVariables.top
	if left ~= nil and top ~= nil then
		StVaIndicator:ClearAnchors()
		StVaIndicator:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
	end
end

--Create the configuration menu
local function CreateConfigMenu()
	
	local panelData={ --header panel
		type="panel",
		name=StatViewer.name,
		displayName=StatViewer.name,
		author="Valball",	
	}
	local optionsData={
		type="header"
		name=GetString(StVaOPTIONSHEADER),
	},
	{	--Checkbox to show all resist
		type="checkbox",
		name=GetString(StVaOPTIONSRESIST),
		tooltip=GetString(StVaOPTIONSRESISTTOOLTIP)
		getFunc=function() return StatViewer.showRes end,
		setFunc=function(newValue)
			StatViewer.showRes=newValue
		end,
	}
	-- LibStub and LAM2 call
	local LAM2=LibStub("LibAddonMenu-2.0")
	LAM2:RegisterAddonPanel(StatViewer.name .. "Options",panelData)
	LAM2:RegisterOptionControls(StatViewer.name .. "Options",optionsData)
end

local function UpdateStats(event, addonName)
	StVaIndicatorLabel:SetText("")
		for t,x in pairs(TESOStat) do
			StVaIndicatorLabel:SetText(StVaIndicatorLabel:GetText()..t.." : "..GetPlayerStat(x,STAT_BONUS_OPTION_APPLY_BONUS).."\n")
	end
end

function StVa_ToggleMainWindow()
	--if StVaIndicator:IsHidden() then
		
	--end
	RestorePosition()
	SCENE_MANAGER:ToogleTopLevel(StVaIndicator)
end

local function OnAddOnLoaded(event, addonName)
	if addonName==StatViewer.name then
		--EVENT_MANAGER:RegisterForEvent(StatViewer.name, EVENT_STATS_UPDATED, UpdateStats)
		EVENT_MANAGER:UnregisterForEvent("StatViewer.OnAddOnLoaded",EVENT_ADD_ON_LOADED)
		StatViewer.savedVariables = ZO_SavedVars:NewAccountWide("SVSavedVariables", 1,nil,{})
		-- register keybinding
		ZO_CreateStringId("SI_BINDING_NAME_TOGGLE_StVa", GetString(StVaTOGGLE))
		-- Create the settings menu
		CreateConfigMenu()
		-- enable close on Esc
		--SCENE_MANAGER:RegisterTopLevel(StVaIndicator, false) 
		--RestorePosition()
	end
end

--Load addon
EVENT_MANAGER:RegisterForEvent(StatViewer.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)