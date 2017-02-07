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
local function run(msg, matches)
    if is_momod(msg) then
        return
    end
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
            if data[tostring(msg.to.id)]['settings']['lock_ads'] then
                lock_ads = data[tostring(msg.to.id)]['settings']['lock_ads']
            end
        end
    end
    local chat = get_receiver(msg)
    local user = "user#id"..msg.from.id
    if lock_ads == "yes" then
       delete_msg(msg.id, ok_cb, true)
    end
end

return {patterns = {
"[Hh][Tt][Tt][Pp][Ss]://[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/",
"[Hh][Tt][Tt][Pp][Ss]://[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]",
"[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/",
"[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/",
"[Hh][Tt][Tt][Pp]://",
"[Ww][Ww][Ww]:",
"telegram.me/(.*)",
"TELEGRAM.ME/(.*)",
"Telegram.me/(.*)",
"(.*) telegram.me/(.*)",
"(.*) https://(.*)",
"(.*) www.(.*)",
"(.*) telegram.me/(.*)",
"(.*) https://(.*)",
"(.*) www.(.*)";
"https://(.*)",
"http://(.*)",
"www.(.*)",
"WWW.(.*)",

  },
  run = run
}
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