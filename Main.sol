// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HusenToken {
    string public name = "Husen Coin";
    string public symbol = "HSN";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // --- نظام العملة القياسي (Clean ERC-20) ---

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Transfer to zero address"); // حماية إضافية
        require(balanceOf[msg.sender] >= _value, "Low balance");
        
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Transfer to zero address");
        require(balanceOf[_from] >= _value, "Low balance");
        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    // --- نظام الخزنة المحمي (Protected Vault) ---

    // المالك يطبع عملات (هذا يزيد العرض الكلي ولا يسحب ETH)
    function mint(uint256 _amount) public onlyOwner {
        totalSupply += _amount;
        balanceOf[msg.sender] += _amount;
        emit Transfer(address(0), msg.sender, _amount);
    }

    // شراء العملة مقابل ETH
    function buyTokens() public payable {
        require(msg.value > 0, "Send ETH to buy");
        // هنا نزيد رصيد العملة فقط
        balanceOf[msg.sender] += msg.value;
        totalSupply += msg.value;
        emit Transfer(address(0), msg.sender, msg.value);
    }

    // سحب الـ ETH من العقد (للمالك أو للمستخدم حسب تصميمك)
    // استخدمنا call لضمان الأمان الأقصى
    function withdrawETH(uint256 _amount) public onlyOwner {
        require(address(this).balance >= _amount, "Contract empty");
        (bool sent, ) = owner.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }
}
