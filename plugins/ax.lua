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
local function run(msg, matches) 
 if is_sudo(msg) then 
   return " اهلا عزيزي المطور 😻 ايديك هو 🆔  : "..msg.from.id 
 end 
 if is_owner(msg) then 
   return " اهلاً عزيزي مالك الكروب🙂 ايديك هو 🆔  : "..msg.from.id 
 end 
 if is_momod(msg) then 
   return " اهلا عزيزي الادمن 😊 ايديك هو 🆔  "..msg.from.id 
 end 
 if not is_momod(msg) then 
   return " اهلا عزيزي العضو 😐 ايديك هو 🆔  : "..msg.from.id 
 end 
end 

return { 
 patterns = { 
   "^[!/#](ايدي)$" 
 }, 
 run = run, 
} 

end


