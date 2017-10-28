pragma solidity ^0.4.15;

contract OffChainDebt {
    address owner;
    mapping(address => uint) public debt;
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    function OffChainDebt() public {
        owner = msg.sender;
    }
    
    function take(uint amount) public {
        require(debt[msg.sender] + amount >= debt[msg.sender]);
        debt[msg.sender] += amount;
    }
    
    function repay(address debtor, uint amount) public onlyOwner {
        require(debt[debtor] - amount <= debt[debtor]);
        debt[debtor] -= amount;
    }
}
