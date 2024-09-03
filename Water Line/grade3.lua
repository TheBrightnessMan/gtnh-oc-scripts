component = require("component")
os = require("os")
ae2_lib = require("ae2_lib")
gt = component.gt_machine

recipe = ae2_lib.getRecipe("Input Polyaluminium Chloride")
if recipe == nil then error("Recipe not found!") end

while true do
    if gt.getWorkMaxProgress() == 0 then
        os.sleep(10)
    else
        info = gt.getSensorInformation()
        amount_str = info[4]
        length = string.len(amount_str)
        amount = tonumber(string.sub(amount_str, 48, length - 1))

        if amount == 0 then
            ae2_lib.requestRecipeCancel(recipe, 1, 1)
        end

        diff = (2400 - gt.getWorkProgress()) // 20
        os.sleep(diff + 3)
    end
end