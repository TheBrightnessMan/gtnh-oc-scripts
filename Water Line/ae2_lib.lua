function getRecipe(name)
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

function requestRecipeCancel(recipe, amount, cpuId)
    component = require("component")
    os = require("os")

    me = component.me_interface
    cpu = me.getCpus()[cpuId]
    recipe.request(amount, False, cpu["name"])
    os.sleep(1)
    cpu.cpu.cancel()
end