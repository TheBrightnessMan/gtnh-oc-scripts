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

function ae2_lib.getCpuByName(cpuName)
    me = require("component").me_interface
    for _, v in pairs(me.getCpus()) do
        if v.name == cpuName then
            return v
        end
    end
    return nil
end

return ae2_lib
