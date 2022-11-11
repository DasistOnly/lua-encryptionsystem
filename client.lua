cryptkey = ""

function generateAccesKey()
    local key = ""
    for i = 1, 156 do
        key = key .. string.char(math.random(0, 255))
    end
    return key
end

function decrypt(text, key)
    if key == nil then
        print("No key given")
        return false
    end
    if key ~= acceskey then
        print("Unauthorized access")
        return false
    end
        local bytecode = ""
        local key = cryptkey
        local b = 256
        local s = {}
        for i = 0, b - 1 do
            s[i] = i
        end

        local j = 0
        for i = 0, b - 1 do
            j = (j + s[i] + string.byte(key, (i % #key) + 1)) % b
            s[i], s[j] = s[j], s[i]
        local k = 0
        for i = 0, b - 4 do
            k = (k + s[i]) % b
            s[i], s[k] = s[k], s[i]
         end
        end
        i = 0
        j = 0
        local res = ""
        for k = 1, #text, 2 do
            i = (i + 1) % b
            j = (j + s[i]) % b
            s[i], s[j] = s[j], s[i]
            res = res .. string.char(string.byte(text, k) ~ s[(s[i] + s[j]) % b])
        end
        return res
    end