//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract ExampleBoolean {

    uint public lastValueSent;
    string public lastFunctionCalled;
    string public theMessage;
    int public changeCounter;
    address public owner;

    constructor() {
        changeCounter = 0;
        owner = msg.sender; // The person who deploys the contract
    }

    // All Variables are initialized by default
    // There is no ‘null’ or ‘undefined’
    // (u)int = 0
    // Bool = false
    // String = “”
    // Every interaction on Ethereum is address-based
    // Hold 20 byte value (An Ethereum address)


    bool public myBool;
    int public myInt;  // -2^128 to 2^128
    uint public myUint;  // 0 to (2^256 - 1)
    uint8 public myUintSet = 250;  // Wrong, because setting default values can cause you more gas while deploing the contract
    
    //- Stings are extremely expensive to store on the Blockchain - 
    //While creating a string the compiler worn you for a memory issue, so you need to use memory before your variable
    string public myString = "Hello World";

    // Byte technically is the same as a string but strings take more bytes 
    // Because strings are represented as UTF8 so in strings sometimes a character is represented by 2 bytes and sometimes 1 byte 
    // so you can’t compare byte variables with string ones.
    bytes public myBytes = "Hello World";
    
    address public someAddress;

    // View functions return storage variables (variables that are stored in the contract)
    // Pure functions don’t return any storage variable, 
    // It can only call other pure functions and work with it’s variables 
    // they don’t need burning gas because they don't work with storage variables.

    // transfering ether to contract and back again requires payable function.
    
    // you can send ether or wei with the Remix value section so that the ‘ether’ will lock in the smart contract, 
    // but you can bring it out into another address.

    
    /**
    - Sending Ether without data (e.g., `address(this).call{value: 1 ether}("")`) triggers the `receive` function.
    - When Ether is sent to the contract without accompanying data, but no receive function is defined.
    - Sending Ether with data (e.g., `address(this).call{value: 1 ether}("data")`) triggers the `fallback` function.
    - Calling a non-existent function (e.g., `address(this).call(abi.encodeWithSignature("nonExistentFunction()"))`) triggers the `fallback` function.

    1. Fallback() Function
        The fallback function is triggered under two main conditions:

        When a contract receives a call for a function that does not exist.
        When Ether is sent to the contract without accompanying data, but no receive function is defined.
        
        Characteristics:
        It must be marked as payable to accept Ether.
        It has no name or arguments.
        It can optionally return data.
        Limited to minimal logic because it has a low gas stipend (2,300 gas) when invoked by plain Ether transfers.
        
        Use Cases:
        Handling unexpected function calls.
        Logging or rejecting calls with invalid data.
        Acting as a catch-all for any non-standard interactions.

    2. Receive() Function
        The receive function is a simpler and more specific way to handle plain Ether transfers. It is called when:

        Ether is sent to the contract without any data (e.g., through address.transfer() or address.send()).
        There is no matching fallback function that is payable.
        
        Characteristics:
        It must be marked as payable.
        It does not take any arguments or return any value.
        If this function is not defined, Ether transfers without data will fallback to the fallback function (if it is payable).
        
        Use Cases:
        Accepting donations.
        Acting as a wallet-like contract.
        Minimal overhead for accepting Ether transfers.
        Key Differences Between Fallback and Receive
        Feature	Fallback Function	Receive Function
        Purpose	Handles invalid function calls and Ether transfers (with or without data).	Handles Ether transfers without data.
        Definition	Must use the keyword fallback.	Must use the keyword receive.
        Data Handling	Can handle calls with or without data.	Cannot handle calls with data.
        Optional?	Optional but recommended for robust contracts.	Optional.
    */

    /**
    - **There are some security points in the above example**
    - In withdrawAllMoney always should first set sender balance to zero ( 0 ) then send money, 
       to avoid being hacked by getting money without setting balance to zero.
    - Each account(address) has access just to it’s wallet and can’t send money more than it’s balance.
    */





    uint public balanceRecieved;

    mapping(uint => bool) public myMapping;
    mapping(uint => mapping(uint => bool)) public uintUintBoolMapping;
    mapping(address => uint) public balanceReceived;
    mapping(address => uint) public balanceReceivedMapped;


    function sendMoney() public payable{
        balanceReceivedMapped[msg.sender] += msg.value;
    }

    function setMapping(uint index) public{
        myMapping[index] = true;
    }

    function setUintUintBool(uint key1, uint key2, bool value) public{
        uintUintBoolMapping[key1][key2] = value;
    }

    function withdrawAllMoney(address payable _to) public{
        uint senderMoney = balanceReceivedMapped[msg.sender];
        balanceReceivedMapped[msg.sender] = 0;
        _to.transfer(senderMoney);
        
    }

    function deposit() public payable {
		    balanceRecieved += msg.value;
    }
    
    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdrawAll() public {
        address payable to = payable(msg.sender);
        to.transfer(getContractBalance());
    }

    function withdarToAddress(address payable dst_address) public payable{
        dst_address.transfer(getContractBalance());
    }

    receive() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "reveive";
    }

    fallback() external payable {
        lastValueSent = msg.value;
        lastFunctionCalled = "fallback";
    }


    function payableUpdateString(string memory _newString) public payable{
        if (msg.value == 1 ether){
            myString =_newString;
        } else {
            payable(msg.sender).transfer(msg.value);
        }
        
    }


    function updateTheMessage(string memory _newMessage) public {
        if (msg.sender == owner){
            theMessage = _newMessage;
            changeCounter++;
        }
    }

    function addTwoUint(uint a, uint b) public pure returns(uint) {
        return a+b;
    }

    //msg.sender is the address of the person(account) who is interacting with this smart contract
    function updateSomeAddressToSender() public {
        someAddress = msg.sender;
    }

    function setSomeAddress(address _someAddress) public{
        someAddress = _someAddress;
    }

    function getAddressBalance() public view returns(uint) {
        return someAddress.balance;
    }


    function compareTwoString(string memory _myString) public view returns(bool) {
        return keccak256(abi.encodePacked(_myString)) == keccak256(abi.encodePacked(myBytes));
    }


    function setmyString(string memory _myString) public {
            myString = _myString;
    }
    

    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }

    function setMyInt(int _myInt) public {
        myInt = _myInt;
    }

    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }

    function incrementUint8() public{
        myUintSet++; // value more than 255 can get a error, but in below pragma version 0.7.8 after 255 it will turn to 0 
    }
}
