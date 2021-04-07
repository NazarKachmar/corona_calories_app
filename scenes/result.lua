local composer = require("composer")
local scene = composer.newScene();
local widget = require("widget")
local json = require("json")


function scene:create(event)
  local sceneGroup = self.view
  display.newRect(sceneGroup, display.contentCenterX,
  display.contentCenterY, display.contentWidth,
  display.contentHeight):setFillColor(0/255, 148/255, 255/255, 0.5)
  display.newRoundedRect(sceneGroup,display.contentCenterX, 490,
  460, 620, 30):setFillColor(244/255)

  local okButton = widget.newButton{
    shape = "roundedRect",
    radius = 5,
    width = 440,
    height = 70,
    left = 50,
    top = 700,
    fontSize = 34,
    fillColor = { default = {0.2}, over = {0.8}},
    lableColor = { default = {0}, over = {0}},
    label = "OK!",
    onPress = function(event)
      composer.hideOverlay("fade",100)
    end
  }
  sceneGroup:insert(okButton)

  function calculator()
      local formula
    if (sex == "men") then
      formula = (10 * weight + 6.25 * height - 5 * age + 5)
    else
      formula = (10 * weight + 6.25 * height - 5 * age - 161)
    end
    v = formula * activity_factor / 24
    res = math.round(v * time / 60)
    return res
  end

  display.newText(sceneGroup, "RESULT",
  display.contentCenterX,240, "ImgAndFonts/Obelix", 34)
  display.newImage(sceneGroup, "ImgAndFonts/corona_apple_icon.png",105,230)

  calc = calculator()
  display.newText({
    parent = sceneGroup,
    text = activity_name,
    x = display.contentCenterX,
    y = 340,
    fontSize = 34,
    width = 420,
    align = center,
  })

  display.newText(sceneGroup, "TIME",
  display.contentCenterX,410, "ImgAndFonts/Obelix", 32)
  display.newText(sceneGroup, time.." min",
  display.contentCenterX,465, native.system, 38)

  display.newText(sceneGroup, "CALORIES",
  display.contentCenterX,530, "ImgAndFonts/Obelix", 32)
  display.newText(sceneGroup, calc,
  display.contentCenterX,600, "ImgAndFonts/SuezOne", 68):setFillColor(0,
  165/255, 80/255)

  function saveSetting(t, fileName)
    local path = system.pathForFile(fileName, system.ResourceDirectory)
    local file = io.open(path, "w")
    if(file) then
      local contents = json.encode(t)
      file:write(contents)
      io.close(file)
      return true
    else
      return false
    end
  end

  settings = {}
  settings.weight = weight
  settings.height = height
  settings.time = time
  settings.sex = sex
  settings.age = age
  settings.activity_index = activity_index
  settings.activity_name = activity_name
  settings.activity_factor = activity_factor

  saveSetting(settings, "settings.json")

end

scene:addEventListener("create",scene)
return scene;
