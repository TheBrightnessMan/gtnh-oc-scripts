component = require("component")
os = require("os")
ae2_lib = require("ae2_lib")
gt = component.gt_machine

inc_pH = ae2_lib.getRecipe("NaOH")
dec_pH = ae2_lib.getRecipe("HCl")

if inc_pH == nil then error("NaOH recipe not found!") end
if dec_pH == nil then error("HCl recipe not found!") end

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
        diff = amount - 7

        if math.abs(diff) > 0.05 then
            print("diff: " .. tostring(diff))
            if diff < 0 then
                recipe_count = - diff // 0.01
                print("Request pH increase " .. tonumber(recipe_count) .. " times")
                ae2_lib.requestRecipeCancel(inc_pH, recipe_count, 2, 2)
            else
                recipe_count = diff // 0.01
                print("Request pH decrease " .. tonumber(recipe_count) .. " times")
                ae2_lib.requestRecipeCancel(dec_pH, recipe_count, 2, 2)
            end
        else
            sleep = ((2400 - gt.getWorkProgress()) // 20) + 3
            print("Sleeping for " .. tonumber(sleep) .. " seconds...")
            os.sleep(sleep)
        end
    end
end