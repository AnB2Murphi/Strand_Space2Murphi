AnB2Murphi
====
AnB2Murphi is an automatic translator AnB2Murphi to bridge the gap between high-level Alice&Bob specifications and low-level Murphi model checker, which can help verify the security protocol described in the A&B specifications.<br>
theory files for paper:<br>
---
*AnB2Murphi: A Translator for Converting Alice\&Bob Specifications to Murphi*<br>
>The main security protocols proved are:<br>
>>|Protocols | Unsatisfied  | Time (sec.) | Memory|
>>|:---:|:---:|:---:|:---:|
>>|Needham-Schroder public key| secrecy(Nb)|0.10|56|
>>|Needham-Schroder public key|weakB|0.15|56|
>>|Lowe's fixed Needham-Schroder public key| no error|0.10|56|
>>|Diffie-Hellman key exchange|secrecy(Na)|0.10|64|
>>|Otway-Rees |no error|2.13|177| 
>>|CCITT X.509(1)|secrecy(Ya)|0.21|53| 
>>|CCITT X.509(1)|weakB|0.84|53| 
>>|CCITT X.509(1)|weakA|0.84|53| 
>>|CCITT X.509(1c)|no error|0.45|53| 
>>|Woo and Lam Pi|secrecy(Nb)|0.10|69| 
>>|Andrew Secure RP|secrecy(Kab)|2.77|54| 
>>|EAP-TLS authentication|secrecy(prekey)|1.21|1700| 
>>|EAP-TLS authentication|weakC|151.55|1700| 
