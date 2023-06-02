pragma solidity ^0.4.24;

interface IInvokeOracle{
    function requestData(address _caller, string _fsyms, string _tsyms) external returns (bytes32 requestId);
    function showPrice() external view returns(uint256);
    function showLatestPrice(bytes32 _requestId) external view returns(uint256);
}

contract CustomerContract{
    address CONTRACTADDR = 0x17E7e2607fe42A188958b4971B55BD6Fa53851c6;
    bytes32 public requestId; 
    address private owner;
    // string public fsyms;
    // string public tsyms;
    
    constructor() public {
        owner = msg.sender;
        // fsyms = fsyms;
        // tsyms = tsyms;
    }
    //Fund this contract with sufficient PLI, before you trigger below function. 
    //Note, below function will not trigger if you do not put PLI in above contract address
    function getPriceInfo(string _fsymst, string _tsymst) external returns(bytes32){
        require(msg.sender==owner,"Only owner can trigger this");
        (requestId) = IInvokeOracle(CONTRACTADDR).requestData({_caller:msg.sender,_fsyms:_fsymst,_tsyms:_tsymst}); 
        return requestId;
    }
    //TODO - you can customize below function as you want, but below function will give you the pricing value
    //This function will give you last stored value in the contract
    function show() external view returns(uint256){
        return IInvokeOracle(CONTRACTADDR).showPrice();
    }

    function showPriceOnRequestId(bytes32 _requestId) external view returns(uint256){
        return IInvokeOracle(CONTRACTADDR).showLatestPrice(_requestId);
    }

}
