Levels = Core.class(Sprite)

function Levels:init()
	-- local vars
	local ismoving, starty = false, 0

	-- rows layout
	function row(item)
		local row = Sprite.new()
		local width, height = 4 * myappwidth / 5, myappheight
		-- the row title
		local title = TextField.new(nil, item.titletr, "Qq")
		title:setScale(6)
		title:setAnchorPoint(0, 0)
		title:setTextColor(color_desert[3])
		row:addChild(title)
		-- clickable button (Pixel)
		local button = Pixel.new(0xffffff, 0, title:getWidth(), title:getHeight())
		button:addEventListener(Event.MOUSE_DOWN, function(e)
			if button:hitTestPoint(e.x, e.y) then
				ismoving = false
				starty = e.y
			end
		end)
		button:addEventListener(Event.MOUSE_MOVE, function(e)
			if button:hitTestPoint(e.x, e.y) then
				if math.abs(starty - e.y) > 10 then
					ismoving = true
				else
					ismoving = false
				end
			end
		end)
		button:addEventListener(Event.MOUSE_UP, function(e)
			if button:hitTestPoint(e.x, e.y) and not ismoving then
				playSfx(false)
				g_currentlevel = item.currentlevel
				self.LoadMenu()
			end
		end)
		row:addChild(button)
		-- blank space
		local blank = Pixel.new(0x00ffff, 0, width, 16)
		row:addChild(blank)
		-- deco
		local deco = Pixel.new(0xffffff, 0.5, width, 16)
		row:addChild(deco)
		-- set positions
		title:setPosition(0, 16)
		button:setPosition(title:getPosition())
		blank:setPosition(0, title:getY() + title:getHeight())
		deco:setPosition(0, title:getY() + title:getHeight() + blank:getHeight())

		return row
	end

	-- datas
	local data = {}
	for i = 1, 512 do
		data[i] = row(
			{
				titletr = "TITLE "..i,
				currentlevel = i,
			}
		)
	end

	-- scrollable list
	local myList = ListView.new(
		{
			width = 4 * myappwidth / 5,
			height = myappheight,
			friction = 0.99, -- 0.97
			bgColor = 0xffffff,
			bgAlpha = 0.05,
			rowSnap = true, -- experimental feature
			data = data
		}
	)
	myList:setPosition(1 * myappwidth / 5 / 2, 0)
	self:addChild(myList)

	-- back button
	local back = ButtonUDD_V2.new(
		{
			text = "BACK", textscalex = 8, textcolordown = 0x00ff00
		}
	)
	back:setPosition(myappwidth / 2, 9 * myappheight / 10)
	self:addChild(back)
	back:addEventListener("clicked", function()
		self.LoadMenu()
	end)

	-- LISTENERS
	self:addEventListener("enterBegin", self.onTransitionInBegin, self)
	self:addEventListener("enterEnd", self.onTransitionInEnd, self)
	self:addEventListener("exitBegin", self.onTransitionOutBegin, self)
	self:addEventListener("exitEnd", self.onTransitionOutEnd, self)
end

-- EVENT LISTENERS
function Levels:onTransitionInBegin()
end

function Levels:onTransitionInEnd()
	self:MyKeysPressed()
end

function Levels:onTransitionOutBegin()
end

function Levels:onTransitionOutEnd()
end

-- KEYS HANDLER
function Levels:MyKeysPressed()
	self:addEventListener(Event.KEY_DOWN, function(e)
		if e.keyCode == KeyCode.BACK or e.keyCode == KeyCode.ESC then
			self.LoadMenu()
		end
	end)
end

-- LOAD SCENE
function Levels:LoadMenu()
	playSfx(false)
	scenemanager:changeScene("menu", 1, scenemanager.moveFromLeft, easing.outBack)
end
