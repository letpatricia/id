idsystem = {
    servername = 'Police Pursuit',
    debug = true,
    ids = {},

    _join = function(self)
        for i = 1, 5000 do
            if (self.ids[i] == nil) then
                slot = i
                break
            end
        end
        local player = source
        local userID = exports.script:steamID(player)

        --[[ 
            @define
            defines player slotnumber.
        ]]
        self.ids[slot] = player
        exports.script:setData(userID, 'playerid', slot)

        --[[ 
            @change
            changes player name on join
        ]]
        if self.debug then
            print('[IDENTITY-INFO]: Yeni giren oyuncu ID: '..slot)
        end
    end,

    _quit = function(self)
        local player = source
        local userID = exports.script:steamID(player)
        local data = exports.script:getData(userID, 'playerid')
        if data then
            if self.debug then
                print('[IDENTITY-INFO]: Çıkan oyuncu ID: '..data)
            end
            self.ids[tonumber(data)] = nil
        end
    end,

    _define = function(self)
        self.players = GetPlayers()
        local player = source

        for key, value in ipairs(self.players) do
            self.ids[key] = value
            local userID = exports.script:steamID(value)
            exports.script:setData(userID, 'playerid', key)

            if self.debug then
                print('[IDENTITY-INFO]: Tanımlanan oyuncu ID: '..key)
            end
        end
    end,
}

idsystem:_define()

AddEventHandler("playerConnecting", function() idsystem:_join() end)
AddEventHandler("playerDropped", function() idsystem:_quit() end)