AnB2Murphi
====
AnB2Murphi is an automatic translator to bridge the gap between high-level Alice&Bob specifications and low-level Murphi model checker, which can help verify the security protocol described in the A&B specifications.<br>


Theory protocol for paper<br>
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

Difficulty<br>
---
- There are three agents in Otway-Rees including Alice, Bob and Server. Besides, We implemented a mechanism for forwarding secrecy with the help of `tmp` message. When agent receives oneA message that cannot be decrypted from its own knowledge, it forwards this message tagged as `tmp` to another agent.
- Diffie Hellman is one of the earliest practical examples of public key exchange implemented within the field of cryptography which involes sophicated mathematics theories, e.g., modular exponentiation. The intruder supports the man-in-the-middle attack, which plays the role of sending the forged message to Alice and Bob respectively. Thus, Alice and Bob  thought  he was communicating with the intended agents.
- 5G EAP-TLS authentication is a practical protocol to ensure the communication security. There are four participating entities in this protocol, UE, SEAF, AUSF and SUPI. It's hard to explore the whole state space because of numerous message exchanged. Besides, EAP-TLS uses a negotiated key  as the encrypted key which is a tetrad hash message.

Installation<br>
---
In our experiment, AnB2Murphi tool is run on a PC server with macOS Catalina.<br>

Install AnB2Murphi Environment<br>

AnB2Murphi uses Ocaml 4.04.0, Murphi 5.4.9.1 and requires several ocaml libraries to run, which contains:<br>
- Menhir
- Murphi 
- Core


Usage
---
To use AnB2Murphi, you need to comfirm the your computer equipped with  Ocaml 4.04.0, Murphi 5.4.9.1, Core, and Menhir in your environment.<br>

Running the following command in terminal to verify the protocol models. In this example, we verify the Needham-Schoreder public key protocol model `NSPK.txt`.

First, execute the following command to use AnB2murphi to compile the A&B specification.

$ corebuild getModelString.byte -use-menhir 

Then, AnB2Murphi will generate the `getModelString.byte` which can help compile the source protocol into Murphi code.

$ ./getModelString.byte ./protocol/NSPK.txt

Next, the protocol is compiled into Murphi code, the output file is located in `/source-code/outputs/result.m`.

$cd outputs 

$ `cmurphi-path`/cmurphi5.4.9.1/src/mu result.m

$ g++ -o result.o result.cpp -I `cmurphi-path`/cmurphi5.4.9.1/include/ -ggdb

$ ./result.o >out1 -ndl -tv

over verification, Result: `Invariant "weakB" failed.`. State Space Explored: `79 states, 110 rules fired in 0.10s.`

This message indicates AnB2Murphi uses 79 states and 110 rules to find the counterexample path of invariant `weakB`.
