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

do
    
local function  
karar(msg,matches)
    if matches[1] == "chat_add_user"  then 
      return " نِـــــوِرتّ أّلَــګـروِبِ حٌيّـــأّتّــيِّ😻👋️\n".." أّّســمَ أّلَمَـــمَـجِـمَـوِعٌـةّ 😴🍸:: "..msg.to.title.."\n".." أّيِّـــدِيِّ أّلَــــمَــجِـمَـــوِعٌــةّ ⬅️:: "..msg.to.id.."\n".." أّّســمَ أّلَــحٌبِــأّبِ أّلَــيِّ ظّــــأّفِّـــــګ 😈 ::"..(msg.from.first_name or " ").."\n".." مَــــعٌرفِّ أّلَـــحٌــبِـأّبِ أّلَــيِّ ضّــأّفِّـــګ ⬅️@"..(msg.from.username or " ").."\n".." مَـــعٌــرفِّــګ حٌــيِّــأّتّـــيِّ !😍❤️:: @"..(msg.action.user.username or "لايوجد " ).."\n".." أّيِّــدِيِّ أّلَـــحٌــبِــأّبِ أّلَـــيِّ ضّـــأّفِّـــګ::"..msg.from.id

    elseif matches[1] == "chat_add_user_link" then
      return " نِـــــوِرتّ أّلَــګـروِبِ حٌيّـــأّتّــيِّ😻👋\n".." أّّســمَ أّلَمَـــمَـجِـمَـوِعٌـةّ 😴🍸:: "..msg.to.title.."\n".." أّيِّـــدِيِّ أّلَــــمَــجِـمَـــوِعٌــةّ ⬅️:: "..msg.to.id.."\n".." أّّســمَ أّلَــحٌبِــأّبِ أّلَــيِّ ظّــــأّفِّـــــګ 😈:: "..(msg.from.first_name or " ").."\n".." مَــــعٌرفِّ أّلَـــحٌــبِـأّبِ أّلَــيِّ ضّــأّفِّـــګ ⬅️::@"..(msg.from.username or " ").."\n".." مَـــعٌــرفِّــګ حٌــيِّــأّتّـــيِّ !😍🍸:: @"..(msg.from.username or "لايوجد " ).."\n".." ايديك ::"..msg.from.id

    end
    if matches[1] == "chat_del_user" then
    return " توصل بسلامة تريلة بلا رقم 😐🍸🚶"..msg.action.user.first_name
end
end
return {
    patterns = {
        "^!!tgservice (chat_add_user)$",
        "^!!tgservice (chat_add_user_link)$",
        "^!!tgservice (chat_del_user)$"
       
    },
 run = karar,
}
end
