  script_name("SFA")
  script_name("SFA")
script_description("/SFA - Основная команда.")
script_version("3.5")
script_author("Rickot")
script_dependencies("SAMPFUNCS, SAMP")
--[[Билиотеки которые будут применяться  после local и перед =, это локальная переменная...
 которая обращается к функции брав нужную либу]]
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
--[[Энкодинг это грубо говоря перевод UTF8 в кирилицу (а как мы знаем utf8 это инглиш..)]]
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

jstart = 1 -- jstart это воспроизводная текста при запуске..

function main()
  	if not isSampLoaded() or not isSampfuncsLoaded() then return end
		autoupdate("https://www.dropbox.com/s/dpuix8w4m7qnub5/SFA.json?dl=0", '['..string.upper(thisScript().name)..']: ', "https://www.dropbox.com/s/dpuix8w4m7qnub5/SFA.json?dl=0")
	while not isSampAvailable() do wait(1000) end
--   checkUpdate()
    -- По принту можно понять что ниже проверка сервера
		print("Проверка сервера...")
    	if sampGetCurrentServerAddress() =="217.106.106.86" then
    		gameServer = "Western zm"
    		srv = 1
	--[[elseif это как if выше ток доп к однуму else и end]]	elseif sampGetCurrentServerAddress() == "217.106.106.86" then -- эт добавил шоб я мог его тестить
			gameServer = ""
			srv = 2
		else
			print("Сервер не допущен, работа скрипта завершена")
    		sampAddChatMessage("[SFA]{FFFFFF} К сожалению, данный скрипт недоступен для работы на данном сервере.", 0x046D63)
    		sampAddChatMessage("[SFA]{FFFFFF} Свяжитесь с разработчиком, если хотите уточнить возможность решения данной проблемы.", 0x046D63)
    		thisScript():unload()
    		return
    	end
    	print("Проверка пройдена, сервер: "..tostring(gameServer))

 if jstart == 1 then
    sampAddChatMessage("{ffffff}* [SFA{ffffff}]: {00BFFF}SFA для администрации Western ZM", -1)
    sampAddChatMessage("{ffffff}* [SFA{ffffff}]: {00BFFF}Скрипт успешно запущен. - [/sfa].", -1)
	sampAddChatMessage('{ffffff}* [SFA{ffffff}]: {00BFFF}Текущая версия: '..thisScript().version)
 elseif jstart == 2 then
    sampfuncsLog('{ffffff}* [{949055} SFA{ffffff}]: {949055}Текущая версия : '..thisScript().version)
  end
  --------------------------КОМАНДЫ--------------------------
sampRegisterChatCommand("sfa", window)
sampRegisterChatCommand("rt", rt)
sampRegisterChatCommand("nenaeb", nenaeb)
     ---------------------Ответы в репорту-------------------
sampRegisterChatCommand("da", otvetda) -- "da"
sampRegisterChatCommand("yes", yes) -- "да"
sampRegisterChatCommand("net", otvetnet) -- "нет"
sampRegisterChatCommand("no", no) -- "нет"
sampRegisterChatCommand("zm", zm) -- "игрок зомби"
sampRegisterChatCommand("pri", otvetpri) -- "приятной игры"
sampRegisterChatCommand("spect", otvetspect) -- "слежу"
sampRegisterChatCommand("s", s) -- "слежу"
sampRegisterChatCommand("google", google) -- "найдите эту информацию в интернете"
sampRegisterChatCommand("sorry", sorry) -- "приносим свои извинения за предоставленные неудобства"
sampRegisterChatCommand("infprest", otvetprest) -- информация о престиже
sampRegisterChatCommand("infcost", infcost) -- информация о цене предметов
sampRegisterChatCommand('infcaps', infcaps) -- информация о капсе
sampRegisterChatCommand("ukrit", otvetukrit) -- "в укрытие"
sampRegisterChatCommand("chist", otvetchist) -- "не заметил нарушений от игрока"
sampRegisterChatCommand("infroll", otvetinfrol) -- инфорция о рулетке
sampRegisterChatCommand("infclass", otvetinfclass) -- информация о классах
sampRegisterChatCommand("inftrade", inftrade) -- инфорция о трейдах
sampRegisterChatCommand("sekret", sekret) -- "не распространяем информацию"
sampRegisterChatCommand("infpvp2", infpvp2) -- "командная игра на пвп разрешена"
sampRegisterChatCommand("infpvp", infpvp) -- Это пвп карта, тут разрешено убивать выживших
sampRegisterChatCommand("predup", predup) -- "Предупредил игрока"
sampRegisterChatCommand("pred", pred) -- "Предупредил игрока"
sampRegisterChatCommand("forum", otvetforum) -- "напишите жалобу на форум"
sampRegisterChatCommand("tehforum", tehforum) -- "напишите в тех.раздел на форуме"
sampRegisterChatCommand("stopblock", stopblock) -- "прекратите блокировать укрытие"
sampRegisterChatCommand("tut", tut) -- "начинайте игру"
sampRegisterChatCommand("hz", otvethz) -- "не могу дать ответ на ваш вопрос"
sampRegisterChatCommand("nepon", otvetnepon) -- "непонял вашего вопроса"
sampRegisterChatCommand("nakazan", otvetnakazan) -- "игрок наказан"
sampRegisterChatCommand("pomog", otvetpomog) -- "помог вам"
sampRegisterChatCommand("prohod", prohod) -- "проходите карту"
sampRegisterChatCommand("stoptk", stoptk) -- "прекратите ТК"
sampRegisterChatCommand("stopofftop", stopofftop) -- "прекратите оффтоп в репорт"
sampRegisterChatCommand("stopzapret", stopzapret) -- "вы в запретном укрытии"
sampRegisterChatCommand("stoppom", stoppom) -- "прекратите помеху"
---------------------Наказания----------------------
sampRegisterChatCommand("cheat", cheat) -- чит
sampRegisterChatCommand("capsosk", capsosk) -- капс + оск.
sampRegisterChatCommand("osk", oskorbil) -- оскорбление игроков
sampRegisterChatCommand("admosk", adminaosknyl) -- оск. администрации
sampRegisterChatCommand("oskadm", oskadm) -- оск.администрации
sampRegisterChatCommand("capsoskadm", capsoskadm) -- капс + оск.адм
sampRegisterChatCommand("oskadmcaps", oskadmcaps) -- капс + оск.адм
sampRegisterChatCommand("caps", caps) -- капс
sampRegisterChatCommand("obman", obman) -- обман игроков
sampRegisterChatCommand("pomeha", pomeha) -- помеха
sampRegisterChatCommand("oskproject", oskproject) -- оск. проекта
sampRegisterChatCommand("oskprojectcaps", oskprojectcaps) -- оск. проекта + капс
sampRegisterChatCommand("capsoskproject", capsoskproject) -- оск. проекта + капс
sampRegisterChatCommand("upom", upominul) -- упоминание родных
sampRegisterChatCommand("mq", mq) -- упоминание родных
sampRegisterChatCommand("capsmq", capsmq) -- капс + упоминание родных
sampRegisterChatCommand("capsupom", capsupom) -- капс + упоминание родных
sampRegisterChatCommand("mqcaps", mqcaps) -- капс + упоминание родных
sampRegisterChatCommand("upomcaps", upomcaps) -- капс + упоминание родных
sampRegisterChatCommand("derz", derz) -- дерзкое отношение к адм
sampRegisterChatCommand("afk", heafk) -- афк без паузы
sampRegisterChatCommand("tks", tksurvive) -- тк выживший
sampRegisterChatCommand("tks2", tks2) -- варн за ТК 
sampRegisterChatCommand("upomproject", upomproject) -- упоминание сторонних проектов
sampRegisterChatCommand("tkz", tkzombie) -- тк зомби
sampRegisterChatCommand("bag", bag) -- багоюз
sampRegisterChatCommand("wafk", wafk) -- афк в бою
sampRegisterChatCommand("neproh", neproh) -- непрохождение карты
sampRegisterChatCommand("beg", begun) -- бег по карте
sampRegisterChatCommand("offtop", offtopinreport) -- оффтоп в репорт
sampRegisterChatCommand("udlin", dlinner) -- удлиннение сообщений
sampRegisterChatCommand("pust", pustoi) -- пустые сообщения
sampRegisterChatCommand("zapret", zapret) -- запретное укрытие
sampRegisterChatCommand("capsudlin", capsudlin) -- удлинение + капс
sampRegisterChatCommand("udlincaps", udlincaps) -- удлинение + капс
sampRegisterChatCommand("rz", rz) -- Выход рандом зм
sampRegisterChatCommand("teampvp", teampvp) -- тим на пвп
sampRegisterChatCommand("team", team) -- Командная игра зомби с выжившем --
resX, resY = getScreenResolution()
while true do wait(0)
    ------------- Имгуи процесс это рега окон имгуи..
imgui.Process = window1.v or window2.v or  mainwindow.v

    end
end

--------------------------------------------------------------------------------------------
----------------------------------------ОТВЕТЫ НА РЕПОРТ------------------------------------
--------------------------------------------------------------------------------------------

function otvetda(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Да.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Да". [/da id].', -1)
        end
    end
end

function yes(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Да.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Да". [/yes id].', -1)
        end
    end
end

    function otvetnet(param)
            id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Нет.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Нет". [/net id].', -1)
        end
    end
end

function no(param)
				id = tonumber(param)
if param then
		if id ~= nil then
								sampSendChat('/ans '..id..' Нет.')
						 else
				sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Нет". [/no id].', -1)
		end
end
end

function zm(param)
				id = tonumber(param)
if param then
		if id ~= nil then
								sampSendChat('/ans '..id..' Данный игрок является зомби.')
						 else
				sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Игрок зомби". [/zm id].', -1)
		end
end
end

function otvetpomog(param)
				id = tonumber(param)
if param then
		if id ~= nil then
								sampSendChat('/ans '..id..' Помог Вам. Приятной игры :) ')
						 else
				sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Помог Вам". [/pomog id].', -1)
		end
end
end

function otvetpri(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Приятной игры на Western ZM :)')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Приятной игры". [/pri id].', -1)
        end
    end
end

function otvethz(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' К сожалению, я не могу дать ответ на Ваш вопрос.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Не могу дать ответ на ваш вопрос". [/hz id].', -1)
        end
    end
end

function otvetnepon(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Не понял Вашего вопроса.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Не понял вашего вопроса". [/nepon id].', -1)
        end
    end
end

function stoptk(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Перестаньте наносить урон по своим союзникам, иначе Вы будете наказаны.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Прекратите ТК". [/stoptk id].', -1)
        end
    end
end

function stopzapret(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Вы находитесь в запретном укрытии. Покиньте его, иначе будете наказны.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Это запретное укрытие". [/stopzapret id].', -1)
        end
    end
end

function otvetnakazan(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Игрок наказан. Приятной игры :)')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Игрок наказан". [/nakazan id].', -1)
        end
    end
end

function inftrade(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' /sellthing id(Игрока) id(Предмета) цена - продать игроку...')
                    sampSendChat('/ans '..id..' /sellthing-продать серверу.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ на вопрос "как продать вещи?". [/inftrade id].', -1)
        end
    end
end

function otvetspect(param)
id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Работаю по Вашему репорту.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Работаю". [/spect id]', -1)
        end
    end
end

function s(param)
id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Работаю по Вашему репорту.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Работаю". [/s id]', -1)
        end
    end
end

function predup(param)
id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Предупредил игрока.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Предупредил игрока". [/predup id]', -1)
        end
    end
end

function pred(param)
id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Предупредил игрока.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Предупредил игрока". [/pred id]', -1)
        end
    end
end

function stoppom(param)
id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Не создавайте помеху игрокам.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Не создавайте помеху". [/stoppom id]', -1)
        end
    end
end

function infcost(param)
  id = tonumber(param)
  if param then
    if id ~= nil then
                    sampSendChat('/ans '..id..'  Цена предметов зависит от самих игроков.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Цена предметов зависит от игроков. [/infcost id]', -1)
        end
    end
end

function otvetukrit(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' У Вас есть 15 секунд, чтобы найти укрытие!')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "В укрытие". [/ukrit id]', -1)
						sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: {DC143C}На пвп картах бег разрешён!', -1)
        end
    end
end

function sekret(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Мы не распространяем эту информацию.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Не распространяем эту информацию". [/sekret id]', -1)
        end
    end
end

function sorry(param)
    id = tonumber(param)
    if param then
        if id ~= nil then
                    sampSendChat('/ans '..id..' Приносим свои извинения за предоставленные неудобства.')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Приносим свои извинения за предоставленные неудобства". [/sorry id]', -1)
        end
    end
end

function otvetchist(param)
  id = tonumber(param)
  if param then
    if id ~= nil then
    sampSendChat('/ans '..id..' Не заметил нарушений от данного игрока.')
   else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Нарушений не заметил". [/chist id]', -1)
      end
     end
end

function otvetinfclass(param)
	 id = tonumber(param)
	 if param then
		 if id ~= nil then
                sampSendChat('/ans '..id..' /info - Информация о классх. ')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ на вопрос по классам. [/infclass id]', -1)
        end
    end
end

function infpvp(param)
	 id = tonumber(param)
	 if param then
		 if id ~= nil then
                sampSendChat('/ans '..id..' Это карта типа "PVP", тут разрешено убивать выживших. ')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "На пвп разрешено убивать выживших" [/infpvp id]', -1)
        end
    end
end

function stopofftop(param)
	 id = tonumber(param)
	 if param then
		 if id ~= nil then
                sampSendChat('/ans '..id..' Не используйте репорт для общения. ')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Не используйте репорт для общения" [/stopofftop id]', -1)
        end
    end
end

function google(param)
	 id = tonumber(param)
	 if param then
		 if id ~= nil then
                sampSendChat('/ans '..id..' Попробуйте найти эту информацию в интернете. ')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Попробуйте найти эту информацию в интернете" [/google id]', -1)
        end
    end
end

function stopblock(param)
	 id = tonumber(param)
	 if param then
		 if id ~= nil then
                sampSendChat('/ans '..id..' Перестаньте блокировать укрытие, иначе Вы будете наказаны. ')
                 else
            sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Прекратите блокировать укрытие" [/stopblock id]', -1)
        end
    end
end

function otvetforum(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/ans '..id..' Напишите жалобу на форум forum-western-zm.ru .')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Жалобу на форум". [/forum id]', -1)
		end
    end
end

function tehforum(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/ans '..id..' Обратитесь в тех.раздел на форуме.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Обратитесь в тех.раздел на форуме". [/tehforum id]', -1)
		end
    end
end

function tut(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/ans '..id..' Вы тут? Начинайте игру, иначе Вы будете кикнуты.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Начинайте игру". [/tut id]', -1)
		end
    end
end

function prohod(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/ans '..id..' Проходите карту, иначе Вы будете кикнуты за непрохождение карты.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Ответ "Проходите карту". [/prohod id]', -1)
		end
    end
end

----------------------------------------------------------------------------------------
----------------------------------------КИКИ ИГРОКОВ------------------------------------
----------------------------------------------------------------------------------------

function heafk(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/kick '..id..' Афк без паузы (esc).')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Кикнуть за афк без паузы [/afk id]', -1)
		end
	end
end

function begun(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/kick '..id..' Бег по карте.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Кикнуть за бег по карте [/beg id]', -1)
		sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: {DC143C}На пвп картах бег разрешён!', -1)
		end
	end
end

function tksurvive(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/kick '..id..' ТК (Выживший).')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Кикнуть за тк (выживший) [/tks id]', -1)
		end
	end
end

function zapret(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/kick '..id..'  Запретное укрытие.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Кикнуть за тк (выживший) [/zapret id]', -1)
		end
	end
end

function pomeha(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/kick '..id..' Помеха.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Кикнуть за помеху [/pomeha id]', -1)
		end
	end
end

function neproh(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/kick '..id..' Непрохождение карты.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Кикнуть за непрохождение карты [/neproh id]', -1)
		end
	end
end

----------------------------------------------------------------------------------------
----------------------------------------ВЫДАЧА МУТОВ------------------------------------
----------------------------------------------------------------------------------------

function oskproject(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/mute '..id..' 60 Оскорбление проекта.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать мут за оск. проекта. [/oskproject id]', -1)
		end
    end
end

function capsoskproject(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/mute '..id..' 70 Оскорбление проекта + капс.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать мут за оск. проекта + капс [/capsoskproject id]', -1)
		end
    end
end

function oskprojectcaps(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/mute '..id..' 70 Оскорбление проекта + капс.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать мут за оск. проекта + капс [/oskprojectcaps id]', -1)
		end
    end
end

function caps(param)
	id = tonumber(param)
	if param then
		if id ~= nil then
			sampSendChat('/mute '..id..' 10 Caps.')
		else
				sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать мут за капс. [/caps id]', -1)
		end
	end
end

function upomproject(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/mute '..id..' 60 Упоминание сторонних проектов.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать мут за упоминание сторонних проектов. [/upomproject id]', -1)
		end
    end
end

function spam(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/mute '..id..' 30 Спам.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать мут за спам. [/spam id]', -1)
		end
    end
end

function obman(param)
	id = tonumber(param)
    if param then
        if id ~= nil then
				sampSendChat('/mute '..id..' 30 Обман игроков.')
								  		 else
			sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать мут за обман игроков. [/obman id]', -1)
		end
    end
end

function upominul(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 180 Упоминание родных.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать мут за упоминание родных [/upom id]', -1)
		end
	end
end

function mq(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 180 Упоминание родных.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать мут за упоминание родных [/mq id]', -1)
		end
	end
end

function capsmq(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 190 Упоминание родных + Капс.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать мут за упом. родных + Капс [/capsmq id]', -1)
		end
	end
end

function mqcaps(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 190 Упоминание родных + Капс.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать мут за упом. родных + Капс [/mqcaps id]', -1)
		end
	end
end

function capsupom(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 190 Упоминание родных + Капс.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать мут за упом. родных + Капс [/capsupom id]', -1)
		end
	end
end

function upomcaps(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 190 Упоминание родных + Капс.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать мут за упом. родных + Капс [/upomcaps id]', -1)
		end
	end
end

function offtopinreport(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 10 Оффтоп в репорт. ')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Дать мут за оффтоп в репорт [/offtop id]', -1)
		end
	end
end

function oskorbil(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 30 Оскорбление игроков')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Дать мут за оск. игроков [/osk id]', -1)
		end
	end
end

function capsosk(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 40 Оск. игроков + Капс.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Дать мут за капс + оск. [/capsosk id]', -1)
		end
	end
end

function adminaosknyl(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 60 Оскорбление администрации.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Дать мут за оскорбление Администрации [/admosk id]', -1)
		end
	end
end

function oskadm(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 60 Оскорбление администрации.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Дать мут за оскорбление Администрации [/oskadm id]', -1)
		end
	end
end

function capsoskadm(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 70 Оск.администрации + капс.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Дать мут за оск. адм. + капс [/capsoskadm id]', -1)
		end
	end
end

function oskadmcaps(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 70 Оск.администрации + капс.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Дать мут за оск. адм. + капс [/oskadmcaps id]', -1)
		end
	end
end

function pustoi(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/mute '..id..' 20 Пустые сообщения.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Дать мут за пустые сообщения [/pust id]', -1)
		end
	end
end

----------------------------------------------------------------------------------------
----------------------------------------ВЫДАЧА ВАРНОВ------------------------------------
----------------------------------------------------------------------------------------

function bag(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/warn '..id..' Багоюз.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать варн за багоюз [/bag id]', -1)
		end
	end
end

function tkzombie(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/warn '..id..' ТК (Зомби).')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать варн за ТК (зомби) [/tkz id]', -1)
		end
	end
end

function tks2(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/warn '..id..' ТК .')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать варн за ТК [/tks2 id]', -1)
		end
	end
end

function team(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/warn '..id..' Командная игра зомби с выжившим .')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать варн за совместную игру зомби с выжившем [/team id]', -1)
		end
	end
end

function wafk(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/warn '..id..' Афк в бою')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать варн за афк в бою [/wafk id]', -1)
		end
	end
end

function rz(param)
nick = tostring(param)
if param then
    if nick ~= nil then
        sampSendChat('/offwarn '..nick..' Выход Р.З')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать варн за выход Р.З [/rz nick]', -1)
		end
	end
end

function teampvp(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/warn '..id..' Командная игра на PVP')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать варн за командную игру на PVP [/teampvp id]', -1)
		end
	end
end

----------------------------------------------------------------------------------------
----------------------------------------ВЫДАЧА БАНОВ------------------------------------
----------------------------------------------------------------------------------------

function cheat(param)
id = tonumber(param)
if param then
    if id ~= nil then
        sampSendChat('/ban '..id..' 30 Чит.')
		else
    sampAddChatMessage('{ffffff}* [{0088ff}SFA{ffffff}]: Выдать бан за использование читов [/cheat id]', -1)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------ОСТАЛЬНОЕ---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

function rt(param)
lua_thread.create(function()
if param then
sampSendChat('/msg Заметили читера? Есть вопросы по игровому процессу?')
wait(500)
sampSendChat('/msg Администрация сервера всегда готова помочь Вам [/report]')
else
end
end)
end

function ob(param)
lua_thread.create(function()
if param then
sampSendChat('/msg Уважаемые игроки!')
wait(500)
sampSendChat('/msg для проведения безопасных обменов предметами и аренды без риска.')
wait(500)
sampSendChat('/msg Ознакомьтесь с темой "Обмен/аренда предметов" в разделе Amazing ZM.')
wait(500)
sampSendChat('/msg Наш форум [ forum.amazing-zm.ru ]')
else
end
end)
end

function nenaeb(param)
lua_thread.create(function()
if param then
sampSendChat('/msg Уважаемые игроки!')
wait(500)
sampSendChat('/msg Проверяйте данные трейда перед принятием предложения!')
wait(500)
sampSendChat('/msg Зачастую происходят обманы, виной которых только Ваша невнимательность!')
wait(500)
sampSendChat('/msg Никогда не спешите завершать сделку!')
else
end
end)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------MENU--------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
function apply_custom_style() --[[имгуи стиль.. стоит андровира, но можно
    поставить и другую.. НО часто их выкладывают в C++ тобишь надо будет перевести в lua (это изи)]]
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
imgui.Begin(u8'Главное меню |SFA| .', mainwindow, img_state) --imgui.WindowFlags.NoResize)
		imgui.BeginChild('#MM', imgui.ImVec2(720,500), true)
		local nakaz = [[Блокировка чата:
• /offtop - Оффтоп в репорт.
• /osk - Оскорбление игроков.
• /admosk - Оскорбление администрации.
• /capsoskadm, /oskadmcaps - Оск. администрации + капс.
• /oskproject - Оскорбление проекта.
• /oskprojectcaps, /capsoskproject - Окс. проекта + капс.
• /upom, /mq - Упоминание родных.
• /capsmq, /mqcaps - Упоминание родных + капс.
• /capsupom, upomcaps - Упоминание родных + капс.
• /pust - Пустые сообщения.
• /caps - Капс.
• /capsosk - Капс + оск.
• /upomproject - Упоминание сторонних проектов.
• /obman - Обман игроков.

Кик игрока:
• /tks - Team Kill (Выживший/Survivor).
• /neproh - Непрохождение карты.
• /beg - Бег по карте.
• /afk - Афк без паузы.
• /pomeha - Помеха.
• /zapret - Запретная нычка.

Предупреждения:
• /bag - Багоюз.
• /wafk - Афк в бою.
• /tkz - Team Kill (Зомби/Zombie).
• /tks2 - ТК выживших
• /team - Выдать варн за совместную игру зомби с выжившем
• /rz - Выдать варн за выход Р.З
• /teampvp - Выдать варн за командную игру на PVP


Блокировка аккаунта:
• /cheat - Использование читов]]
		imgui.Text(u8(nakaz))
		imgui.Text('---------------------------------------------------------------')
local otv = [[Ответы по репорту:
• /da, /yes -  Да.
• /net, /no -   Нет.
• /zm - Данный игрок является зомби.
• /hz - Не могу ответить на ваш вопрос.
• /nepon - Не понял вашего вопроса.
• /pri -   Приятной игры :)
• /pomog - Помог Вам.
• /predup, /pred - Предупредил игрока.
• /spect, /s -   Работаю по Вашей жалобе.
• /nakazan - Игрок наказан.
• /chist -   Не наблюдаю нарушений от данного игрока.
• /stoptk - Прекратите ТК.
• /sekret - Не распространяем эту информацию.
• /ukrit -   Бегите скорее в укрытие.
• /prohod - Проходите карту.
• /tut - Начинайте игру.
• /forum -   Напишите жалобу на форум.
• /prest -   Для получения престижа.
• /infclass -    Подробная инфорция о классах.
• /inftrade - Ответ на вопрос "Как продать вещи?"
• /infcost - Цена предметов зависит от игроков.
• /infpvp - На пвп карте разрешено убивать выживших
• /stopblock - Прекратите блокировать укрытие.
• /stopofftop - Не используйте репорт для общения.
• /stopzapret - Вы находитесь в запретном укрытии.
• /tehforum - Обратитесь в тех.раздел на форуме
• /google - Найдите эту информацию в интернете
• /sorry - Приносим свои извинения за предоставленные неудобства
•

Другое:
• /rt - Написать в общий чат о репорте.
• /nenaeb - Написать в общий чат о внимательности при трейдах.
]]
	imgui.Text(u8(otv))

  imgui.EndChild()
  imgui.End()
end
end
end

			function window() -- функция вызова главного окна..
			mainwindow.v = not mainwindow.v
			end

---------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------Прочая поебота-------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------

function sampGetPlayerIdByNickname(nick)
    local _, myid = sampGetPlayerIdByCharHandle(playerPed)
    if tostring(nick) == sampGetPlayerNickname(myid) then return myid end
    for i = 0, 1000 do if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == tostring(nick) then return i end end
end



------------------------------------------------------------------------------------------
----------------------------------------АВТООБНОВЛЕНИЕ------------------------------------
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
                sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('Загружено %d из %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('Загрузка обновления завершена.')
                      sampAddChatMessage((prefix..'Обновление завершено!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': Обновление не требуется.')
            end
          end
        else
          print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end
