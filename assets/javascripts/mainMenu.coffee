Store = new Persist.Store('Gunner Scores')
Gunner = window.Gunner

class MainMenu
  create: ->
    @stage.backgroundColor = '#2F3942'


    @titleText = @add.bitmapText(400, 150, 'Airborne', 'Gunner', 128)
    Gunner.center(@titleText)

    gl = Store.get('gameLength')
    @game.lengthMultplier = if gl? then parseInt(gl) else 2
    gt = Store.get('gameType')
    @game.gameType = if gt? then gt else 'Time Attack'

    @menuTexts = {}
    @bitmapData = {}
    @menuImages = []
    @setupTopLevel()

  addText: (text, x, y, selected, small) ->
    bmd = @add.bitmapData(1, 1)
    bmds = @add.sprite(0, 0, bmd)
    mt = @add.bitmapText(x, y, (if selected then 'Airborne' else 'AirborneGray'), text, (if small then 26 else 32))
    @menuTexts[text] = mt
    Gunner.center mt
    mt.inputEnabled = true
    mt.events.onInputDown.add(@menuSelect, @menuTexts[text])
    bmds.x = mt.x - 5
    bmds.y = mt.y - 5
    bmd.resize(mt.textWidth + 10, mt.textHeight + 3)
    bmd.context.fillStyle = "#2F3942"
    bmd.context.fillRect 0, 0, mt.textWidth + 10, mt.textHeight + 3
    bmds.inputEnabled = true
    bmds.events.onInputDown.add(@menuSelect, @menuTexts[text])
    @bitmapData[text] = bmds

  addTypewriterText: (text, x, y, size, centerType, link) ->
    if link?
      bmd = @add.bitmapData(1, 1)
      bmds = @add.sprite(0, 0, bmd)
    mt = @add.bitmapText(x, y, 'SpecialElite32', text, size)
    mt.align = 'center'
    @menuTexts[text] = mt
    switch centerType
      when 'horizontal'
        Gunner.horizontalCenter(mt)
      when 'vertical'
        Gunner.verticalCenter(mt)
      when 'both'
        Gunner.center(mt)
    if link?
      mt.inputEnabled = true
      mt.events.onInputDown.add( ->
        win = window.open(this, '_blank')
        win.focus()
      , link)
      bmds.x = mt.x - 5
      bmds.y = mt.y - 3
      bmd.resize(mt.textWidth + 10, mt.textHeight + 5)
      bmd.context.fillStyle = "#2F3942"
      bmd.context.fillRect 0, 0, mt.textWidth + 10, mt.textHeight + 5
      bmds.inputEnabled = true
      bmds.events.onInputDown.add( ->
        win = window.open(this, '_blank')
        win.focus()
      , link)
      @bitmapData[text] = bmds
    return mt

  addInstructionText: (text, x, y, header) ->
    @addTypewriterText(text, x, y, (if header then 32 else 20), (if header then 'both' else 'vertical'))

  addTutorialText: (text, x, y, header) ->
    @addTypewriterText(text, x, y, (if header then 32 else 20), 'both')

  addCreditsText: (text, x, y, link) ->
    @addTypewriterText(text, x, y, 20, 'none', link)

  menuSelect: ->
    state = @game.state.getCurrentState()
    switch @text
      when "Back to Main Menu"
        state.titleText.visible = true
        state.setupTopLevel()
      when "Play Game"
        state.setupOptions()
      when "Time Attack"
        @game.gameType = 'Time Attack'
        state.highlightType()
      when "Survival"
        @game.gameType = 'Survival'
        state.highlightType()
      when "Quick"
        @game.lengthMultplier = 5
        state.highlightLength()
      when "Normal"
        @game.lengthMultplier = 2
        state.highlightLength()
      when "Extended"
        @game.lengthMultplier = 1
        state.highlightLength()
      when "Start Game"
        @game.lengthMultplier = 2 unless @game.lengthMultplier?
        Store.set('gameLength', @game.lengthMultplier)
        @game.gameType = 'time atttack' unless @game.gameType?
        Store.set('gameType', @game.gameType)
        if Store.get('skipTutorial')?
          @game.state.start('Game')
        else
          state.displayTutorial()
      when "Skip this screen from now on"
        Store.set('skipTutorial', 'skip')
        @game.state.start('Game')
      when "Proceed to Game"
        @game.state.start('Game')
      when "How To Play"
        state.displayInstructions()
      when "Previous Page"
        state.displayInstructions()
      when "Next Page"
        state.displayInstructions2()
      when "High Scores"
        state.displayHighScores()
      when "Credits & Misc"
        state.displayCredits()

  setupTopLevel: ->
    @clearText()
    @addText 'Play Game', 400, 310, true
    @addText 'How To Play', 400, 360, false
    @addText 'High Scores', 400, 410, false
    @addText 'Credits & Misc', 400, 460, false
    @game.menuIndex = 0

  setupOptions: ->
    @clearText()
    @addText 'Time Attack', 230, 345, true, true
    @addText 'Survival', 230, 385, false, true
    @addText 'Quick', 570, 330, false, true
    @addText 'Normal', 570, 370, true, true
    @addText 'Extended', 570, 410, false, true
    @addText 'Game Type', 230, 270, true
    @addText 'Game Length', 570, 270, true
    @highlightLength()
    @highlightType()
    @addText 'Start Game', 400, 500, true
    @addText 'Back to Main Menu', 400, 540, false, true

  highlightType: ->
    @menuTexts["Time Attack"].destroy()
    @menuTexts["Survival"].destroy()
    @bitmapData["Time Attack"].destroy()
    @bitmapData["Survival"].destroy()
    switch @game.gameType
      when 'Time Attack'
        @addText 'Time Attack', 230, 345, true, true
        @addText 'Survival', 230, 385, false, true
      when 'Survival'
        @addText 'Time Attack', 230, 345, false, true
        @addText 'Survival', 230, 385, true, true

  highlightLength: ->
    @menuTexts["Quick"].destroy()
    @menuTexts["Normal"].destroy()
    @menuTexts["Extended"].destroy()
    @bitmapData["Quick"].destroy()
    @bitmapData["Normal"].destroy()
    @bitmapData["Extended"].destroy()
    switch @game.lengthMultplier
      when 5
        @addText 'Quick', 570, 330, true, true
        @addText 'Normal', 570, 370, false, true
        @addText 'Extended', 570, 410, false, true
      when 2
        @addText 'Quick', 570, 330, false, true
        @addText 'Normal', 570, 370, true, true
        @addText 'Extended', 570, 410, false, true
      when 1
        @addText 'Quick', 570, 330, false, true
        @addText 'Normal', 570, 370, false, true
        @addText 'Extended', 570, 410, true, true
    

  displayInstructions: ->
    @clearText()
    @titleText.visible = false
    @addInstructionText 'How To Play', 400, 50, true

    @addTutorialText 'This game has 2 modes: ', 400, 100

    @addInstructionText 'Time Attack - finish the game as soon as possible ', 70, 135
    @addInstructionText 'Survival - destroy as many as enemies as you can before losing', 70, 160

    @addTutorialText 'Shoot by clicking or tapping on the spot you wish to fire at.', 400, 210
    @addTutorialText 'Hold down click/tap for continuous fire. You can also use the arrow', 400, 235
    @addTutorialText 'keys to move the crosshair and Space Bar to fire.', 400, 260
 
    @addTutorialText 'Shooting consumes energy, destroying enemies provide energy.', 400, 295
    @addTutorialText 'Tougher enemies give more energy, but still count as 1 kill.', 400, 320

    @addTutorialText "Enemies cannot damage you, but it's game over if you", 400, 355
    @addTutorialText "waste all of your energy (i.e. it reaches 0)", 400, 380
 
    @addTutorialText 'Click/tap the audio icon to change the volume.', 400, 415
    @addTutorialText 'Click/tap the gears icon to pause and show options.', 400, 440

    @addText 'Next Page', 400, 500, true
    @addText 'Back to Main Menu', 400, 550, false

  displayInstructions2: ->
    @clearText()
    @titleText.visible = false
    @addInstructionText 'How To Play', 400, 50, true

    @addTutorialText 'Click/tap the other icons to change shot types and firing modes.', 400, 90
    
    @addInstructionText 'There are 3 shot types:', 40, 130

    @addInstructionText 'Small - fast firing, good for spraying weak enemies. 1 energy per shot', 40, 165
    @addInstructionText '              Keyboard shortcut: "1"', 40, 190
    @addInstructionText 'Large - slower rate, but better against tougher enemies. 3 energy per', 40, 215
    @addInstructionText '              shot. Shortcut: "2"', 40, 240
    @addInstructionText 'Burst - slow strong shot that bursts into 5 shots after hitting', 40, 265
    @addInstructionText '              8 energy per shot. Shortcut: "3"', 40, 290

    @addInstructionText 'And there are 3 firing modes:', 40, 325

    @addInstructionText 'Single - single turret, fastest rate of fire. Shortcut: "Q"', 40, 360
    @addInstructionText 'Triple - use 3 turrets but fire rate is halved. Shortcut: "W"', 40, 385
    @addInstructionText 'Bomb - slowest fire rate, drop a bomb that explodes into 10 shots after', 40, 410
    @addInstructionText '             a short delay. Shortcut: "E"', 40, 435


    @addText 'Previous Page', 400, 500, true
    @addText 'Back to Main Menu', 400, 550, false

  displayTutorial: ->
    @clearText()
    @titleText.visible = false
    if @game.gameType is 'Time Attack'
      text = '  Time Attack  '
      @addTutorialText "Reach #{15000 / @game.lengthMultplier} kills or destroy an", 400, 155, true
      @addTutorialText "Elite Fighter as soon as possible.", 400, 195, true
    else
      text = '  Survival  '
      @addTutorialText "Destroy as many enemies as possible.", 400, 155, true
      @addTutorialText "You will lose energy every minute.", 400, 195, true

    @menuTexts[text] = @add.bitmapText(400, 90, 'Airborne', text, 80)
    Gunner.center(@menuTexts[text])

    @addTutorialText "Click or tap screen to shoot. Different firing modes", 400, 260
    @addTutorialText "can be selected at the bottom by clicking/tapping.", 400, 285

    @addTutorialText "Shooting consumes energy, destroying enemies provide energy.", 400, 330
    @addTutorialText "Tougher enemies give more energy but still count as 1 kill.", 400, 355
    
    @addTutorialText "Enemies cannot damage you, but it's game over if you", 400, 400
    @addTutorialText "waste all of your energy (i.e. reaches 0)", 400, 425

    @addText 'Proceed to Game', 400, 500, true
    @addText 'Skip this screen from now on', 400, 550, false

  displayHighScores: ->
    @clearText()
    @addText ' Time Attack ', 230, 300, true
    @addText ' Survival ', 570, 300, true
    @addTutorialText 'Quick: ' +
      if Store.get("bestTime-5")?
        Gunner.timeDisplay(parseInt(Store.get("bestTime-5")))
      else
        'n/a'
      , 230, 340
    @addTutorialText 'Normal: ' +
      if Store.get("bestTime-2")?
        Gunner.timeDisplay(parseInt(Store.get("bestTime-2")))
      else
        'n/a'
      , 230, 370
    @addTutorialText 'Extended: ' +
      if Store.get("bestTime-1")?
        Gunner.timeDisplay(parseInt(Store.get("bestTime-5")))
      else
        'n/a'
      , 230, 400

    @addTutorialText ' Quick: ' +
      if Store.get("survival-5")?
        Store.get("survival-5") + ' kills '
      else
        'n/a '
      , 570, 340
    @addTutorialText ' Normal: ' +
      if Store.get("survival-2")?
        Store.get("survival-2") + ' kills '
      else
        'n/a '
      , 570, 370
    @addTutorialText ' Extended: ' +
      if Store.get("survival-1")?
        Store.get("survival-1") + ' kills '
      else
        'n/a '
      , 570, 400
    @addText 'Back to Main Menu', 400, 510, true

  clearText: ->
    text.destroy() for key, text of @menuTexts
    sprite.destroy() for key, sprite of @bitmapData
    image.destroy() for image in @menuImages

  displayCredits: ->
    @clearText()
    @titleText.visible = false
    @addInstructionText 'Credits', 400, 50, true

    @addCreditsText 'Copyright (c) 2014 Bryan Bibat.', 50, 100, "http://bryanbibat.net"
    @addCreditsText 'Made with Phaser 2.0.7', 375, 100, "http://phaser.io"
    @addCreditsText 'Sprites (c) 2002 Ari Feldman,', 50, 135, "www.widgetworx.com/spritelib/"
    @addCreditsText 'Sounds (c) 2013 dklon (Devin Watson),', 350, 135, "http://opengameart.org/users/dklon"
    @addCreditsText '"Airborne" font (c) 2005 Charles Casimiro Design,', 50, 170, "http://charlescasimiro.com/airborne.html"
    @addCreditsText '"Special Elite" font (c) 2011 Astigmatic (Brian J. Bonislawsky)', 50, 205, "http://www.astigmatic.com/"


    share = @addInstructionText 'Spread the word:', 210, 300, true

    book = @addTypewriterText "Read a book on how to make", 570, 280, 22, 'both', "https://leanpub.com/html5shootemupinanafternoon"
    book2 = @addTypewriterText "HTML5 games like this:", 570, 305, 22, 'both', "https://leanpub.com/html5shootemupinanafternoon"

    url = encodeURIComponent("http://datenshizero.github.io/gunner/")
    ogUrl = encodeURIComponent("<%= image_path 'opengraph.png' %>")
    text = encodeURIComponent("Play Gunner, a WWII themed HTML5 game where you destroy waves of enemy planes and ships")
    fullUrl = "https://twitter.com/intent/tweet?url=#{url}&text=#{text}"
    
    @addIcon 110, 370, 'twitter', fullUrl
    fullUrl ="https://www.facebook.com/dialog/share?app_id=488047311326879&href=#{url}&display=page&redirect_uri=https://facebook.com"
    @addIcon 210, 370, 'facebook', fullUrl
    fullUrl = "http://www.tumblr.com/share/link?url=#{url}&name=Gunner&description=#{text}"
    @addIcon 310, 370, 'tumblr', fullUrl
    fullUrl = "http://www.pinterest.com/pin/create/button/?url=#{url}&media=#{ogUrl}&description=#{text}"
    @addIcon 160, 470, 'pinterest', fullUrl
    fullUrl = "https://plus.google.com/share?url=#{url}"
    @addIcon 260, 470, 'gplus', fullUrl

    @addIcon 570, 420, 'book', "https://leanpub.com/html5shootemupinanafternoon"

    @addText 'Back to Main Menu', 400, 560, true

  addIcon: (x, y, filename, url) ->
    icon = @add.sprite(x, y, 'assets', filename)
    icon.anchor.setTo(0.5, 0.5)
    icon.inputEnabled = true
    icon.events.onInputDown.add( ->
      win = window.open(url, '_blank')
      win.focus()
    , this)
    @menuImages.push icon

Gunner.MainMenu = MainMenu
