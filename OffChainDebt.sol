pragma solidity ^0.4.15;

contract OffChainDebt {
    address public owner;
    mapping(address => uint) public debt;
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    event TakeDebt(address debter, uint amount);
    event RepayDebt(address debter, uint amount);
    
    function OffChainDebt() public {
        owner = msg.sender;
    }
    
    function take(uint amount) public {
        require(debt[msg.sender] + amount >= debt[msg.sender]);
        debt[msg.sender] += amount;
        TakeDebt(msg.sender, amount);
    }
    
    function repay(address debtor, uint amount) public onlyOwner {
        require(debt[debtor] - amount <= debt[debtor]);
        debt[debtor] -= amount;
        RepayDebt(debtor, amount);
    }
}
