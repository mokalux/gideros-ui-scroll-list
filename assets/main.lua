-- AUDIO
function playSfx(xbool)
	local sound
	local channel
	if xbool then
		sound = Sound.new("audio/selecton.wav")
		channel = sound:play()
		channel:setVolume(0.25)
	else
		sound = Sound.new("audio/selectoff.wav")
		channel = sound:play()
		channel:setVolume(0.75)
	end
end

-- scene manager
scenemanager = SceneManager.new(
	{
		["menu"] = Menu,
		["levels"] = Levels,
	}
)

stage:addChild(scenemanager)
scenemanager:changeScene("menu")
--scenemanager:changeScene("levels")
