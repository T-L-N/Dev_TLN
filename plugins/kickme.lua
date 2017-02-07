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
--]]
do
local function run(msg, matches) 
if matches[1] == 'اطردني' then 
local hash = 'kick:'..msg.to.id..':'..msg.from.id 
     redis:set(hash, "waite") 
      return 'عزيزي ❗️ ('..msg.from.username..')\nهل انت متاكد من الخروج من المجموعة ارسل (نعم)✔️ لكي تخرج من المجموعة ان لم تكن متأكد من الخروج ارسل (لا) ✖️' 
    end 

    if msg.text then 
   local hash = 'kick:'..msg.to.id..':'..msg.from.id 
      if msg.text:match("^نعم$") and redis:get(hash) == "waite" then 
     redis:set(hash, "ok") 
   elseif msg.text:match("^لا$") and redis:get(hash) == "waite" then 
  send_large_msg(get_receiver(msg), "رح ابقيك 🌝👋 بس لتعيده بعد ما متشاقي وياك 😪🍆") 
     redis:del(hash, true) 

      end 
    end 
   local hash = 'kick:'..msg.to.id..':'..msg.from.id 
    if redis:get(hash) then 
        if redis:get(hash) == "ok" then 
         channel_kick("channel#id"..msg.to.id, "user#id"..msg.from.id, ok_cb, false) 
          return 'تم طردك يا خره لا ترجع بعد ('..msg.to.title..')⚠️' 
        end 
      end 
    end 

return { 
  patterns = { 
  "اطردني", 
  "^نعم$", 
  "^لا$" 
  }, 
  run = run, 
}
end