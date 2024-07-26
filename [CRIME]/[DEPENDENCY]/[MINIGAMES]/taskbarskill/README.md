
Przykład

```lua
RegisterCommand("minigame", function()
    local finished = exports["taskbarskill"]:taskBar(3700, 1)
    if finished == 100 then 
        print('done')
    end
end)
```
