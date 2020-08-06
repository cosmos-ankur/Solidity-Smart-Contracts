pragma solidity 0.6.0;  
contract myBusiness{
    address payable public owner;
    enum Statuses {Vacant,Occupied}
    Statuses currentstatus;
    struct customer{
        uint id;
        uint account;
        uint amount;
    }
    constructor() public{
        owner = msg.sender;
        currentstatus = Statuses.Vacant;
        
    }
    customer[] public record;
    uint public nextId;
    
    function create(uint account , uint amount) public{
        record.push(customer(nextId,account,amount));
    }
    modifier onlywhenFree(){
        require(currentstatus==Statuses.Vacant,'Current not in stock');
        _;
    }
    modifier price(uint _amount){
        require(msg.value>_amount,'Not Enough Price Paid');
        _;
    }
    function pay() public payable onlywhenFree price(2 ether){
        currentstatus = Statuses.Occupied;
        owner.transfer(msg.value);
        
    }
    function checkStatus() view public returns(Statuses) {
        return currentstatus;
    }
    function freeStatus() public {
        currentstatus = Statuses.Vacant;
    }
    
}