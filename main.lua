
local composer = require("composer")
weightMin = 40
weightMax = 140
weight = 90

ageMin = 16
ageMax = 60
age = 38
sex = "man"

timeMin = 30
timeMax = 240
time = 135

heightMin = 140
heightMax = 200
height = 170

activity_name = "Ходьба, 4км/ч"
activity_factor = 3
activity_index = 147

w = display.contentWidth - 40
display.setDefault("background", 0.1)
display.setDefault("fillColor", 0/255, 148/255, 255/255)
composer.gotoScene("scenes.calc")
