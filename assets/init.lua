-- dimensions
myappwidth, myappheight = application:getContentWidth(), application:getContentHeight()

-- plugins
require "scenemanager"
require "easing"

-- colors
color_desert = {0x8C6B42, 0xA68256, 0xBF9B6F, 0xD9B589, 0x734A27, 0x0, 0xffffff, 0x403C38, 0xCABFB2}

-- preferences
g_configfilepath = "myprefs.txt"
g_language = application:getLanguage()
g_isaudio = true
