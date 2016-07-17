contract helloWorldContract {
    string greeting;
    
    function setGreeting(string g) {
        greeting = g;
    }
    
    function getGreeting() constant returns (string g) {
        g = greeting;
    }
    
    function whoAmI() constant returns (address a) {
        a = msg.sender;
    }
    
    function howManyWeiDidIsend() returns (uint i) {
        i = msg.value;
    }
}