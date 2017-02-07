--[[ 
 _____   _       _   _     
|_   _| | |     | \ | |    
  | |   | |     |  \| |    
  | |   | |___  | |\  |    
  |_|   |_____| |_| \_|    
Dev @Aaa1R (علي_دراكون)
Dev @llN00Nll (نظوري_الرئاسه)
Dev @liknil (كرار_ابن_الرئاسه)
Dev @x_I_10_I_x (انور_فايدر)
—]]
do 

local function Memo(msg, matches) 
if is_sudo(msg) then 
        local text = "آنہٰت بطہٰوري وتآجہٰرآسہٰي 🐸💋 ".."\n".."🆔 - ايديك : "..msg.from.id.."\n".."📝 - اسمك : "..msg.from.first_name.."\n".." معرفك ↩️👲🏻  : @"..msg.from.username.."\n"..'📱 - رقمك 😜🙈 : '..(msg.from.phone or "لُايَوَجْدِ ⛔️‼️")
        return reply_msg(msg.id, text, ok_cb, false) 
     end 
if is_owner(msg) then 
        local text = "آنہٰہٰت حبہٰيہٰب مہٰطہٰوري آلمہٰديہٰر 🙊💋 ".."\n".."🆔 - ايديك : "..msg.from.id.."\n".."📝 - اسمك : "..msg.from.first_name.."\n".." معرفك ↩️👲🏻  : @"..msg.from.username.."\n"..'📱 - رقمك 😜🙈 : '..(msg.from.phone or "لُايَوَجْدِ ⛔️‼️")
        return reply_msg(msg.id, text, ok_cb, false) 
     end 
if is_momod(msg) then 
        local text = "آنہٰت آدمہٰن آلہٰكہٰروب مہٰن بعہٰد المہٰديہٰر 😹🌚 ".."\n".."🆔 - ايديك : "..msg.from.id.."\n".."📝 - اسمك : "..msg.from.first_name.."\n".." معرفك ↩️👲🏻  : @"..msg.from.username.."\n"..'📱 - رقمك 😜🙈 : '..(msg.from.phone or "لُايَوَجْدِ ⛔️‼️")
        return reply_msg(msg.id, text, ok_cb, false) 
     end 
if not is_momod(msg) then 
        local text = "آنہٰت عہٰضہٰو لٱ تقہٰدم ولا تئخہٰر الله الله الله وياك ☹️😹 ".."\n".."🆔 - ايديك : "..msg.from.id.."\n".."📝 - اسمك : "..msg.from.first_name.."\n".." معرفك ↩️👲🏻  : @"..msg.from.username.."\n"..'📱 - رقمك 😜🙈 : '..(msg.from.phone or "لُايَوَجْدِ ⛔️‼️")
        return reply_msg(msg.id, text, ok_cb, false) 
     end 
     end 

return { 
  patterns = { 
       "^(موقعي)$", 
       "^(شنو اني)$",
  }, 
  run = Memo, 
} 

end 

-- BY Dev -alidragon @Aaa1R 
