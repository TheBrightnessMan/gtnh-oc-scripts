component = require("component")
os = require("os")
ae2_lib = require("ae2_lib")
gt = component.gt_machine

recipe = ae2_lib.getRecipe("Input Polyaluminium Chloride")
if recipe == nil then error("Recipe not found!") end
print("Recipe found!")

while true do
    print("Starting cycle...")
    if gt.getWorkMaxProgress() == 0 then
        print("Machine disabled, sleep 10...")
        os.sleep(10)
    else
        info = gt.getSensorInformation()
        amount_str = info[4]
        length = string.len(amount_str)
        amount = tonumber(string.sub(amount_str, 48, length - 1))

        if amount == 0 then
            print("Requesting fluids...")
            ae2_lib.requestRecipeCancel(recipe, 1, 1, 1)
        end

        diff = (2400 - gt.getWorkProgress()) // 20
        print("Sleeping for " .. tonumber(diff + 3) .. " seconds...")
        os.sleep(diff + 3)
    end
end