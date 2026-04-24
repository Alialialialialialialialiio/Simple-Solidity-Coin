// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HusenToken { // تغيير اسم العقد من main إلى اسم معبر

    address public owner;
    string public name = "Husen Coin";
    string public symbol = "HSN";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    // تغيير اسم الـ mapping ليكون "balanceOf" وهو الاسم القياسي في ERC-20
    mapping(address => uint256) public balanceOf;

    constructor() {
        owner = msg.sender;
    }

    // تغيير اسم الـ modifier ليكون "onlyOwner" وهو المتعارف عليه عالمياً
    modifier onlyOwner() {
        require(owner == msg.sender, "Caller is not the owner");
        _;
    }

    // دالة الطباعة (تستخدم المسمى القياسي للمتغيرات)
    function mint(uint256 _amount) public onlyOwner {
        totalSupply += _amount;
        balanceOf[msg.sender] += _amount;
    }

    // دالة الإيداع
    function deposit() public payable {
        require(msg.value > 0, "Must send ETH");
        balanceOf[msg.sender] += msg.value;
        totalSupply += msg.value;
    }

    // تغيير اسم الدالة من withrda (التي بها خطأ إملائي) إلى المسمى القياسي "withdraw"
    function withdraw(uint256 _amount) public {
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance");
        
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;

        payable(msg.sender).transfer(_amount);
    }
}
