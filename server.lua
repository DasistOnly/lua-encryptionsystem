local cryptkey = ""

local cryptkey = string.sub(cryptkey, 1, 512)
local cryptkey = math.random(1, 1000) .. cryptkey .. math.random(1, 1000)
local cryptkey = string.reverse(cryptkey)

function generateAccesKey()
    local key = ""
    for i = 1, 156 do
        key = key .. string.char(math.random(0, 255))
    end
    return key
end

local acceskey = generateAccesKey()
function encrypt(text, key)
    if key == nil then
        print("No key given")
        return false
    end
    if key ~= acceskey then
        print("Unauthorized access")
        return false
    end
    if type(text) ~= "string" then
    print("Text is not a string")
    return nil
    end
    if #text == 0 then
    print("Text is empty")
    return nil end
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
    for k = 1, #text do
        i = (i + 1) % b
        j = (j + s[i]) % b
        s[i], s[j] = s[j], s[i]
        local xor = s[(s[i] + s[j]) % b]
        local byte = string.byte(text, k)
        local enc = xor ~ byte
        bytecode = bytecode .. string.char(enc)
        res = res .. string.char(xor ~ byte)
        res = res .. string.char(string.byte(text, k) ~ s[(s[i] + s[j]) % b])
    end
    return res
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

encryptedword = encrypt("I like bread", acceskey)
print(encryptedword)

decryptedwork = decrypt(encryptedword, acceskey)
print(decryptedwork)