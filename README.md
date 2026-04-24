Husen Token (Standard ERC-20) 🚀
مشروع عملة رقمية متطور مبني بلغة Solidity، يتبع المعيار العالمي ERC-20 باستخدام مكتبات OpenZeppelin لضمان أقصى درجات الأمان والاحترافية.

🌟 الميزات (Features)
ERC-20 Standard: متوافق تماماً مع جميع المحافظ والمنصات التي تدعم إيثيريوم.

Secure Minting: إمكانية طباعة عملات جديدة للمالك فقط باستخدام نظام Ownable.

Token Economy: نظام شراء عملات (Buy Tokens) مقابل الإيثيريوم بسعر صرف محدد.

Professional Security: يعتمد على مكتبات OpenZeppelin الموثوقة لمنع ثغرات الأمان الشائعة.

Liquidity Management: نظام سحب آمن للإيثيريوم من العقد باستخدام أحدث معايير Solidity (call method).

🛠 المتطلبات التقنية
Language: Solidity ^0.8.20

Framework: Remix IDE / Hardhat

Library: OpenZeppelin Contracts

📖 كيف يعمل المشروع؟ (Technical Logic)
يعتمد المشروع على مبدأ الوراثة (Inheritance) في البرمجة كائنية التوجه، حيث يرث العقد وظائف التحويل (transfer) والموافقة (approve) من المعيار القياسي، مع إضافة دالة buyTokens التي تسمح للمستخدمين بالحصول على العملة مقابل إرسال ETH للعقد.
