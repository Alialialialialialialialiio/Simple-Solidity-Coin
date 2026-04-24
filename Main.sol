// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HusenToken {

    string public name = "Husen Coin";
    string public symbol = "HSN";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) public balanceOf;
    // هذا الجدول ضروري لمنح صلاحيات الإنفاق (مثل التداول في المنصات)
    mapping(address => mapping(address => uint256)) public allowance;

    // الأحداث: ضرورية لكي تظهر العمليات في "سجل البلوكتشين" وتراها المحافظ
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // --- الوظائف القياسية للعملات الحقيقية ---

    // 1. دالة التحويل الأساسية (بدون إيداع أو سحب)
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Balance insufficient");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value); // إشعار الشبكة بالتحويل
        return true;
    }

    // 2. دالة الموافقة (ضرورية لعمل العملة في المنصات اللامركزية)
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // 3. دالة التحويل نيابة عن شخص (تستخدمها المنصات لبيع عملتك)
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from], "Balance insufficient");
        require(_value <= allowance[_from][msg.sender], "Allowance exceeded");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    // --- وظائفك الخاصة التي أضفتها أنت ---

    function mint(uint256 _amount) public onlyOwner {
        totalSupply += _amount;
        balanceOf[msg.sender] += _amount;
        emit Transfer(address(0), msg.sender, _amount);
    }

    function deposit() public payable {
        require(msg.value > 0, "Must send ETH");
        balanceOf[msg.sender] += msg.value;
        totalSupply += msg.value;
        emit Transfer(address(0), msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) public {
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance");
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        payable(msg.sender).transfer(_amount);
        emit Transfer(msg.sender, address(0), _amount);
    }
}
