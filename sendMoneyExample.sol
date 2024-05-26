//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract WalletContract { 

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function deposit() public payable{
        payable(msg.sender).transfer(msg.value);

    }

    function withdrawAll() public{
        payable(msg.sender).transfer(getContractBalance());
    }

    function withdrawToAddress(address payable to) public payable {
        to.transfer(getContractBalance());
    }
  
}
