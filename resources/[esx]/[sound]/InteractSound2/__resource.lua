
------
-- InteractSound by Scott
-- Verstion: v0.0.1
------

-- Manifest Version
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Client Scripts
client_script 'client/main.lua'

-- Server Scripts
server_script 'server/main.lua'

-- NUI Default Page
ui_page('client/html/index.html')

-- Files needed for NUI
-- DON'T FORGET TO ADD THE SOUND FILES TO THIS!
files({
    'client/html/index.html',
    -- Begin Sound Files Here...
    'client/html/sounds/haut.ogg',
    'client/html/sounds/pants.ogg',
    'client/html/sounds/depecage.ogg',
    'client/html/sounds/radio_end_transmission.ogg',
    'client/html/sounds/radio_enter_transmission.ogg',
    'client/html/sounds/radio_no_battery.ogg',
    'client/html/sounds/radio_noise_effect.ogg',
    'client/html/sounds/radio_on.ogg',
    'client/html/sounds/Wiz_Khalifa_-_See_You_Again_ft._Charlie_Puth_Official_Video_Furious_7_Soundtrack-convertirvideo.com.ogg'
})
