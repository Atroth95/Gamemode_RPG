local classData = {}
classData.__index = classData 

function classData:start () 
    local database = {
        dbname = 'atroth_gm',
        host = 'localhost',
        dbuser = 'root',
        pass = '',
    } 
    setmetatable(database, { __index = classData } )
    return database 
end     

function classData:connect () 
    local DB = classData:start()
    self.sql = Connection ("mysql",'dbname=' ..DB.dbname.. ';host=' ..DB.host,DB.dbuser,DB.pass,"share=1")
    if self.sql then 
        outputDebugString("Pomyślnie połączono z bazą danych.")
        classData:dbQ ("SET NAMES utf8;")
    else 
        outputDebugString("Nie udane połączenie z bazą danych!")
        local resource = getThisResource ()
        resource:stop ()
    end 
end 

function classData:dbGetRows (...)
    local h = self.sql:query(...)
    if not h then return nil end 
    local rows = h:poll(-1)
    if not rows then return nil end 
    return rows 
end 

function classData:dbUpdate (...)
    return self.sql:exec(...)
end 

function classData:dbQ (...)
    local h = self.sql:query (...)
    local result,numrows,last_id = h:poll(-1)
    return numrows 
end 

function classData:main ()
    classData:start () 
    classData:connect ()
    self.connectFunc = function () self:connect () end 
    setTimer(self.connectFunc,3600*1000,0)
end 

classData:main ()
--_G[r and "removeEventHandler" or "addEventHandler"]("onClientRender", root, funkcja)