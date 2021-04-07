local composer = require("composer")
local scene = composer.newScene();
local json = require("json")

function scene:show(event)
  local sceneGroup = self.view;
  local widget = require("widget")
  settings = loadSetting("settings.json")
  if(settings) then
    weight = settings.weight
    height = settings.height
    time = settings.time
    sex = settings.sex
    age = settings.age
    activity_index = settings.activity_index
    activity_name = settings.activity_name
    activity_factor = settings.activity_factor
  end
-------------------------------------------------------------
--wigth
-------------------------------------------------------------

  local wightGroup = display.newGroup()
  display.newCircle(wightGroup, display.contentCenterX, 70, 60)
  display.newRoundedRect(wightGroup, display.contentCenterX, 110, w, 100, 20)
  display.newText(wightGroup,"Chouse your weight (kg)",display.contentCenterX,90,
  "ImgAndFonts/SuezOne",30):setFillColor(3/255, 31/255, 38/255)

  local myWeight = display.newText({
    parent = wightGroup,
    fontSize = 35,
    text = weight,
    x = display.contentCenterX,
    y = 45,
    font = "ImgAndFonts/Obelix",
  })
  myWeight:setFillColor(3/255, 31/255, 38/255)

  local optionsSlider = {
    frames={
      {x = 0, y = 0, wight = 15, height = 45},
      {x = 16, y = 0, wight = 130, height = 45},
      {x = 332, y = 0, wight = 15, height = 45},
      {x = 153, y = 0, wight = 15, height = 45},
      {x = 353, y = 0, wight = 47, height = 47},
    },
    sheetContentWidth = 400,
    sheetContentHeignt = 47,
  }

  local weightSlider = widget.newSlider {
    sheet = graphics.newImageSheet("ImgAndFonts/corona_slider_image.png",optionsSlider),
    leftFrame = 1,
    middleFrame = 2,
    rightFrame = 3,
    fillFrame = 4,
    handleFrame = 5,
    frameWight = 15,
    frameHeight = 45,
    handleWight = 47,
    handleHeight = 47,
    top = 105,
    left = 90,
    width = 360,
    height =47,
    orientation = "horizontal",
    value = 100 * (weight - weightMin) / (weightMax - weightMin),
    listener = function(event)
      weight = math.round(weightMin + (weightMax - weightMin)*event.value/100)
      myWeight.text = weight
    end
  }

  weightMinusButton = widget.newButton{
    shape = "roundedRect",
    radius = 5, width = 50, height = 50,
    left = 35, top = 100, fontSize = 40,
    fillColor = { default = {76/255}, over = {150/255}},
    lableColor = { default = {1}, over = {0}},
    label = "-",
    onPress = function(event)
      if (weight > weightMin) then
        weight = weight - 1
        myWeight.text = weight
        weightSlider:setValue(100 * (weight - weightMin) / (weightMax -weightMin))
      end
    end
  }
  weightPlusButton = widget.newButton{
    shape = "roundedRect",
    radius = 5, width = 50, height = 50,
    left = 458, top = 100, fontSize = 40,
    fillColor = { default = {76/255}, over = {150/255}},
    lableColor = { default = {1}, over = {0}},
    label = "+",
    onPress = function(event)
      if (weight < weightMax) then
        weight = weight + 1
        myWeight.text = weight
        weightSlider:setValue(100 * (weight - weightMin) / (weightMax -weightMin))
      end
    end
  }
  wightGroup:insert(weightSlider)
  wightGroup:insert(weightMinusButton)
  wightGroup:insert(weightPlusButton)
  -----------------------------------------------------
  --gender panel
  -----------------------------------------------------
  local sexGroup = display.newGroup()
  display.newRoundedRect(sexGroup, display.contentCenterX,720,
  w,120, 20)
  display.newText(sexGroup,"Chouse your gender",155,700,"ImgAndFonts/Obelix",
  20):setFillColor(0.2)
  sexSelect = display.newText(sexGroup,sex,155,740,"ImgAndFonts/Obelix",20)
  sexSelect:setFillColor(0.2)

  manOn = display.newImage("ImgAndFonts/corona_male_active.png",340,720)
  manOff = display.newImage("ImgAndFonts/corona_male.png",340,720)
  womanOn = display.newImage("ImgAndFonts/corona_female_active.png",460,720)
  womanOff = display.newImage("ImgAndFonts/corona_female.png",460,720)
  sexGroup:insert(manOn)
  sexGroup:insert(manOff)
  sexGroup:insert(womanOn)
  sexGroup:insert(womanOff)
  if (sex == "man") then
    manOff.isVisible = false
    womanOn.isVisible = false
  else
    manOn.isVisible = false
    womanOff.isVisible = false
  end

  function selectMan (event)
    if(event.phase == "began") then
      sex = "man"
      sexSelect.text = sex
      manOff.isVisible = false
      womanOn.isVisible = false
      manOn.isVisible = true
      womanOff.isVisible = true
    end
    return true
  end

  function selectWoman (event)
    if(event.phase == "began") then
      sex = "woman"
      sexSelect.text = sex
      manOn.isVisible = false
      womanOff.isVisible = false
      manOff.isVisible = true
      womanOn.isVisible = true
    end
    return true
  end
-------------------------------------------------------
--age
-------------------------------------------------------
local ageGroup = display.newGroup()


display.newCircle(ageGroup, display.contentCenterX, 230, 60)
display.newRoundedRect(ageGroup, display.contentCenterX, 270, w, 100, 20)
display.newText(ageGroup,"Chouse your age",display.contentCenterX,250,
"ImgAndFonts/SuezOne",30):setFillColor(3/255, 31/255, 38/255)

local myAge = display.newText({
  parent = ageGroup,
  fontSize = 35,
  text = age,
  x = display.contentCenterX,
  y = 205,
  font = "ImgAndFonts/Obelix",
})
myAge:setFillColor(3/255, 31/255, 38/255)

local optionsSlider = {
  frames={
    {x = 0, y = 0, wight = 15, height = 45},
    {x = 16, y = 0, wight = 130, height = 45},
    {x = 332, y = 0, wight = 15, height = 45},
    {x = 153, y = 0, wight = 15, height = 45},
    {x = 353, y = 0, wight = 47, height = 47},
  },
  sheetContentWidth = 400,
  sheetContentHeignt = 47,
}

ageSlider = widget.newSlider {
  sheet = graphics.newImageSheet("ImgAndFonts/corona_slider_image.png",optionsSlider),
  leftFrame = 1,
  middleFrame = 2,
  rightFrame = 3,
  fillFrame = 4,
  handleFrame = 5,
  frameWight = 15,
  frameHeight = 45,
  handleWight = 47,
  handleHeight = 47,
  top = 265,
  left = 90,
  width = 360,
  height =47,
  orientation = "horizontal",
  value = 100 * (age - ageMin) / (ageMax - ageMin),
  listener = function(event)
    age = math.round(ageMin + (ageMax - ageMin)*event.value/100)
    myAge.text = age
  end
}

ageMinusButton = widget.newButton{
  shape = "roundedRect",
  radius = 5, width = 50, height = 50,
  left = 35, top = 260, fontSize = 40,
  fillColor = { default = {76/255}, over = {150/255}},
  lableColor = { default = {1}, over = {0}},
  label = "-",
  onPress = function(event)
    if (age > ageMin) then
      age = age - 1
      myAge.text = age
      ageSlider:setValue(100 * (age - ageMin) / (ageMax - ageMin))
    end
  end
}

agePlusButton = widget.newButton{
  shape = "roundedRect",
  radius = 5, width = 50, height = 50,
  left = 458, top = 260, fontSize = 40,
  fillColor = { default = {76/255}, over = {150/255}},
  lableColor = { default = {1}, over = {0}},
  label = "+",
  onPress = function(event)
    if (age < ageMax) then
      age = age + 1
      myAge.text = age
      ageSlider:setValue(100 * (age - ageMin) / (ageMax -ageMin))
    end
  end
}
ageGroup:insert(ageSlider)
ageGroup:insert(ageMinusButton)
ageGroup:insert(agePlusButton)
  -------------------------------------------------------
  --time
  -------------------------------------------------------
  local timeGroup = display.newGroup()


  display.newCircle(timeGroup, display.contentCenterX, 390, 60)
  display.newRoundedRect(timeGroup, display.contentCenterX, 430, w, 100, 20) --390
  display.newText(timeGroup,"How many time?(min)",display.contentCenterX,410,
  "ImgAndFonts/SuezOne",30):setFillColor(3/255, 31/255, 38/255)

  local myTime = display.newText({
    parent = timeGroup,
    fontSize = 35,
    text = time,
    x = display.contentCenterX,
    y = 365,
    font = "ImgAndFonts/Obelix",
  })
  myTime:setFillColor(3/255, 31/255, 38/255)

  local optionsSlider = {
    frames={
      {x = 0, y = 0, wight = 15, height = 45},
      {x = 16, y = 0, wight = 130, height = 45},
      {x = 332, y = 0, wight = 15, height = 45},
      {x = 153, y = 0, wight = 15, height = 45},
      {x = 353, y = 0, wight = 47, height = 47},
    },
    sheetContentWidth = 400,
    sheetContentHeignt = 47,
  }

  timeSlider = widget.newSlider {
    sheet = graphics.newImageSheet("ImgAndFonts/corona_slider_image.png",optionsSlider),
    leftFrame = 1,
    middleFrame = 2,
    rightFrame = 3,
    fillFrame = 4,
    handleFrame = 5,
    frameWight = 15,
    frameHeight = 45,
    handleWight = 47,
    handleHeight = 47,
    top = 425,
    left = 90,
    width = 360,
    height =47,
    orientation = "horizontal",
    value = 100 * (time - timeMin) / (timeMax - timeMin),
    listener = function(event)
      time = math.round(timeMin + (timeMax - timeMin)*event.value/100)
      myTime.text = time
    end
  }
  timeMinusButton = widget.newButton{
    shape = "roundedRect",
    radius = 5, width = 50, height = 50,
    left = 35, top = 420, fontSize = 40,
    fillColor = { default = {76/255}, over = {150/255}},
    lableColor = { default = {1}, over = {0}},
    label = "-",
    onPress = function(event)
      if (time > timeMin) then
        time = time - 1
        myTime.text = time
        timeSlider:setValue(100 * (time - timeMin) / (timeMax -timeMin))
      end
    end
  }

  timePlusButton = widget.newButton{
    shape = "roundedRect",
    radius = 5, width = 50, height = 50,
    left = 458, top = 420, fontSize = 40,
    fillColor = { default = {76/255}, over = {150/255}},
    lableColor = { default = {1}, over = {0}},
    label = "+",
    onPress = function(event)
      if (time < timeMax) then
        time = time + 1
        myTime.text = time
        timeSlider:setValue(100 * (time - timeMin) / (timeMax -timeMin))
      end
    end
}
timeGroup:insert(timeSlider)
timeGroup:insert(timeMinusButton)
timeGroup:insert(timePlusButton)
-----------------------------------------------------
--height---
-----------------------------------------------------

local heightGroup = display.newGroup()


display.newCircle(heightGroup, display.contentCenterX, 550, 60)
display.newRoundedRect(heightGroup, display.contentCenterX, 600, w, 100, 20)
display.newText(heightGroup,"What is your height (cm)",display.contentCenterX,580,
"ImgAndFonts/SuezOne",30):setFillColor(3/255, 31/255, 38/255)

local myHeight = display.newText({
  parent = heightGroup,
  fontSize = 35,
  text = height,
  x = display.contentCenterX,
  y = 535,
  font = "ImgAndFonts/Obelix",
})
myHeight:setFillColor(3/255, 31/255, 38/255)

local optionsSlider = {
  frames={
    {x = 0, y = 0, wight = 15, height = 45},
    {x = 16, y = 0, wight = 130, height = 45},
    {x = 332, y = 0, wight = 15, height = 45},
    {x = 153, y = 0, wight = 15, height = 45},
    {x = 353, y = 0, wight = 47, height = 47},
  },
  sheetContentWidth = 400,
  sheetContentHeignt = 47,
}

heightSlider = widget.newSlider {
  sheet = graphics.newImageSheet("ImgAndFonts/corona_slider_image.png",optionsSlider),
  leftFrame = 1,
  middleFrame = 2,
  rightFrame = 3,
  fillFrame = 4,
  handleFrame = 5,
  frameWigth = 15,
  frameHeight = 45,
  handleWidth = 47,
  handleHeight = 47,
  top = 595,
  left = 90,
  width = 360,
  height =47,
  orientation = "horizontal",
  value = 100 * (height - heightMin) / (heightMax - heightMin),
  listener = function(event)
    height = math.round(heightMin + (heightMax - heightMin)*event.value/100)
    myHeight.text = height
  end
}
heightMinusButton = widget.newButton{
  shape = "roundedRect",
  radius = 5, width = 50, height = 50,
  left = 35, top = 590, fontSize = 40,
  fillColor = { default = {76/255}, over = {150/255}},
  lableColor = { default = {1}, over = {0}},
  label = "-",
  onPress = function(event)
    if (height > heightMin) then
      height = height - 1
      myHeight.text = height
      heightSlider:setValue(100 * (height - heightMin) / (heightMax -heightMin))
    end
  end
}

heightPlusButton = widget.newButton{
  shape = "roundedRect",
  radius = 5, width = 50, height = 50,
  left = 458, top = 590, fontSize = 40,
  fillColor = { default = {76/255}, over = {150/255}},
  lableColor = { default = {1}, over = {0}},
  label = "+",
  onPress = function(event)
    if (height < heightMax) then
      height = height + 1
      myHeight.text = height
      heightSlider:setValue(100 * (height - heightMin) / (heightMax -heightMin))
    end
  end
}
heightGroup:insert(heightSlider)
heightGroup:insert(heightMinusButton)
heightGroup:insert(heightPlusButton)
----------------------------------------------------------
----------------------------------------------------------
  manOff:addEventListener("touch",selectMan)
  womanOff:addEventListener("touch",selectWoman)
  --------------------------------------------------------
local activityGroup = display.newGroup()

display.newRoundedRect(activityGroup, display.contentCenterX, 820, w, 60, 20)
display.newPolygon(activityGroup, 490, 820,{500,452,520,452,510,466}):setFillColor(76/255)
activityText = display.newText(activityGroup, activity_name,display.contentCenterX,820,"ImgAndFonts/SuezOne", 24)
activityText:setFillColor(3/255, 31/255, 38/255)
activityGroup:addEventListener("touch",
  function (event)
    composer.showOverlay("scenes.activity",{
      effect = "fade",
      time = 100,
      isModal = true,
    })
  end
)
-------------------------------------------------
--calcbutton

local buttonCalc = widget.newButton{
  shape = "roundedRect",
  radius = 5,
  width = w,
  height = 70,
  left = 20,
  top = 870,
  fontSize = 34,
  fillColor = { default = {76/255}, over = {150/255}},
  lableColor = { default = {0}, over = {0}},
  label = "Calculate calories",
  onPress = function(event)
    composer.showOverlay("scenes.result",{
      isModal = true,
      effect = "fade",
      time = 100,
    })
  end
}
--------------------------------------------------
sceneGroup:insert(buttonCalc)
sceneGroup:insert(activityGroup)
sceneGroup:insert(heightGroup)
sceneGroup:insert(timeGroup)
sceneGroup:insert(ageGroup)
sceneGroup:insert(wightGroup)
sceneGroup:insert(sexGroup)
    -------------------------------------------------------------------
end

function loadSetting(fileName)
  local path = system.pathForFile(fileName, system.ResourceDirectory)
  local contents = ""
  local myTable = {}
  local file = io.open(path, "r")
  if(file) then
    contents = file:read("*a")
    myTable = json.decode(contents)
    io.close(file)
    file = nil
    return myTable
  end
  return nil
end

scene:addEventListener("show",scene)
return scene;
