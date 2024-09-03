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

function ae2_lib.requestRecipeCancel(recipe, amount, cpuId)
    component = require("component")
    os = require("os")

    me = component.me_interface
    cpu = me.getCpus()[cpuId]
    recipe.request(amount, False, cpu["name"])
    os.sleep(1)
    cpu.cpu.cancel()
end