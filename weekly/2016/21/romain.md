* I updated MrMime with a new program maildir. You can execute this program with ./maildir -p /path/to/your/mails/ -n LFif the newline of your email is LF character (and it's probably your case with mac osx). I retrieve two difficulties about the parsing:
 - The difficulty to predict the end of the email - so may be you catch an infinite loop when you scan your emails
 - The latency with Base64 and QuotedPrintable decoder (because, for each character, we need to try the boundary parser to stop the decoder)
* So you can use the project on two way. The first way is to use maildirbinary. But if you catch a infinite loop for example (or a weird exception), you can try with a specific email with utop -init test.ml(the second way). At this moment, you can compile the project with debug information (with ./configure --enable-trace and make install) and see where MrMime fails. The parsing is resilient with the malformed header. So now, I will implement the pretty-printing of email and prove if the parsing and pretty-printing is bijective (just to be on the safe side).

(you need to configure the project with --enable-teststo get the maildirbinary)
