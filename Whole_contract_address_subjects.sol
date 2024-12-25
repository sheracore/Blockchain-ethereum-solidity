//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract ExampleBoolean {
    bool public myBool;
    int public myInt;  // -2^128 to 2^128
    uint public myUint;  // 0 to (2^256 - 1)
    uint8 public myUintSet = 250;  // Wrong, because setting default values can cause you more gas while deploing the contract
    
    //- Stings are extremely expensive to store on the Blockchain - 
    //While creating a string the compiler worn you for a memory issue, so you need to use memory before your variable
    string public myString = "Hello World";

    // Byte technically is the same as a string but strings take more bytes 
    //because strings are represented as UTF8 so in strings sometimes a character is represented by 2 bytes and sometimes 1 byte 
    //so you can’t compare byte variables with string ones.
    bytes public myBytes = "Hello World";
    
    address public someAddress;

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
