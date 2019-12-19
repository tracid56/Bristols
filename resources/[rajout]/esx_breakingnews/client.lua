local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData  	= {}
local count 		= 0

local ambulance = "Ambulance"
local bahamas = "Bahama"
local gouvernement = "Gouvernement"
local journaliste = "Journaliste"
local depanneur = "Dépanneur"
local organisateur = "Organisateur"
local police = "LSPD"
local pompier = "LSFD"
local brinks = "Brinks"
local immobillier = "Immobilier"
local tabac = "Tabac"
local taxi = "Taxi"
local unicorn = "Unicorn"
local concessionnaire = "Concessionnaire"
local vigneron = "Vigneron"
local staff = "Staff"
local braquagebank = "Braquage de banque"
local braquageshop = "Braquage de magasin"
local bristols = "Bristols !"
local timedisplayed = 20

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function Ambulance(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(ambulance)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Bahama(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(bahama)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Gouvernement(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(gouvernement)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Journaliste(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(journaliste)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Depanneur(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(depanneur)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Organisateur(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(organisateur)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Police(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(police)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Brinks(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(brinks)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Pompier(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(pompier)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Immobillier(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(immobillier)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Taxi(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(taxi)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Tabac(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(tabac)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Unicorn(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(unicorn)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Concessionnaire(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(concessionnaire)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Vigneron(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(vigneron)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Staff(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(staff)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Braquagebank(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(braquagebank)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

function Braquageshop(mess)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(mess)
	PushScaleformMovieFunctionParameterString(bristols)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(braquageshop)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	
end

RegisterNetEvent("esx_breakingnews:ambulance")
AddEventHandler("esx_breakingnews:ambulance", function(mess)
	Ambulance(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:bahama")
AddEventHandler("esx_breakingnews:bahama", function(mess)
	Bahama(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:gouvernement")
AddEventHandler("esx_breakingnews:gouvernement", function(mess)
	Gouvernement(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:journaliste")
AddEventHandler("esx_breakingnews:journaliste", function(mess)
	Journaliste(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:depanneur")
AddEventHandler("esx_breakingnews:depanneur", function(mess)
	Depanneur(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:organisateur")
AddEventHandler("esx_breakingnews:organisateur", function(mess)
	Organisateur(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:police")
AddEventHandler("esx_breakingnews:police", function(mess)
	Police(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:brinks")
AddEventHandler("esx_breakingnews:brinks", function(mess)
	brinks(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:pompier")
AddEventHandler("esx_breakingnews:pompier", function(mess)
	Pompier(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:immobillier")
AddEventHandler("esx_breakingnews:immobillier", function(mess)
	Immobillier(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:tabac")
AddEventHandler("esx_breakingnews:tabac", function(mess)
	Tabac(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:taxi")
AddEventHandler("esx_breakingnews:taxi", function(mess)
	Taxi(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:unicorn")
AddEventHandler("esx_breakingnews:unicorn", function(mess)
	Unicorn(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:concessionnaire")
AddEventHandler("esx_breakingnews:concessionnaire", function(mess)
	Concessionnaire(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:vigneron")
AddEventHandler("esx_breakingnews:vigneron", function(mess)
	Vigneron(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:staff")
AddEventHandler("esx_breakingnews:staff", function(mess)
	Staff(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:braquagebank")
AddEventHandler("esx_breakingnews:braquagebank", function(mess)
	Braquagebank(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)

RegisterNetEvent("esx_breakingnews:braquageshop")
AddEventHandler("esx_breakingnews:braquageshop", function(mess)
	Braquageshop(mess)
		while count < timedisplayed*30 do
			Citizen.Wait(0)
			count = count + 1
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
		count = 0
end)