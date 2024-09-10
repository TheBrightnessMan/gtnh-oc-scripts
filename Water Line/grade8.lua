component = require("component")
os = require("os")
ae2_lib = require("ae2_lib")
gt = component.gt_machine
me = component.me_interface

recipes = {}
quarks = {}
names = {"Up", "Down", "Top", "Bottom", "Strange", "Charm"}
itemSuffix = "-Quark Releasing Catalyst"

for i = 1, 6 do
    recipes[i] = ae2_lib.getRecipe(names[i])
    if recipe[i] == nil then error("Dummy " .. names[i] .. " not found!") end

    quarks[i] = ae2_lib.getRecipe(names[i] .. itemSuffix)
    if quarks[i] == nil then error("Quark " .. names[i] .. " not found!") end

while true do
    print("Starting cycle...")
    if gt.getWorkMaxProgress() == 0 then
        print("Machine disabled, sleep 10...")
        os.sleep(10)
    else
        for i = 1, 5 do
            for j = (i+1), 6 do
                print("Inserting " .. names[i] .. ", " .. names[j])
                ae2_lib.requestRecipeCancel(recipes[i], 1, 5, 1)
                ae2_lib.requestRecipeCancel(recipes[j], 1, 5, 1)

                info = gt.getSensorInformation()
                success_String = info[#info]
                success = string.sub(success_String, 44)
                if success == "Yes" then
                    print("Combo found! (" .. names[i] .. ", " .. names[j] .. ")")
                    goto complete
                end
            end
        end
        ::complete::
        sleep = ((2400 - gt.getWorkProgress()) // 20) + 3
        print("Sleeping for " .. tonumber(sleep) .. " seconds...")
        os.sleep(sleep)
        
        print("Checking for missing quarks...")
        for i = 1, 6 do
            item = me.getItemsInNetwork({label = names[i]})
            if item.size < 10 then
                print("Requesting " .. names[i] .. "...")
                quarks[i].request(10 - item.size)
            end
        end
    end
end
