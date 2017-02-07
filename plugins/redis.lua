--[[ 
-By @Aaa1R
—By @x_I_10_I_x 
—By @llN00Nll 
—By @liknil 
—ch> @Dev_TLN 
do--]]
do 
function run(msg, matches) 
  if matches[1] == "رست" and is_sudo(msg) then 
    return os.execute("./launch.sh"):read('*all') 
  elseif matches[1] == "حدث" and is_sudo(msg) then 
     return io.popen("git pull"):read('*all') 
  elseif  matches[1] == "ريديس" and is_sudo(msg) then 
    return io.popen("redis-server"):read('*all') 
  end 
end 
return { 
  patterns = { 
    "^(رست)", 
    "^(حدث)", 
    "^(ريديس)" 
  }, 
  run = run 
} 
end 
-- by dev:By aliadragon