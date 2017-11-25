-- Include Simple Tiled Implementation into project
local sti = require "sti"

-- Local functions
local function drawPlayerLayer(self)
  love.graphics.draw(
  self.player.sprite,
  math.floor(self.player.x),
  math.floor(self.player.y),
  0,
  1,
  1,
  self.player.ox,
  self.player.oy
)

-- Temporarily draw a point at our location so we know
-- that our sprite is offset properly
love.graphics.setPointSize(10)
love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
end

local function updatePlayerLayer(self, dt)
  -- 96 pixels per second
  local speed = 96

  -- Movement
  if love.keyboard.isDown("up") then
    self.player.y = self.player.y - speed * dt
  end

  if love.keyboard.isDown("down") then
    self.player.y = self.player.y + speed * dt
  end

  if love.keyboard.isDown("left") then
    self.player.x = self.player.x - speed * dt
  end

  if love.keyboard.isDown("right") then
    self.player.x = self.player.x + speed * dt
  end
end

function love.load()
  -- Load map file
  map = sti("map.lua")

  -- Create new dynamic data layer called "Sprites" as the 8th layer
  local layer = map:addCustomLayer("Sprites", 3)

  -- Get player spawn object
  local player
  for k, object in pairs(map.objects) do
    if object.name == "player" then
      player = object
      break
    end
  end

  -- Create player object
  local sprite = love.graphics.newImage("sprite.png")
  layer.player = {
    sprite = sprite,
    x      = player.x,
    y      = player.y,
    ox     = sprite:getWidth() / 2,
    oy     = sprite:getHeight() / 1,
  }

  -- Set layer callbacks
  layer.draw = drawPlayerLayer
  layer.update = updatePlayerLayer

  -- Remove unneeded object layer
  map:removeLayer("player")
end

function love.update(dt)
  -- Update world
  map:update(dt)
end

function love.draw()
  -- Scale world
  local scale = 1.5
  local screen_width = love.graphics.getWidth() / scale
  local screen_height = love.graphics.getHeight() / scale

  -- Translate world so that player is always centered
  local player = map.layers["Sprites"].player
  local tx = math.floor(player.x - screen_width / 2)
  local ty = math.floor(player.y - screen_height / 2)
  print(tx, ty)

  -- Draw world
  map:draw(-tx, -ty, scale, scale)
end
