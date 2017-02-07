--[[ 
 _____   _       _   _     
|_   _| | |     | \ | |    
  | |   | |     |  \| |    
  | |   | |___  | |\  |    
  |_|   |_____| |_| \_|    
Dev @Aaa1R
Dev @llN00Nll
Dev @liknil
Dev @x_I_10_I_x
--]]
local function pre_process(msg) 
  local jalal = msg['id']
  local user = msg.from.id
  local chat = msg.to.id
  local hash = 'mate:'..chat..':'..user
  if msg.fwd_from and not is_momod(msg) then
    if redis:get(hash) and msg.fwd_from and not is_momod(msg) then 
      delete_msg(msg.id, ok_cb, false) 
      delete_msg(msg.id, ok_cb, false) 
      delete_msg(msg.id, ok_cb, false) 
      send_large_msg(get_receiver(msg), ' #تـنبيـﮫ 📢💢 ﻣﮨﻣﮨﻧـوع ﻋـﻣﮨل اﻋﮩآﺩة اﻟـتوﺟـﯿـﮫ دًۣاٍۧخـﮨڶ الـمجـﮩﻣﮨوﻋـﮫ 💬☑️\n#User @'..msg.from.username)
      redis:del(hash) 
   else
      delete_msg(msg.id, ok_cb, false) 
      redis:set(hash, true)
    end
  end
  return  msg
end
       

local function run(msg, matches) 
  local jalal = msg['id'] 
  if matches[1] == 'close fwd' then
    if is_momod(msg) then 
      local hash = 'mate:'..msg.to.id 
      redis:set(hash, true) 
         local x = "تم ✅ تفعيل تنبيه وقفل اعادة التوجيه 🔷✔️"
      reply_msg(jalal, x, ok_cb, true) 
    else 
      local asdy = 'هاذ الامر للمشرفين #فقط❗️⛔️' 
      reply_msg(jalal, asdy, ok_cb, true) 
    end
  end
  if matches[1] == 'open fwd' then
    if is_momod(msg) then 
      local hash = 'mate:'..msg.to.id 
      redis:del(hash) 
    local don = "تم ✅ الغاء تفعيل وقفل تنبيه اعادة التوجيه 🔷✔️"
      reply_msg(karar, don, ok_cb, true) 
    else
      local jalal_aldon = 'هاذ الامر للمشرفين #فقط❗️⛔️' 
      reply_msg(karar,   karar_TLN, ok_cb, true) 
    end 
  end 
end
return { 
    patterns = {
"^(قفل اعاده توجيه)$",
"^(فتح اعاده توجيه)$",
"^[#!/](قفل اعاده توجيه)$",
"^[#!/](فتح اعاده توجيه)$"
    }, 
     
run = run, 
    pre_process = pre_process 
}