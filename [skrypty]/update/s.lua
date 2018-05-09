local classData = {}
classData.__index = classData 

function classData:main()
    self.version = "0.1"
    self.link = "https://raw.githubusercontent.com/Atroth95/Gamemode_RPG/8cbead0a/version"
    fetchRemote(self.link,function(responseData,errno)
        if errno == 0 then 
            outputChatBox(tostring(responseData))
            if tonumber(responseData) > tonumber(self.version) then 
                outputDebugString("Posiadasz nieaktualną wersję GM!")
            end 
        end 
    end)
end 

classData:main()