--[[ 
▀▄ ▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▀▄▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀          
▀▄ ▄▀                                      ▀▄ ▄▀ 
▀▄ ▄▀    BY ali dragon                     ▀▄ ▄▀ 
▀▄ ▄▀     BY ali dragon (@Aaa1R)           ▀▄ ▄▀ 
▀▄ ▄▀     ChannelDev       (@Ch_dev)       ▀▄ ▄▀ 
▀▄ ▄▀ Making the file by :ali dragon       ▀▄ ▄▀   
▀▄ ▄▀          info  :   معلوماتي             ▀▄ ▄▀ 
▀▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄▀▄▄▀▀
—]]
do 
local function run(msg,matches) 
if matches[1]== "info" then 
  local text = "Hi my love☺️🌹".."\n"
.."⚔🔸🔹🔸🔹🔸🔹🔸🔹🔹🔸⚔".."\n"
.."name»" ..msg.from.first_name.."\n"
.."user» @"..(msg.from.username or ' ').."\n"
.."phone»" ..(msg.from.phone or ' ').."\n"
.."ID»" ..msg.from.id.."\n"
.."GP ID»" ..(msg.to.id or ' ').."\n"
.."GP name»" ..(msg.to.title or ' ').."\n"
.."TIME»" ..os.date('%B, %d, %Y\n', timestamp)
.."🐱🔸🔹🔸🔹🔸🔹🔸🔹🔹🔸🐱".."\n"
return text
 end 
 if matches[1]== "معلوماتي" then
   local text = "Hi my love☺️🌹".."\n"
.."🐱🔹🔸🔹🔸🔹🔸🔹🔹🐱".."\n"
.."آسہٰــمــہٰڪ 💋🌝" ..msg.from.first_name.."\n"
.."مــعـہٰـرفــہٰڪ🙊❤️@"..(msg.from.username or ' ').."\n"
.."ݛقـہٰـمـہٰـڪ🐸🕸" ..(msg.from.phone or ' ').."\n"
.."آيـہٰـديـہٰـڪ😌🌸" ..msg.from.id.."\n"
.."آيـہٰـدي آلمـہٰـجـہٰـموعہٰۿﮧ🌚🐲" ..(msg.to.id or ' ').."\n"
.."آسـہٰـم آلمـہٰـجـہٰـموعہٰۿﮧ🌞🐬" ..(msg.to.title or ' ').."\n"
.."آڶتہٰآݛيـہٰـہٰخخ😳🌹" ..os.date('%B, %d, %Y\n', timestamp)
.."⚔➖➖➖➖➖➖➖➖⚔".."\n"
return text
end
end 
  return  { 
    patterns = { 
      "^[!/#](info)$",
      "^(معلوماتي)$",
}, 
  run = run
} 
end
-- By Dev alidragon (@Aaa1R)
