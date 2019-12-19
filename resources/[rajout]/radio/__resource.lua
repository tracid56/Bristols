resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

-- Example custom radios
supersede_radio "RADIO_01_CLASS_ROCK" { url = "https://liveyourlife06.000webhostapp.com/Juicy%20J,%20Wiz%20Khalifa,%20Ty%20Dolla%20$ign%20-%20Shell%20Shocked%20ft.%20Kill%20The%20Noise%20&%20Madsonik%20[Official%20Video].ogg", volume = 0.2, name = "Juicy J, Wiz Khalifa, Ty Dolla $ign - Shell Shocked ft. Kill The Noise & Madsonik [Official Video]" }
supersede_radio "RADIO_02_POP" { url = "https://liveyourlife06.000webhostapp.com/Krewella%20-%20Alibi%20(Lyrics).ogg", volume = 0.2, name = "Krewella - Alibi (Lyrics)" }
supersede_radio "RADIO_03_HIPHOP_NEW" { url = "https://liveyourlife06.000webhostapp.com/Still%20Fresh%20feat.%20Haristone%20-%20Elle%20m'a%20dit%20(Clip%20Officiel).ogg", volume = 0.2, name = "Still Fresh feat. Haristone - Elle m'a dit (Clip Officiel)" }
supersede_radio "RADIO_04_PUNK" { url = "https://liveyourlife06.000webhostapp.com/XXXTENTACION-%20CHANGES%20(Johnny%20Orlando%20Cover).ogg", volume = 0.2, name = "XXXTENTACION- CHANGES (Johnny Orlando Cover)" }
supersede_radio "RADIO_05_TALK_01" { url = "https://liveyourlife06.000webhostapp.com/NCS_%20Colors%20[Full%20Album%20Mix].ogg", volume = 0.2, name = "NCS_ Colors [Full Album Mix]" }
supersede_radio "RADIO_06_COUNTRY" { url = "https://liveyourlife06.000webhostapp.com/Booba-Futur-2.0-Album-complet-.ogg", volume = 0.2, name = "Booba-Futur-2 Album" }
supersede_radio "RADIO_07_DANCE_01" { url = "https://liveyourlife06.000webhostapp.com/RimK%20-%20Air%20Max%20ft.%20Ninho.ogg", volume = 0.2, name = "RimK Air Max Ninho" }

files {
	"index.html"
}

ui_page "index.html"

client_scripts {
	"data.js",
	"client.js"
}
