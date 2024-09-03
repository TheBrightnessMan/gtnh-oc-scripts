component = require("component")
os = require("os")
ae2_lib = require("ae2_lib")
gt = component.gt_machine

inc_pH = ae2_lib.getRecipe("Inc pH")
dec_pH = ae2_lib.getRecipe("Dec pH")

if inc_pH == nil then error("Inc pH recipe not found!") end
if dec_ph == nil then error("Dec pH recipe not found!") end

while true do
    if gt.getWorkMaxProgress() == 0 then
        os.sleep(10)
    else
        info = gt.getSensorInformation()
        amount_str = info[3]
        length = string.len(amount_str)
        amount = tonumber(string.sub(amount_str, 22, length - 3))

        if amount ~= 7 then
            diff = amount - 7
            if diff < 0 then
                ae2_lib.requestRecipeCancel(inc_pH, - diff // 0.01, 1)
            else
                ae2_lib.requestRecipeCancel(dec_pH, diff // 0.01, 1)
            os.sleep(3)
    end
end