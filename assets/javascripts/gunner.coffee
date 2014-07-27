RKE_FIGHTER = 0
REG_FIGHTER = 1
SUBMARINE = 2
VET_FIGHTER = 3
BOMBER = 4
DESTROYER = 5
ELT_FIGHTER = 6

window.Gunner = {
  ENEMY_LVL_CHART:
    0:
      action: ["unlock", RKE_FIGHTER, 1000, 20]
      next: 20
    20:
      action: ["setSpawnRate", RKE_FIGHTER, 600]
      next: 50
    50:
      action: ["unlock", REG_FIGHTER, 5000, 10]
      next: 100
    100:
      action: ["setMaxCount", RKE_FIGHTER, 30]
      next: 150
    150:
      action: ["setSpawnRate", REG_FIGHTER, 2500]
      next: 200
    200:
      action: ["setSpawnRate", RKE_FIGHTER, 400]
      next: 300
    300:
      action: ["setSpawnRate", REG_FIGHTER, 1700]
      next: 400
    400:
      action: ["setSpawnRate", RKE_FIGHTER, 300]
      next: 500
    500:
      action: ["setMaxCount", RKE_FIGHTER, 40]
      next: 750
    750:
      action: ["unlock", SUBMARINE, 10000, 10]
      next: 1000
    1000:
      action: ["setSpawnRate", REG_FIGHTER, 1200]
      next: 1250
    1250:
      action: ["setSpawnRate", RKE_FIGHTER, 250]
      next: 1500
    1500:
      action: ["setMaxCount", REG_FIGHTER, 20]
      next: 1750
    1750:
      action: ["setSpawnRate", RKE_FIGHTER, 200]
      next: 2000
    2000:
      action: ["unlock", VET_FIGHTER, 10000, 10]
      next: 2250
    2250:
      action: ["setMaxCount", RKE_FIGHTER, 60]
      next: 2500
    2500:
      action: ["setMaxCount", REG_FIGHTER, 30]
      next: 2750
    2750:
      action: ["setSpawnRate", VET_FIGHTER, 7500]
      next: 3000
    3000:
      action: ["setSpawnRate", SUBMARINE, 8000]
      next: 3250
    3250:
      action: ["setMaxCount", RKE_FIGHTER, 80]
      next: 3500
    3500:
      action: ["setSpawnRate", REG_FIGHTER, 800]
      next: 3750
    3750:
      action: ["setSpawnRate", SUBMARINE, 7000]
      next: 4000
    4000:
      action: ["unlock", BOMBER, 10000, 10]
      next: 4250
    4250:
      action: ["setSpawnRate", VET_FIGHTER, 5000]
      next: 4500
    4500:
      action: ["setSpawnRate", RKE_FIGHTER, 150]
      next: 4750
    4750:
      action: ["setMaxCount", RKE_FIGHTER, 120]
      next: 5000
    5000:
      action: ["setSpawnRate", BOMBER, 8000]
      next: 5250
    5250:
      action: ["setSpawnRate", REG_FIGHTER, 700]
      next: 5500
    5500:
      action: ["setMaxCount", REG_FIGHTER, 50]
      next: 5750
    5750:
      action: ["setSpawnRate", VET_FIGHTER, 4000]
      next: 6000
    6000:
      action: ["unlock", DESTROYER, 20000, 2]
      next: 8000
    8000:
      action: ["setSpawnRate", DESTROYER, 15000]
      next: 10000
    10000:
      action: ["unlock", ELT_FIGHTER, 30000, 1]
      next: null
      end: 15000

  BULLET_TYPES: ['small', 'large', 'burst']
  FIRING_TYPES: ['single', 'triple', 'bomb']

  ENEMY_TYPES: ['Rookie Fighter', 'Regular Fighter', 'Submarine', 'Veteran Fighter', 'Bomber', 'Destroyer', 'Elite Fighter']

  ENERGY_REQ:
    small: 1
    large: 3
    burst: 8
    single: 1
    triple: 3
    bomb: 10

  ENERGY_BARS: ['red', 'yellow', 'green', 'blue']
  ENERGY_TIERS: [25, 100, 500, 2500]

  BULLET_OFFSET:
    small: 20
    large: 30
    burst: 25

  FIRE_RATE:
    small: 100
    large: 150
    burst: 250
    single: 1
    triple: 2.5
    bomb: 5

  HIT_RATE:
    "bullet-small":
      enemy0: 0.66
      enemy1: 0.30
      enemy2: 0.05
      enemy3: 0.05
      enemy4: 0.009
      enemy5: 0.0055
      enemy6: 0.002
    "bullet-large":
      enemy0: 1
      enemy1: 0.9
      enemy2: 0.2
      enemy3: 0.12
      enemy4: 0.03
      enemy5: 0.019
      enemy6: 0.008
    "bullet-burst":
      enemy0: 1
      enemy1: 1
      enemy2: 0.35
      enemy3: 0.15
      enemy4: 0.05
      enemy5: 0.025
      enemy6: 0.01

  REWARD:
    enemy0: 2
    enemy1: 5
    enemy2: 25
    enemy3: 50
    enemy4: 100
    enemy5: 200
    enemy6: 500

  GAME_LENGTH_TEXT:
    5: 'Quick'
    2: 'Normal'
    1: 'Extended'
  
  timeDisplay: (ms) ->
    minutes = Math.floor(ms / 60000)
    seconds = ms - (minutes * 60000)
    ms = seconds % 1000
    seconds = Math.floor(seconds / 1000)
    "#{minutes}' #{('00' + seconds).slice(-2)}\" #{('000' + ms).slice(-3)}"

  horizontalCenter: (bmpText) ->
    bmpText.updateTransform()

    bmpText.oldX = bmpText.x unless bmpText.oldX

    if !bmpText.oldWidth? or Math.abs(bmpText.oldWidth - bmpText.textWidth) > 8
      bmpText.oldWidth = bmpText.textWidth
      bmpText.x = bmpText.oldX - bmpText.textWidth / 2

  verticalCenter: (bmpText) ->
    bmpText.updateTransform()

    bmpText.oldY = bmpText.y unless bmpText.oldY

    if !bmpText.oldHeight? or bmpText.oldHeight isnt bmpText.textHeight
      bmpText.oldHeight = bmpText.textHeight
      bmpText.y = bmpText.oldY - bmpText.textHeight / 2

  center: (bmpText) ->
    @horizontalCenter(bmpText)
    @verticalCenter(bmpText)

}
