I did some technical updates in MrMime:  
* First, I added an abstraction about the operating system (Windows and Unix)
* I reorganized the project to produce a good low-level API to manipulate an email
* I finished, as you know, the encoder (and I can produce an email now)
* I optimized the Base64 and the QuotedPrintable decoder (with tailcall optimization)
* I finished the pretty-printing of an email
* I fixed some little bugs between the encoder and the decoder
* And I added the support of UTF-8 with the uutfsoftware by daniel - now, I have only 3 errors with 2000 mails (so ~0.15% fails - so MrMime is more resilient)
* I talked with Daniel about the API and the support of UTF-8 (because an email can have many encoding data) and the main thing is to normalize the email on one encoding, the UTF-8. But, for that, I need another software to normalize any encoding to UTF-8 (daniel told me who will do)
* May be, the next week, I will start the SMTP protocol with the unikernel
