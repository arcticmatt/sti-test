local conf = {}

conf.width = 640   -- 20 x 32
conf.height = 640  -- 20 x 32

function love.conf(t)
  t.title = 'tiled-test'
  t.identity = 'tiled-test'
  t.console = true -- attach a console to the windows version
  t.window.width = conf.width
  t.window.height = conf.height
  t.window.msaa = 8
end

return conf
