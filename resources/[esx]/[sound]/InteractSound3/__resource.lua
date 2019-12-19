
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
	'client/html/sounds/3rd-prototype-feel-so-good-ncs-release.mp3',
	'client/html/sounds/diamond-eyes-flutter-ncs-release.mp3',
	'client/html/sounds/diamond-eyes-hold-on-ncs-release.mp3',
	'client/html/sounds/focus-fire-mirage-ncs-release.mp3',
	'client/html/sounds/jpb-all-stops-now-feat-soundr-ncs-release.mp3',
	'client/html/sounds/lost-sky-dreams-ncs-release.mp3',
	'client/html/sounds/lost-sky-dreams-pt-ii-feat-sara-skinner-ncs-release.mp3',
	'client/html/sounds/niviro-dancin-ncs-surround-release.mp3',
	'client/html/sounds/raven-kreyn-muffin-ncs-release.mp3',
	'client/html/sounds/robin-hustin-x-tobimorrow-light-it-up-feat-jex-ncs-release.mp3',
	'client/html/sounds/showdown-freedom-feat-iman-ncs-release.mp3',
	'client/html/sounds/subtact-want-you-feat-sara-skinner-ncs-release.mp3',
	'client/html/sounds/weero-mitte-our-dive-ncs-release.mp3',
	'client/html/sounds/wide-awake-something-more-ncs-release.mp3',
})
