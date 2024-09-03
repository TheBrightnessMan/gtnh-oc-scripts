component = require("component")
os = require("os")
ae2_lib = require("ae2_lib")
gt = component.gt_machine

inc_pH = ae2_lib.getRecipe("Inc pH")
dec_pH = ae2_lib.getRecipe("Dec pH")

if inc_pH == nil then error("Inc pH recipe not found!") end
if dec_pH == nil then error("Dec pH recipe not found!") end

print("Both recipes found!")

while true do
    print("Starting cycle...")
    if gt.getWorkMaxProgress() == 0 then
        print("Machine disabled, sleep 10...")
        os.sleep(10)
    else
        info = gt.getSensorInformation()
        amount_str = info[4]
        length = string.len(amount_str)
        amount = tonumber(string.sub(amount_str, 22, length - 3))

        if amount ~= 7 then
            diff = amount - 7
            print("diff: " .. tostring(diff))
            if diff < 0 then
                recipe_count = - diff // 0.01
                print("Request pH increase " .. tonumber(recipe_count) .. " times")
                ae2_lib.requestRecipeCancel(inc_pH, recipe_count, 1, 2)
            else
                recipe_count = diff // 0.01
                print("Request pH decrease " .. tonumber(recipe_count) .. " times")
                ae2_lib.requestRecipeCancel(dec_pH, recipe_count, 1, 2)
            end
        end
        os.sleep(2)
    end
end