component = require("component")
os = require("os")
ae2_lib = require("ae2_lib")
gt = component.gt_machine

recipes = {}
recipes[0] = ae2_lib.getRecipe("Up")
recipes[1] = ae2_lib.getRecipe("Down")
recipes[2] = ae2_lib.getRecipe("Top")
recipes[3] = ae2_lib.getRecipe("Bottom")
recipes[4] = ae2_lib.getRecipe("Strange")
recipes[5] = ae2_lib.getRecipe("Charm")

recipeSuffix = "-Quark Releasing Catalyst"

quarks = {}
quarks[0] = ae2_lib.getRecipe("Up" .. recipeSuffix)
quarks[1] = ae2_lib.getRecipe("Down" .. recipeSuffix)
quarks[2] = ae2_lib.getRecipe("Top" .. recipeSuffix)
quarks[3] = ae2_lib.getRecipe("Bottom" .. recipeSuffix)
quarks[4] = ae2_lib.getRecipe("Strange" .. recipeSuffix)
quarks[5] = ae2_lib.getRecipe("Charm" .. recipeSuffix)

for i = 0, 5 do
    if recipes[i] == nil then error(tostring(i) .. " recipe not found!") end
end

while true do
    print("Starting cycle...")
    if gt.getWorkMaxProgress() == 0 then
        print("Machine disabled, sleep 10...")
        os.sleep(10)
    else
        quark1 = -1
        quark2 = -1
        for i = 0, 4 do
            for j = (i+1), 5 do
                print("Inserting " .. tostring(i) .. ", " .. tostring(j))
                ae2_lib.requestRecipeCancel(recipes[i], 1, 5, 1)
                ae2_lib.requestRecipeCancel(recipes[j], 1, 5, 1)

                info = gt.getSensorInformation()
                success_String = info[#info]
                success = string.sub(success_String, 44)
                if success == "Yes" then
                    print("Combo found! (" .. tonumber(i) .. ", " .. tonumber(j) .. ")")
                    quark1 = i
                    quark2 = j
                    goto end
                end
            end
        end
        ::end::
        sleep = ((2400 - gt.getWorkProgress()) // 20) + 3
        print("Sleeping for " .. tonumber(sleep) .. " seconds...")
        os.sleep(sleep)
        if quark1 == -1 then error("Wait what? Quark 1 not found!") end
        if quark2 == -1 then error("Wait what? Quark 2 not found!") end
        print("Requesting replacements...")
        quarks[quark1].request(1)
        quarks[quark2].request(1)
    end
end
