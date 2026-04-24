// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract main {

address public owner;
string public name = "Husen Coin";
string public symbol = "HSN";
uint8 public decimals = 18;


uint256 public totalSupply;


constructor(){
owner = msg.sender;

}
modifier ledar(){
require(owner==msg.sender,"not owner");

    _;
}

mapping(address=>uint) public balances;


function mint(uint256 _amount) public ledar {
    totalSupply += _amount;
    balances[msg.sender] += _amount;
}

function deposit() public payable {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
        totalSupply+=msg.value;
    }
function withrda(uint256 _amount )public {
require(balances[msg.sender] >= _amount, "Insufficient balance");
balances[msg.sender]=balances[msg.sender]-_amount;
totalSupply -= _amount;

payable(msg.sender).transfer(_amount);



}

}


