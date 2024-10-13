local ae2_lib = {}

function ae2_lib.getRecipe(name)
    component = require("component")
    me = component.me_interface
    craftables = me.getCraftables()
    for _, craftable in pairs(craftables) do
        item = craftable.getItemStack()
        if item["label"] == name then
            return craftable
        end
    end
    return nil
end

function ae2_lib.requestRecipeCancel(recipe, amount, cpuName, delay)
    component = require("component")
    os = require("os")
    me = component.me_interface
    cpu = nil

    component = require("component")
    me = component.me_interface
    for _, v in pairs(me.getCpus()) do
        if v.name == cpuName then
            cpu = v
        end
    end    

    recipe.request(amount, False, cpuName)
    os.sleep(delay)
    cpu.cpu.cancel()
end

return ae2_lib
