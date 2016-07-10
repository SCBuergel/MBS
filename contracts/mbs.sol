contract mortgageContract {
    address owner;
    payments[] recPayments;
    
    struct payments {
        uint time;
        address sender;
        uint amount;
    }
    
    function mortgageContract() {
        // constructor
        owner = msg.sender;
    }
    
    function () {
        // default function called whenever the contract receives Ether
        recPayments.push(payments(now, msg.sender, msg.value)); 
    }
    
    function getNumPayments() constant returns (uint l) {
        l = recPayments.length;
    }
    
    function getPayment(uint i) constant returns (uint time, address sender, uint amount) {
        time = recPayments[i].time;
        sender = recPayments[i].sender;
        amount = recPayments[i].amount;
    }
}

contract mbsContract {
    address owner;
    mapping(address => uint) tokenBalance;
    uint totalTokenSupply;
    
    modifier isOwner () {
        if (msg.sender != owner)
            throw;
        else
            _
    }
    
    function mbsContract (uint supply) {
        // constructor
        owner = msg.sender;
        tokenBalance[msg.sender] = supply;
        totalTokenSupply = supply;
    }
    
    function transferTokens (address to, uint amount) {
        if (tokenBalance[msg.sender] < amount)
            throw;
        else {
            tokenBalance[msg.sender] -= amount;
            tokenBalance[to] += amount;
        }
    }
    
    function getMyBalance() constant returns (uint b) {
        b = tokenBalance[msg.sender];
    }
    
    function getBalance(address accountOwner) constant returns (uint a) {
        // get someone else's balance (note: some*one* includes contracts,
        //   do we need a new pronoun?!)
        a = tokenBalance[accountOwner];
    }
}
