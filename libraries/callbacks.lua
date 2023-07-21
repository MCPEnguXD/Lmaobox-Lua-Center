--[[
  Q: Why?:
  A: To simplify the process of registering callbacks, and to make it easier to unregister them.
     The library will automatically unregister all callbacks when the script is unloaded.
     Library also has a debug mode ( defaulted to true ) which will print out when a callback is registered or unregistered.

  Q: How?
  A: 
  ```
  local callbacks = require( 'libraries/callbacks' )
  callbacks.add( e_callbacks.PAINT, cool_paint_function )
  ```
]]

--! Paste this table into your script to use it
local e_callbacks = {
    PAINT = 'Draw',
    PAINT_MODEL = 'DrawModel',
    CREATE_MOVE = 'CreateMove',
    FIRE_GAME_EVENT = 'FireGameEvent',
    DISPATCH_USER_MESSAGE = 'DispatchUserMessage',
    SEND_STRING_CMD = 'SendStringCmd',
    POST_PROP_UPDATE = 'PostPropUpdate',
    SERVER_CMD_KEY_VALUES = 'ServerCmdKeyValues',
    ON_FAKE_UNCRATE = 'OnFakeUncrate',
    ON_LOBBY_UPDATED = 'OnLobbyUpdated',
    SET_RICH_PRESENCE = 'SetRichPresence',
    UNLOAD = 'Unload'
}

function table.soft_contains( table, value )
    for _, v in pairs( table ) do
        print( v, value )
        if v == value then
            return true
        end
    end

    return false
end

local native_callbacks = callbacks
local callbacks = { uniques = 0, id_to_callback_name = { }, debug = true }

function callbacks.add( e_callback, fn_callback )
    if table.soft_contains( e_callbacks, e_callback ) then
        --error( 'Invalid callback type: ' .. e_callback )
        return
    end

    local id = callbacks.uniques + 1
    callbacks.uniques = id

    table.insert( callbacks.id_to_callback_name, e_callback )
    
    native_callbacks.Register( e_callback, tostring( id ), function( ... )
        local args = { ... }
        local status, err = pcall( fn_callback, table.unpack( args ) )
        if not status then
            error( err )
        end
    end )

    if callbacks.debug then
        print( ( 'Registered callback #%i (%s)' ):format( id, e_callback ) )
    end
end
function callbacks.clean( )
    for i = 1, callbacks.uniques do
        native_callbacks.Unregister( tostring( i ) )

        if callbacks.debug then
            print( ( 'Unregistered callback #%i (%s)' ):format( i, callbacks.id_to_callback_name[ i ] ) )
        end
    end
end

native_callbacks.Register( e_callbacks.UNLOAD, function( )
    callbacks.clean( )
end )

return callbacks
