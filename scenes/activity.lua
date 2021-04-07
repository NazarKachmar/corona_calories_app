local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local data = require("scenes.data")

function scene:create(event)
  local sceneGroup = self.view;
  display.newRect(sceneGroup, display.contentCenterX,
  display.contentCenterY, display.contentWidth,
  display.contentHeight):setFillColor(0/255, 148/255, 255/255, 0.5)

  function onRowRender(event)
    local row = event.row
    local id = row.index
    row.activityText = display.newText(sceneGroup, data[id].name,
    24, 24, "ImgAndFonts/Obelix",20)
    row.activityText.anchorX = 0
    if(data[id].category == 1) then
      row.activityText:setFillColor(1)
    else
      row.activityText:setFillColor(0)
    end
    row:insert(row.activityText)

  end

  function onRowTouch(event)
    local row = event.row
    if(event.phase == "release") then
      activity_index = row.index
      activity_name = data[activity_index].name
      activity_factor = data[activity_index].factor
      activityText.text = activity_name
      composer.hideOverlay("fade", 100)
    end
  end

   local activityList = widget.newTableView{top = 70, left = 40, width = 460, height = 850,
    onRowRender = onRowRender, onRowTouch = onRowTouch,
  }
  sceneGroup:insert( activityList )
  for i = 1, #data do
    if(data[i].category == 1) then
      isCategory = true
    else
      isCategory = false
    end
    if(isCategory == true) then
      rowColor = {default={61/255, 255/255, 74/255}}
    else
      rowColor = {default={255/255, 254/255, 252/255}}
    end
    activityList:insertRow{
      rowHeight = 50,
      isCategory = isCategory,
      rowColor = rowColor,
    }
  end
  close = display.newImage(sceneGroup,"ImgAndFonts/corona_close.png", 500, 65)
  close:addEventListener("touch", function(event)
    if(event.phase == "ended") then
      composer.hideOverlay("fade", 100)
    end
  end)
end

scene:addEventListener("create",scene)
return scene;
