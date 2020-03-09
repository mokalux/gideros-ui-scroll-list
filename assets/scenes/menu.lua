Menu = Core.class(Sprite)

function Menu:init()
	-- bg
	application:setBackgroundColor(color_desert[5])
	-- title
	text = "YOUR TITLE"
	tf = TextField.new(nil, text)
	tf:setAnchorPoint(0.5, 0.5)
	tf:setScale(6)
	tf:setTextColor(color_desert[2])
	tf:setPosition(myappwidth / 2, 2 * myappheight / 10)
	self:addChild(tf)
	-- buttons
	local button = ButtonUDD_V2.new(
		{
			text = "LIST", textscalex = 8, textcolordown = 0xffffff
		}
	)
	button:setPosition(myappwidth / 2, 5 * myappheight / 10)
	self:addChild(button)
	button:addEventListener("clicked", function()
		self.loadListScene()
	end)
	-- keys handler
	self:myKeysPressed()
end

-- KEYS HANDLER
function Menu:myKeysPressed()
	self:addEventListener(Event.KEY_DOWN, function(e)
		if application:getDeviceInfo() ~= "Web" then
			-- for mobiles and desktops
			if e.keyCode == KeyCode.BACK or e.keyCode == KeyCode.ESC then
--				application:exit() -- you can (un)comment this line when needed
			end
		end
	end)
	self:addEventListener(Event.KEY_UP, function(e)
		if e.keyCode == KeyCode.SPACE or e.keyCode == KeyCode.ENTER then
			self.loadListScene()
		end
	end)
end

-- LOAD SCENES
function Menu:loadListScene()
	scenemanager:changeScene("levels", 1, scenemanager.moveFromRight, easing.inOutSine)
end
