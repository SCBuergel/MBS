contract mortgageContract {
    address owner;
    payments[] recPayments;
    mbsContract mbs;
    
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
        
        // forward payment to each investor in MBS contract
        uint numInvestors = mbs.getNumInvestors();
        uint totalSupply = mbs.getTotalSupply();
        for (uint i = 0; i < numInvestors; i++) {
            address investor = mbs.getInvestor(i);
            uint tokensOfInvestor = mbs.getBalance(investor);
            uint payout = msg.value * tokensOfInvestor / totalSupply;
            investor.send(payout);
        }
    }
    
    modifier onlyOwner () {
        if (msg.sender != owner)
            throw;
        else
            _
    }
    
    function linkMbs(address mbsContractAddress) onlyOwner {
        mbs = mbsContract(mbsContractAddress);
    }
        
    function getMbs() constant returns (address a) {
        a = mbs;
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
    
    function getMyBalance() constant returns (uint i) {
        i = getEthBalance(msg.sender);
    }
}

contract mbsContract {
    address owner;
    mapping(address => uint) tokenBalance;
    uint totalTokenSupply;
    address[] investors;
    
    modifier isOwner () {
        if (msg.sender != owner)
            throw;
        else
            _
    }
    
    function mbsContract () {
        // constructor
        totalTokenSupply = 100;
        owner = msg.sender;
        tokenBalance[msg.sender] = totalTokenSupply;
        investors.push(msg.sender);
    }
    
    function transferTokens (address to, uint amount) {
        if (amount < 1)
            throw;
        if (tokenBalance[msg.sender] < amount)
            throw;
        if (tokenBalance[to] == 0)
            investors.push(to); // add new investor if they have not been an investor before

        tokenBalance[msg.sender] -= amount;
        tokenBalance[to] += amount;
        
        if (tokenBalance[msg.sender] < 1)
        {   // delete msg.sender from list of investors if it doesnt hold tokens anymore
            uint numInvestors = investors.length;
            bool foundTarget = false;
            for (uint i = 0; i < numInvestors; i++) {
                if (investors[i] == msg.sender) {
                    delete investors[i];
                    foundTarget = true;
                }
                if (foundTarget && i < numInvestors - 1)
                    investors[i] = investors[i+1];
            }
            if (foundTarget) {
                investors.length--;
            }
        }
    }
    
    function getMyTokenBalance() constant returns (uint b) {
        b = tokenBalance[msg.sender];
    }
    
    function getTokenBalance(address accountOwner) constant returns (uint a) {
        a = tokenBalance[accountOwner];
    }
    
    function getTotalSupply() constant returns (uint s) {
        s = totalTokenSupply;
    }
    
    function getNumInvestors() constant returns (uint i) {
        i = investors.length;
    }
    
    function getInvestor(uint i) constant returns (address a) {
        a = investors[i];
    }
}
