// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// استيراد المعيار العالمي للعملات (مثل #include في C)
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// نحن هنا نرث (Inherit) كل مميزات العملة العالمية
contract HusenToken is ERC20, Ownable {

    // تحديد سعر الصرف: 1 إيثيريوم = 1000 عملة من عملتي
    uint256 public constant TOKEN_PRICE = 1000; 

    // إرسال اسم العملة ورمزها للمحرك الأساسي
    constructor() ERC20("Husen Coin", "HSN") Ownable(msg.sender) {
        // طباعة مليون عملة للمالك عند البداية
        _mint(msg.sender, 1000000 * 10**decimals());
    }

    // دالة الطباعة الاحترافية (محمية بـ onlyOwner تلقائياً)
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // دالة شراء العملات مقابل الإيثيريوم (منطق سوق حقيقي)
    function buyTokens() public payable {
        require(msg.value > 0, "Send ETH to buy tokens");
        
        uint256 amountToBuy = msg.value * TOKEN_PRICE;
        _mint(msg.sender, amountToBuy);
    }

    // سحب الإيثيريوم من العقد بأمان تام
    function withdrawETH() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No ETH to withdraw");
        
        (bool sent, ) = owner().call{value: balance}("");
        require(sent, "Failed to send Ether");
    }
}
