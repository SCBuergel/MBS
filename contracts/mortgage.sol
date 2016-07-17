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
    
    modifier onlyOwner () {
        if (msg.sender != owner)
            throw;
        else
            _
    }

    function getNumPayments() constant returns (uint l) {
        l = recPayments.length;
    }
    
    function getPayment(uint i) constant returns (uint time, address sender, uint amount) {
        time = recPayments[i].time;
        sender = recPayments[i].sender;
        amount = recPayments[i].amount;
    }
    
    function getEthBalance(address a) constant returns (uint i) {
        i = a.balance;
    }
}