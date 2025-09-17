screen = {nil, nil}
offset = {nil, nil}
camera = {'camGame', 'camHUD', 'camOther'}

function onCreate()
  for i, r in pairs({'Width', 'Height'}) do
    setOnScripts('screen'..r, getPropertyFromClass('openfl.Lib', 'application.window.display.bounds.'..r:lower()))
  end

  for i=0,1 do
    runHaxeCode([[
    FlxG.signals.postUpdate.addOnce(function(){
        FlxG.state.subState.members[]]..i..[[].scale.x = ]]..(screen[1] or getPropertyFromClass('openfl.Lib', 'application.window.display.bounds.width')*2)..[[;
      });
    ]])
  end
end

function onCreatePost()
  for i, cam in pairs(camera) do
    for ii,wh in pairs({'width', 'height'}) do
      setProperty(cam..'.'..(ii == 1 and 'x' or 'y'), (-((screen[ii] or getPropertyFromClass('openfl.Lib', 'application.window.display.bounds.'..wh)) + (ii == 1 and -1280 or -720)) / 2) + (offset[ii] or 0))
      setProperty(cam..'.'..wh, screen[ii] or getPropertyFromClass('openfl.Lib', 'application.window.display.bounds.'..wh))
    
      if cam:lower() == 'camgame' then
        setProperty('camGame.targetOffset.'..(ii == 1 and 'x' or 'y'), -((screen[ii] or getPropertyFromClass('openfl.Lib', 'application.window.display.bounds.'..wh)) + (ii == 1 and -1280 or -720)) / 2)
      elseif cam:lower() == 'camhud' then
        setProperty('camHUD.'..(ii == 1 and 'x' or 'y'), 0)
      end
    end

    if cam:lower() == 'camother' then
      setProperty('camOther.y', (-(getPropertyFromClass('openfl.Lib', 'application.window.display.bounds.height')-720) / 2) + 80)
    end
  end
end

function onPause()
  runHaxeCode([[
  FlxG.signals.postUpdate.addOnce(function(){
      FlxG.state.subState.members[0].scale.set(]]..(screen[1] or getPropertyFromClass('openfl.Lib', 'application.window.display.bounds.width')*2)..[[, ]]..(screen[2] or getPropertyFromClass('openfl.Lib', 'application.window.display.bounds.height'))..[[);
    });
  ]])
end
--script by marshverso#0000 and helper sowyokay#0000