local class = require "oop"

testclass = class("testclass")
 
function testclass:constructor(message)

    self.fields.message = message

end

function testclass:sayHi()

    return self.fields.message

end