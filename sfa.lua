  script_name("SFA") 
  script_name("SFA")
script_description("/SFA - Îñíîâíàÿ êîìàíäà.")
script_version("3.6")
script_author("Rickot")
script_dependencies("SAMPFUNCS, SAMP")
--[[Áèëèîòåêè êîòîðûå áóäóò ïðèìåíÿòüñÿ  ïîñëå local è ïåðåä =, ýòî ëîêàëüíàÿ ïåðåìåííàÿ...
 êîòîðàÿ îáðàùàåòñÿ ê ôóíêöèè áðàâ íóæíóþ ëèáó]]
require("lib.moonloader")
require("lib.sampfuncs")
local sampev = require 'lib.samp.events'
local imgui = require "imgui"
local key = require "vkeys"
local https = require 'ssl.https'
local dlstatus = require('moonloader').download_status
local window1 = imgui.ImBool(false)
local window2 = imgui.ImBool(false)
local mainwindow = imgui.ImBool(false)
--[[Ýíêîäèíã ýòî ãðóáî ãîâîðÿ ïåðåâîä UTF8 â êèðèëèöó (à êàê ìû çíàåì utf8 ýòî èíãëèø..)]]
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

jstart = 1 -- jstart ýòî âîñïðîèçâîäíàÿ òåêñòà ïðè çàïóñêå..

function main()
  	if not isSampLoaded() or not isSampfuncsLoaded() then return end
		autoupdate("https://github.com/WesternZM/Sfa/blob/2ec22b2c5fb44a316c28da836c8d0595ea650775/SFA.json", '['..string.upper(thisScript().name)..']: ', "https://github.com/WesternZM/Sfa/blob/2ec22b2c5fb44a316c28da836c8d0595ea650775/SFA.json")
	while not isSampAvailable() do wait(1000) end
--   checkUpdate()
    -- Ïî ïðèíòó ìîæíî ïîíÿòü ÷òî íèæå ïðîâåðêà ñåðâåðà
		print("Ïðîâåðêà ñåðâåðà...")
    	if sampGetCurrentServerAddress() =="217.106.106.86" then
    		gameServer = "Western zm"
    		srv = 1
	--[[elseif ýòî êàê if âûøå òîê äîï ê îäíóìó else è end]]	elseif sampGetCurrentServerAddress() == "217.106.106.86" then -- ýò äîáàâèë øîá ÿ ìîã åãî òåñòèòü
			gameServer = ""
			srv = 2
		else
			print("Ñåðâåð íå äîïóùåí, ðàáîòà ñêðèïòà çàâåðøåíà")
    		sampAddChatMessage("[SFA]{FFFFFF} Ê ñîæàëåíèþ, äàííûé ñêðèïò íåäîñòóïåí äëÿ ðàáîòû íà äàííîì ñåðâåðå.", 0x046D63)
    		sampAddChatMessage("[SFA]{FFFFFF} Ñâÿæèòåñü ñ ðàçðàáîò÷èêîì, åñëè õîòèòå óòî÷íèòü âîçìîæíîñòü ðåøåíèÿ äàííîé ïðîáëåìû.", 0x046D63)
    		thisScript():unload()
    		return
    	end
    	print("Ïðîâåðêà ïðîéäåíà, ñåðâåð: "..tostring(gameServer))

 if jstart == 1 then
    sampAddChatMessage("{ffffff}* [SFA{ffffff}]: {00BFFF}SFA äëÿ àäìèíèñòðàöèè Western ZM", -1)
    sampAddChatMessage("{ffffff}* [SFA{ffffff}]: {00BFFF}Ñêðèïò óñïåøíî çàïóùåí. - [/sfa].", -1)
	sampAddChatMessage('{ffffff}* [SFA{ffffff}]: {00BFFF}Òåêóùàÿ âåðñèÿ: '..thisScript().version)
 elseif jstart == 2 then
    sampfuncsLog('{ffffff}* [{949055} SFA{ffffff}]: {949055}Òåêóùàÿ âåðñèÿ : '..thisScript().version)
  end
  --------------------------ÊÎÌÀÍÄÛ--------------------------
sampRegisterChatCommand("sfa", window)
sampRegisterChatCommand("rt", rt)
sampRegisterChatCommand("nenaeb", nenaeb)
     ---------------------Îòâåòû â ðåïîðòó-------------------
sampRegisterChatCommand("da", otvetda) -- "da"
sampRegisterChatCommand("yes", yes) -- "äà"
sampRegisterChatCommand("net", otvetnet) -- "íåò"
sampRegisterChatCommand("no", no) -- "íåò"
sampRegisterChatCommand("zm", zm) -- "èãðîê çîìáè"
sampRegisterChatCommand("pri", otvetpri) -- "ïðèÿòíîé èãðû"
sampRegisterChatCommand("spect", otvetspect) -- "ñëåæó"
sampRegisterChatCommand("s", s) -- "ñëåæó"
sampRegisterChatCommand("google", google) -- "íàéäèòå ýòó èíôîðìàöèþ â èíòåðíåòå"
sampRegisterChatCommand("sorry", sorry) -- "ïðèíîñèì ñâîè èçâèíåíèÿ çà ïðåäîñòàâëåííûå íåóäîáñòâà"
sampRegisterChatCommand("infprest", otvetprest) -- èíôîðìàöèÿ î ïðåñòèæå
sampRegisterChatCommand("infcost", infcost) -- èíôîðìàöèÿ î öåíå ïðåäìåòîâ
sampRegisterChatCommand('infcaps', infcaps) -- èíôîðìàöèÿ î êàïñå
sampRegisterChatCommand("ukrit", otvetukrit) -- "â óêðûòèå"
sampRegisterChatCommand("chist", otvetchist) -- "íå çàìåòèë íàðóøåíèé îò èãðîêà"
sampRegisterChatCommand("infroll", otvetinfrol) -- èíôîðöèÿ î ðóëåòêå
sampRegisterChatCommand("infclass", otvetinfclass) -- èíôîðìàöèÿ î êëàññàõ
sampRegisterChatCommand("inftrade", inftrade) -- èíôîðöèÿ î òðåéäàõ
sampRegisterChatCommand("sekret", sekret) -- "íå ðàñïðîñòðàíÿåì èíôîðìàöèþ"
sampRegisterChatCommand("infpvp2", infpvp2) -- "êîìàíäíàÿ èãðà íà ïâï ðàçðåøåíà"
sampRegisterChatCommand("infpvp", infpvp) -- Ýòî ïâï êàðòà, òóò ðàçðåøåíî óáèâàòü âûæèâøèõ
sampRegisterChatCommand("predup", predup) -- "Ïðåäóïðåäèë èãðîêà"
sampRegisterChatCommand("pred", pred) -- "Ïðåäóïðåäèë èãðîêà"
sampRegisterChatCommand("forum", otvetforum) -- "íàïèøèòå æàëîáó íà ôîðóì"
sampRegisterChatCommand("tehforum", tehforum) -- "íàïèøèòå â òåõ.ðàçäåë íà ôîðóìå"
sampRegisterChatCommand("stopblock", stopblock) -- "ïðåêðàòèòå áëîêèðîâàòü óêðûòèå"
sampRegisterChatCommand("tut", tut) -- "íà÷èíàéòå èãðó"
sampRegisterChatCommand("hz", otvethz) -- "íå ìîãó äàòü îòâåò íà âàø âîïðîñ"
sampRegisterChatCommand("nepon", otvetnepon) -- "íåïîíÿë âàøåãî âîïðîñà"
sampRegisterChatCommand("nakazan", otvetnakazan) -- "èãðîê íàêàçàí"
sampRegisterChatCommand("pomog", otvetpomog) -- "ïîìîã âàì"
sampRegisterChatCommand("prohod", prohod) -- "ïðîõîäèòå êàðòó"
sampRegisterChatCommand("stoptk", stoptk) -- "ïðåêðàòèòå ÒÊ"
sampRegisterChatCommand("stopofftop", stopofftop) -- "ïðåêðàòèòå îôôòîï â ðåïîðò"
sampRegisterChatCommand("stopzapret", stopzapret) -- "âû â çàïðåòíîì óêðûòèè"
sampRegisterChatCommand("stoppom", stoppom) -- "ïðåêðàòèòå ïîìåõó"
---------------------Íàêàçàíèÿ----------------------
sampRegisterChatCommand("cheat", cheat) -- ÷èò
sampRegisterChatCommand("capsosk", capsosk) -- êàïñ + îñê.
sampRegisterChatCommand("osk", oskorbil) -- îñêîðáëåíèå èãðîêîâ
sampRegisterChatCommand("admosk", adminaosknyl) -- îñê. àäìèíèñòðàöèè
sampRegisterChatCommand("oskadm", oskadm) -- îñê.àäìèíèñòðàöèè
sampRegisterChatCommand("capsoskadm", capsoskadm) -- êàïñ + îñê.àäì
sampRegisterChatCommand("oskadmcaps", oskadmcaps) -- êàïñ + îñê.àäì
sampRegisterChatCommand("caps", caps) -- êàïñ
sampRegisterChatCommand("obman", obman) -- îáìàí èãðîêîâ
sampRegisterChatCommand("pomeha", pomeha) -- ïîìåõà
sampRegisterChatCommand("oskproject", oskproject) -- îñê. ïðîåêòà
sampRegisterChatCommand("oskprojectcaps", oskprojectcaps) -- îñê. ïðîåêòà + êàïñ
sampRegisterChatCommand("capsoskproject", capsoskproject) -- îñê. ïðîåêòà + êàïñ
sampRegisterChatCommand("upom", upominul) -- óïîìèíàíèå ðîäíûõ
sampRegisterChatCommand("mq", mq) -- óïîìèíàíèå ðîäíûõ
sampRegisterChatCommand("capsmq", capsmq) -- êàïñ + óïîìèíàíèå ðîäíûõ
sampRegisterChatCommand("capsupom", capsupom) -- êàïñ + óïîìèíàíèå ðîäíûõ
sampRegisterChatCommand("mqcaps", mqcaps) -- êàïñ + óïîìèíàíèå ðîäíûõ
sampRegisterChatCommand("upomcaps", upomcaps) -- êàïñ + óïîìèíàíèå ðîäíûõ
sampRegisterChatCommand("derz", derz) -- äåðçêîå îòíîøåíèå ê àäì
sampRegisterChatCommand("afk", heafk) -- àôê áåç ïàóçû
sampRegisterChatCommand("tks", tksurvive) -- òê âûæèâøèé
sampRegisterChatCommand("tks2", tks2) -- âàðí çà ÒÊ 
sampRegisterChatCommand("upomproject", upomproject) -- óïîìèíàíèå ñòîðîííèõ ïðîåêòîâ
sampRegisterChatCommand("tkz", tkzombie) -- òê çîìáè
sampRegisterChatCommand("bag", bag) -- áàãîþç
sampRegisterChatCommand("wafk", wafk) -- àôê â áîþ
sampRegisterChatCommand("neproh", neproh) -- íåïðîõîæäåíèå êàðòû
sampRegisterChatCommand("beg", begun) -- áåã ïî êàðòå
sampRegisterChatCommand("offtop", offtopinreport) -- îôôòîï â ðåïîðò
sampRegisterChatCommand("udlin", dlinner) -- óäëèííåíèå ñîîáùåíèé
sampRegisterChatCommand("pust", pustoi) -- ïóñòûå ñîîáùåíèÿ
sampRegisterChatCommand("zapret", zapret) -- çàïðåòíîå óêðûòèå
sampRegisterChatCommand("capsudlin", capsudlin) -- óäëèíåíèå + êàïñ
sampRegisterChatCommand("udlincaps", udlincaps) -- óäëèíåíèå + êàïñ
sampRegisterChatCommand("rz", rz) -- Âûõîä ðàíäîì çì
sampRegisterChatCommand("teampvp", teampvp) -- òèì íà ïâï
sampRegisterChatCommand("team", team) -- Êîìàíäíàÿ èãðà çîìáè ñ âûæèâøåì --
resX, resY = getScreenResolution()
while true do wait(0)
    ------------- Èìãóè ïðîöåññ ýòî ðåãà îêîí èìãóè..
imgui.Process = window1.v or window2.v or  mainwindow.v

    end
end

--------------------------------------------------------------------------------------------
----------------------------------------ÎÒÂÅÒÛ ÍÀ ÐÅÏÎÐÒ------------------------------------
--------------------------------------------------------------------------------------------

function otvetda(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Äà.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Äà". [/da id].', -1)
        end
    end
end

function yes(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Äà.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Äà". [/yes id].', -1)
        end
    end
end

    function otvetnet(param)
            id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Íåò.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Íåò". [/net id].', -1)
        end
    end
end

function no(param)
				id = tonumber(param)
if param then
		if id ~= nil then
								sampSendChat('/ans '..id..' Íåò.')
						 else
				sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Íåò". [/no id].', -1)
		end
end
end

function zm(param)
				id = tonumber(param)
if param then
		if id ~= nil then
								sampSendChat('/ans '..id..' Äàííûé èãðîê ÿâëÿåòñÿ çîìáè.')
						 else
				sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Èãðîê çîìáè". [/zm id].', -1)
		end
end
end

function otvetpomog(param)
				id = tonumber(param)
if param then
		if id ~= nil then
								sampSendChat('/ans '..id..' Ïîìîã Âàì. Ïðèÿòíîé èãðû :) ')
						 else
				sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Ïîìîã Âàì". [/pomog id].', -1)
		end
end
end

function otvetpri(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Ïðèÿòíîé èãðû íà Western ZM :)')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Ïðèÿòíîé èãðû". [/pri id].', -1)
        end
    end
end

function otvethz(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Ê ñîæàëåíèþ, ÿ íå ìîãó äàòü îòâåò íà Âàø âîïðîñ.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Íå ìîãó äàòü îòâåò íà âàø âîïðîñ". [/hz id].', -1)
        end
    end
end

function otvetnepon(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Íå ïîíÿë Âàøåãî âîïðîñà.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Íå ïîíÿë âàøåãî âîïðîñà". [/nepon id].', -1)
        end
    end
end

function stoptk(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Ïåðåñòàíüòå íàíîñèòü óðîí ïî ñâîèì ñîþçíèêàì, èíà÷å Âû áóäåòå íàêàçàíû.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Ïðåêðàòèòå ÒÊ". [/stoptk id].', -1)
        end
    end
end

function stopzapret(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Âû íàõîäèòåñü â çàïðåòíîì óêðûòèè. Ïîêèíüòå åãî, èíà÷å áóäåòå íàêàçíû.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Ýòî çàïðåòíîå óêðûòèå". [/stopzapret id].', -1)
        end
    end
end

function otvetnakazan(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Èãðîê íàêàçàí. Ïðèÿòíîé èãðû :)')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Èãðîê íàêàçàí". [/nakazan id].', -1)
        end
    end
end

function inftrade(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' /sellthing id(Èãðîêà) id(Ïðåäìåòà) öåíà - ïðîäàòü èãðîêó...')
                    sampSendChat('/ans '..id..' /sellthing-ïðîäàòü ñåðâåðó.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò íà âîïðîñ "êàê ïðîäàòü âåùè?". [/inftrade id].', -1)
        end
    end
end

function otvetspect(param)
id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Ðàáîòàþ ïî Âàøåìó ðåïîðòó.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Ðàáîòàþ". [/spect id]', -1)
        end
    end
end

function s(param)
id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Ðàáîòàþ ïî Âàøåìó ðåïîðòó.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Ðàáîòàþ". [/s id]', -1)
        end
    end
end

function predup(param)
id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Ïðåäóïðåäèë èãðîêà.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Ïðåäóïðåäèë èãðîêà". [/predup id]', -1)
        end
    end
end

function pred(param)
id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Ïðåäóïðåäèë èãðîêà.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Ïðåäóïðåäèë èãðîêà". [/pred id]', -1)
        end
    end
end

function stoppom(param)
id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Íå ñîçäàâàéòå ïîìåõó èãðîêàì.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Íå ñîçäàâàéòå ïîìåõó". [/stoppom id]', -1)
        end
    end
end

function infcost(param)
  id = tonumber(param)
  if param then
    if id ~= nil then
                    sampSendChat('/ans '..id..'  Öåíà ïðåäìåòîâ çàâèñèò îò ñàìèõ èãðîêîâ.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Öåíà ïðåäìåòîâ çàâèñèò îò èãðîêîâ. [/infcost id]', -1)
        end
    end
end

function otvetukrit(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Ó Âàñ åñòü 15 ñåêóíä, ÷òîáû íàéòè óêðûòèå!')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Â óêðûòèå". [/ukrit id]', -1)
						sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: {DC143C}Íà ïâï êàðòàõ áåã ðàçðåø¸í!', -1)
        end
    end
end

function sekret(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Ìû íå ðàñïðîñòðàíÿåì ýòó èíôîðìàöèþ.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Íå ðàñïðîñòðàíÿåì ýòó èíôîðìàöèþ". [/sekret id]', -1)
        end
    end
end

function sorry(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Ïðèíîñèì ñâîè èçâèíåíèÿ çà ïðåäîñòàâëåííûå íåóäîáñòâà.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Ïðèíîñèì ñâîè èçâèíåíèÿ çà ïðåäîñòàâëåííûå íåóäîáñòâà". [/sorry id]', -1)
        end
    end
end

function otvetchist(param)
  id = tonumber(param)
  if param then
    if id ~= nil then
    sampSendChat('/ans '..id..' Íå çàìåòèë íàðóøåíèé îò äàííîãî èãðîêà.')
   else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Íàðóøåíèé íå çàìåòèë". [/chist id]', -1)
      end
     end
end

function otvetinfclass(param)
	 id = tonumber(param)
	 if param then
		 if id ~= nil then
                sampSendChat('/ans '..id..' /info - Èíôîðìàöèÿ î êëàññõ. ')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò íà âîïðîñ ïî êëàññàì. [/infclass id]', -1)
        end
    end
end

function infpvp(param)
	 id = tonumber(param)
	 if param then
		 if id ~= nil then
                sampSendChat('/ans '..id..' Ýòî êàðòà òèïà "PVP", òóò ðàçðåøåíî óáèâàòü âûæèâøèõ. ')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Íà ïâï ðàçðåøåíî óáèâàòü âûæèâøèõ" [/infpvp id]', -1)
        end
    end
end

function stopofftop(param)
	 id = tonumber(param)
	 if param then
		 if id ~= nil then
                sampSendChat('/ans '..id..' Íå èñïîëüçóéòå ðåïîðò äëÿ îáùåíèÿ. ')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Íå èñïîëüçóéòå ðåïîðò äëÿ îáùåíèÿ" [/stopofftop id]', -1)
        end
    end
end

function google(param)
	 id = tonumber(param)
	 if param then
		 if id ~= nil then
                sampSendChat('/ans '..id..' Ïîïðîáóéòå íàéòè ýòó èíôîðìàöèþ â èíòåðíåòå. ')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Ïîïðîáóéòå íàéòè ýòó èíôîðìàöèþ â èíòåðíåòå" [/google id]', -1)
        end
    end
end

function stopblock(param)
	 id = tonumber(param)
	 if param then
		 if id ~= nil then
                sampSendChat('/ans '..id..' Ïåðåñòàíüòå áëîêèðîâàòü óêðûòèå, èíà÷å Âû áóäåòå íàêàçàíû. ')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Ïðåêðàòèòå áëîêèðîâàòü óêðûòèå" [/stopblock id]', -1)
        end
    end
end

function otvetforum(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/ans '..id..' Íàïèøèòå æàëîáó íà ôîðóì forum-western-zm.ru .')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Æàëîáó íà ôîðóì". [/forum id]', -1)
		end
    end
end

function tehforum(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/ans '..id..' Îáðàòèòåñü â òåõ.ðàçäåë íà ôîðóìå.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Îáðàòèòåñü â òåõ.ðàçäåë íà ôîðóìå". [/tehforum id]', -1)
		end
    end
end

function tut(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/ans '..id..' Âû òóò? Íà÷èíàéòå èãðó, èíà÷å Âû áóäåòå êèêíóòû.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Íà÷èíàéòå èãðó". [/tut id]', -1)
		end
    end
end

function prohod(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/ans '..id..' Ïðîõîäèòå êàðòó, èíà÷å Âû áóäåòå êèêíóòû çà íåïðîõîæäåíèå êàðòû.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Îòâåò "Ïðîõîäèòå êàðòó". [/prohod id]', -1)
		end
    end
end

----------------------------------------------------------------------------------------
----------------------------------------ÊÈÊÈ ÈÃÐÎÊÎÂ------------------------------------
----------------------------------------------------------------------------------------

function heafk(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/kick '..id..' Àôê áåç ïàóçû (esc).')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Êèêíóòü çà àôê áåç ïàóçû [/afk id]', -1)
		end
	end
end

function begun(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/kick '..id..' Áåã ïî êàðòå.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Êèêíóòü çà áåã ïî êàðòå [/beg id]', -1)
		sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: {DC143C}Íà ïâï êàðòàõ áåã ðàçðåø¸í!', -1)
		end
	end
end

function tksurvive(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/kick '..id..' ÒÊ (Âûæèâøèé).')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Êèêíóòü çà òê (âûæèâøèé) [/tks id]', -1)
		end
	end
end

function zapret(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/kick '..id..'  Çàïðåòíîå óêðûòèå.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Êèêíóòü çà òê (âûæèâøèé) [/zapret id]', -1)
		end
	end
end

function pomeha(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/kick '..id..' Ïîìåõà.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Êèêíóòü çà ïîìåõó [/pomeha id]', -1)
		end
	end
end

function neproh(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/kick '..id..' Íåïðîõîæäåíèå êàðòû.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Êèêíóòü çà íåïðîõîæäåíèå êàðòû [/neproh id]', -1)
		end
	end
end

----------------------------------------------------------------------------------------
----------------------------------------ÂÛÄÀ×À ÌÓÒÎÂ------------------------------------
----------------------------------------------------------------------------------------

function oskproject(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/mute '..id..' 60 Îñêîðáëåíèå ïðîåêòà.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü ìóò çà îñê. ïðîåêòà. [/oskproject id]', -1)
		end
    end
end

function capsoskproject(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/mute '..id..' 70 Îñêîðáëåíèå ïðîåêòà + êàïñ.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü ìóò çà îñê. ïðîåêòà + êàïñ [/capsoskproject id]', -1)
		end
    end
end

function oskprojectcaps(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/mute '..id..' 70 Îñêîðáëåíèå ïðîåêòà + êàïñ.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü ìóò çà îñê. ïðîåêòà + êàïñ [/oskprojectcaps id]', -1)
		end
    end
end

function caps(param)
	id = tonumber(param)
	if param then
		if id ~= nil then
			sampSendChat('/mute '..id..' 10 Caps.')
		else
				sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü ìóò çà êàïñ. [/caps id]', -1)
		end
	end
end

function upomproject(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/mute '..id..' 60 Óïîìèíàíèå ñòîðîííèõ ïðîåêòîâ.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü ìóò çà óïîìèíàíèå ñòîðîííèõ ïðîåêòîâ. [/upomproject id]', -1)
		end
    end
end

function spam(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/mute '..id..' 30 Ñïàì.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü ìóò çà ñïàì. [/spam id]', -1)
		end
    end
end

function obman(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/mute '..id..' 30 Îáìàí èãðîêîâ.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü ìóò çà îáìàí èãðîêîâ. [/obman id]', -1)
		end
    end
end

function upominul(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 180 Óïîìèíàíèå ðîäíûõ.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü ìóò çà óïîìèíàíèå ðîäíûõ [/upom id]', -1)
		end
	end
end

function mq(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 180 Óïîìèíàíèå ðîäíûõ.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü ìóò çà óïîìèíàíèå ðîäíûõ [/mq id]', -1)
		end
	end
end

function capsmq(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 190 Óïîìèíàíèå ðîäíûõ + Êàïñ.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü ìóò çà óïîì. ðîäíûõ + Êàïñ [/capsmq id]', -1)
		end
	end
end

function mqcaps(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 190 Óïîìèíàíèå ðîäíûõ + Êàïñ.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü ìóò çà óïîì. ðîäíûõ + Êàïñ [/mqcaps id]', -1)
		end
	end
end

function capsupom(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 190 Óïîìèíàíèå ðîäíûõ + Êàïñ.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü ìóò çà óïîì. ðîäíûõ + Êàïñ [/capsupom id]', -1)
		end
	end
end

function upomcaps(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 190 Óïîìèíàíèå ðîäíûõ + Êàïñ.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü ìóò çà óïîì. ðîäíûõ + Êàïñ [/upomcaps id]', -1)
		end
	end
end

function offtopinreport(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 10 Îôôòîï â ðåïîðò. ')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Äàòü ìóò çà îôôòîï â ðåïîðò [/offtop id]', -1)
		end
	end
end

function oskorbil(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 30 Îñêîðáëåíèå èãðîêîâ')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Äàòü ìóò çà îñê. èãðîêîâ [/osk id]', -1)
		end
	end
end

function capsosk(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 40 Îñê. èãðîêîâ + Êàïñ.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Äàòü ìóò çà êàïñ + îñê. [/capsosk id]', -1)
		end
	end
end

function adminaosknyl(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 60 Îñêîðáëåíèå àäìèíèñòðàöèè.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Äàòü ìóò çà îñêîðáëåíèå Àäìèíèñòðàöèè [/admosk id]', -1)
		end
	end
end

function oskadm(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 60 Îñêîðáëåíèå àäìèíèñòðàöèè.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Äàòü ìóò çà îñêîðáëåíèå Àäìèíèñòðàöèè [/oskadm id]', -1)
		end
	end
end

function capsoskadm(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 70 Îñê.àäìèíèñòðàöèè + êàïñ.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Äàòü ìóò çà îñê. àäì. + êàïñ [/capsoskadm id]', -1)
		end
	end
end

function oskadmcaps(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 70 Îñê.àäìèíèñòðàöèè + êàïñ.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Äàòü ìóò çà îñê. àäì. + êàïñ [/oskadmcaps id]', -1)
		end
	end
end

function pustoi(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 20 Ïóñòûå ñîîáùåíèÿ.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Äàòü ìóò çà ïóñòûå ñîîáùåíèÿ [/pust id]', -1)
		end
	end
end

----------------------------------------------------------------------------------------
----------------------------------------ÂÛÄÀ×À ÂÀÐÍÎÂ------------------------------------
----------------------------------------------------------------------------------------

function bag(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/warn '..id..' Áàãîþç.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü âàðí çà áàãîþç [/bag id]', -1)
		end
	end
end

function tkzombie(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/warn '..id..' ÒÊ (Çîìáè).')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü âàðí çà ÒÊ (çîìáè) [/tkz id]', -1)
		end
	end
end

function tks2(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/warn '..id..' ÒÊ .')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü âàðí çà ÒÊ [/tks2 id]', -1)
		end
	end
end

function team(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/warn '..id..' Êîìàíäíàÿ èãðà çîìáè ñ âûæèâøèì .')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü âàðí çà ñîâìåñòíóþ èãðó çîìáè ñ âûæèâøåì [/team id]', -1)
		end
	end
end

function wafk(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/warn '..id..' Àôê â áîþ')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü âàðí çà àôê â áîþ [/wafk id]', -1)
		end
	end
end

function rz(param)
nick = tostring(param)
if param then
    if nick ~= nil then
        sampSendChat('/offwarn '..nick..' Âûõîä Ð.Ç')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü âàðí çà âûõîä Ð.Ç [/rz nick]', -1)
		end
	end
end

function teampvp(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/warn '..id..' Êîìàíäíàÿ èãðà íà PVP')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü âàðí çà êîìàíäíóþ èãðó íà PVP [/teampvp id]', -1)
		end
	end
end

----------------------------------------------------------------------------------------
----------------------------------------ÂÛÄÀ×À ÁÀÍÎÂ------------------------------------
----------------------------------------------------------------------------------------

function cheat(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/ban '..id..' 30 ×èò.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Âûäàòü áàí çà èñïîëüçîâàíèå ÷èòîâ [/cheat id]', -1)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------ÎÑÒÀËÜÍÎÅ---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

function rt(param)
lua_thread.create(function()
if param then
sampSendChat('/msg Çàìåòèëè ÷èòåðà? Åñòü âîïðîñû ïî èãðîâîìó ïðîöåññó?')
wait(500)
sampSendChat('/msg Àäìèíèñòðàöèÿ ñåðâåðà âñåãäà ãîòîâà ïîìî÷ü Âàì [/report]')
else
end
end)
end

function ob(param)
lua_thread.create(function()
if param then
sampSendChat('/msg Óâàæàåìûå èãðîêè!')
wait(500)
sampSendChat('/msg äëÿ ïðîâåäåíèÿ áåçîïàñíûõ îáìåíîâ ïðåäìåòàìè è àðåíäû áåç ðèñêà.')
wait(500)
sampSendChat('/msg Îçíàêîìüòåñü ñ òåìîé "Îáìåí/àðåíäà ïðåäìåòîâ" â ðàçäåëå Amazing ZM.')
wait(500)
sampSendChat('/msg Íàø ôîðóì [ forum.amazing-zm.ru ]')
else
end
end)
end

function nenaeb(param)
lua_thread.create(function()
if param then
sampSendChat('/msg Óâàæàåìûå èãðîêè!')
wait(500)
sampSendChat('/msg Ïðîâåðÿéòå äàííûå òðåéäà ïåðåä ïðèíÿòèåì ïðåäëîæåíèÿ!')
wait(500)
sampSendChat('/msg Çà÷àñòóþ ïðîèñõîäÿò îáìàíû, âèíîé êîòîðûõ òîëüêî Âàøà íåâíèìàòåëüíîñòü!')
wait(500)
sampSendChat('/msg Íèêîãäà íå ñïåøèòå çàâåðøàòü ñäåëêó!')
else
end
end)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------MENU--------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
function apply_custom_style() --[[èìãóè ñòèëü.. ñòîèò àíäðîâèðà, íî ìîæíî
    ïîñòàâèòü è äðóãóþ.. ÍÎ ÷àñòî èõ âûêëàäûâàþò â C++ òîáèøü íàäî áóäåò ïåðåâåñòè â lua (ýòî èçè)]]
			imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
	style.ChildWindowRounding = 2.0
	style.FrameRounding = 2.0
	style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
	style.ScrollbarSize = 13.0
	style.ScrollbarRounding = 0
	style.GrabMinSize = 8.0
	style.GrabRounding = 1.0

	colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled] = ImVec4(0.60, 0.60, 0.60, 1.00)
	colors[clr.WindowBg] = ImVec4(0.11, 0.10, 0.11, 1.00)
	colors[clr.ChildWindowBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.PopupBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.Border] = ImVec4(0.86, 0.86, 0.86, 1.00)
	colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.FrameBg] = ImVec4(0.21, 0.20, 0.21, 0.60)
	colors[clr.FrameBgHovered] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.FrameBgActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.TitleBg] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.TitleBgActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.MenuBarBg] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.ScrollbarBg] = ImVec4(0.00, 0.46, 0.65, 0.00)
	colors[clr.ScrollbarGrab] = ImVec4(0.00, 0.46, 0.65, 0.44)
	colors[clr.ScrollbarGrabHovered] = ImVec4(0.00, 0.46, 0.65, 0.74)
	colors[clr.ScrollbarGrabActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.ComboBg] = ImVec4(0.15, 0.14, 0.15, 1.00)
	colors[clr.CheckMark] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.SliderGrab] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.SliderGrabActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.Button] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.ButtonHovered] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.ButtonActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.Header] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.HeaderHovered] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.HeaderActive] = ImVec4(0.00, 0.46, 0.65, 1.00)
	colors[clr.ResizeGrip] = ImVec4(1.00, 1.00, 1.00, 0.30)
	colors[clr.ResizeGripHovered] = ImVec4(1.00, 1.00, 1.00, 0.60)
	colors[clr.ResizeGripActive] = ImVec4(1.00, 1.00, 1.00, 0.90)
	colors[clr.CloseButton] = ImVec4(1.00, 0.10, 0.24, 0.00)
	colors[clr.CloseButtonHovered] = ImVec4(0.00, 0.10, 0.24, 0.00)
	colors[clr.CloseButtonActive] = ImVec4(1.00, 0.10, 0.24, 0.00)
	colors[clr.PlotLines] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.PlotLinesHovered] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.PlotHistogram] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.PlotHistogramHovered] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.TextSelectedBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.ModalWindowDarkening] = ImVec4(0.00, 0.00, 0.00, 0.00)
end
apply_custom_style()
do
	local cb_render_in_menu = imgui.ImBool(imgui.RenderInMenu)
	local cb_lock_player = imgui.ImBool(imgui.LockPlayer)
	local cb_show_cursor = imgui.ImBool(imgui.ShowCursor)
	local glyph_ranges_cyrillic = nil
function imgui.OnDrawFrame()
if mainwindow.v then window1.v = false window2.v = false
imgui.SetNextWindowSize(imgui.ImVec2(720, 555), imgui.Cond.Always)
imgui.SetNextWindowPos(imgui.ImVec2(resX / 2, resY / 2), imgui.Cond.Once, imgui.ImVec2(0.5, 0.5))
imgui.Begin(u8'Ãëàâíîå ìåíþ |SFA| .', mainwindow, img_state) --imgui.WindowFlags.NoResize)
		imgui.BeginChild('#MM', imgui.ImVec2(720,500), true)
		local nakaz = [[Áëîêèðîâêà ÷àòà:
 /offtop - Îôôòîï â ðåïîðò.
 /osk - Îñêîðáëåíèå èãðîêîâ.
 /admosk - Îñêîðáëåíèå àäìèíèñòðàöèè.
 /capsoskadm, /oskadmcaps - Îñê. àäìèíèñòðàöèè + êàïñ.
 /oskproject - Îñêîðáëåíèå ïðîåêòà.
 /oskprojectcaps, /capsoskproject - Îêñ. ïðîåêòà + êàïñ.
 /upom, /mq - Óïîìèíàíèå ðîäíûõ.
 /capsmq, /mqcaps - Óïîìèíàíèå ðîäíûõ + êàïñ.
 /capsupom, upomcaps - Óïîìèíàíèå ðîäíûõ + êàïñ.
 /pust - Ïóñòûå ñîîáùåíèÿ.
 /caps - Êàïñ.
 /capsosk - Êàïñ + îñê.
 /upomproject - Óïîìèíàíèå ñòîðîííèõ ïðîåêòîâ.
 /obman - Îáìàí èãðîêîâ.

Êèê èãðîêà:
 /tks - Team Kill (Âûæèâøèé/Survivor).
 /neproh - Íåïðîõîæäåíèå êàðòû.
 /beg - Áåã ïî êàðòå.
 /afk - Àôê áåç ïàóçû.
 /pomeha - Ïîìåõà.
 /zapret - Çàïðåòíàÿ íû÷êà.

Ïðåäóïðåæäåíèÿ:
 /bag - Áàãîþç.
 /wafk - Àôê â áîþ.
 /tkz - Team Kill (Çîìáè/Zombie).
 /tks2 - ÒÊ âûæèâøèõ
 /team - Âûäàòü âàðí çà ñîâìåñòíóþ èãðó çîìáè ñ âûæèâøåì
 /rz - Âûäàòü âàðí çà âûõîä Ð.Ç
 /teampvp - Âûäàòü âàðí çà êîìàíäíóþ èãðó íà PVP


Áëîêèðîâêà àêêàóíòà:
 /cheat - Èñïîëüçîâàíèå ÷èòîâ]]
		imgui.Text(u8(nakaz))
		imgui.Text('---------------------------------------------------------------')
local otv = [[Îòâåòû ïî ðåïîðòó:
 /da, /yes -  Äà.
 /net, /no -   Íåò.
 /zm - Äàííûé èãðîê ÿâëÿåòñÿ çîìáè.
 /hz - Íå ìîãó îòâåòèòü íà âàø âîïðîñ.
 /nepon - Íå ïîíÿë âàøåãî âîïðîñà.
 /pri -   Ïðèÿòíîé èãðû :)
 /pomog - Ïîìîã Âàì.
 /predup, /pred - Ïðåäóïðåäèë èãðîêà.
 /spect, /s -   Ðàáîòàþ ïî Âàøåé æàëîáå.
 /nakazan - Èãðîê íàêàçàí.
 /chist -   Íå íàáëþäàþ íàðóøåíèé îò äàííîãî èãðîêà.
 /stoptk - Ïðåêðàòèòå ÒÊ.
 /sekret - Íå ðàñïðîñòðàíÿåì ýòó èíôîðìàöèþ.
 /ukrit -   Áåãèòå ñêîðåå â óêðûòèå.
 /prohod - Ïðîõîäèòå êàðòó.
 /tut - Íà÷èíàéòå èãðó.
 /forum -   Íàïèøèòå æàëîáó íà ôîðóì.
 /prest -   Äëÿ ïîëó÷åíèÿ ïðåñòèæà.
 /infclass -    Ïîäðîáíàÿ èíôîðöèÿ î êëàññàõ.
 /inftrade - Îòâåò íà âîïðîñ "Êàê ïðîäàòü âåùè?"
 /infcost - Öåíà ïðåäìåòîâ çàâèñèò îò èãðîêîâ.
 /infpvp - Íà ïâï êàðòå ðàçðåøåíî óáèâàòü âûæèâøèõ
 /stopblock - Ïðåêðàòèòå áëîêèðîâàòü óêðûòèå.
 /stopofftop - Íå èñïîëüçóéòå ðåïîðò äëÿ îáùåíèÿ.
 /stopzapret - Âû íàõîäèòåñü â çàïðåòíîì óêðûòèè.
 /tehforum - Îáðàòèòåñü â òåõ.ðàçäåë íà ôîðóìå
 /google - Íàéäèòå ýòó èíôîðìàöèþ â èíòåðíåòå
 /sorry - Ïðèíîñèì ñâîè èçâèíåíèÿ çà ïðåäîñòàâëåííûå íåóäîáñòâà


Äðóãîå:
 /rt - Íàïèñàòü â îáùèé ÷àò î ðåïîðòå.
 /nenaeb - Íàïèñàòü â îáùèé ÷àò î âíèìàòåëüíîñòè ïðè òðåéäàõ.
]]
	imgui.Text(u8(otv))

  imgui.EndChild()
  imgui.End()
end
end
end

			function window() -- ôóíêöèÿ âûçîâà ãëàâíîãî îêíà..
			mainwindow.v = not mainwindow.v
			end

---------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------Ïðî÷àÿ ïîåáîòà-------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------

function sampGetPlayerIdByNickname(nick)
    local _, myid = sampGetPlayerIdByCharHandle(playerPed)
    if tostring(nick) == sampGetPlayerNickname(myid) then return myid end
    for i = 0, 1000 do if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == tostring(nick) then return i end end
end



------------------------------------------------------------------------------------------
----------------------------------------ÀÂÒÎÎÁÍÎÂËÅÍÈÅ------------------------------------
------------------------------------------------------------------------------------------


function autoupdate(json_url, prefix, url)
  local dlstatus = require('moonloader').download_status
  local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
  if doesFileExist(json) then os.remove(json) end
  downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage((prefix..'Îáíàðóæåíî îáíîâëåíèå. Ïûòàþñü îáíîâèòüñÿ c '..thisScript().version..' íà '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('Çàãðóæåíî %d èç %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('Çàãðóçêà îáíîâëåíèÿ çàâåðøåíà.')
                      sampAddChatMessage((prefix..'Îáíîâëåíèå çàâåðøåíî!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'Îáíîâëåíèå ïðîøëî íåóäà÷íî. Çàïóñêàþ óñòàðåâøóþ âåðñèþ..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': Îáíîâëåíèå íå òðåáóåòñÿ.')
            end
          end
        else
          print('v'..thisScript().version..': Íå ìîãó ïðîâåðèòü îáíîâëåíèå. Ñìèðèòåñü èëè ïðîâåðüòå ñàìîñòîÿòåëüíî íà '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end
