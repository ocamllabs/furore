* I fixed some bug with parsing of email and header
* I implemented the RFC 5321 (to have a literal domain in an email) and use Ipaddr library for this part
* I implemented the validator website (http://oklm-wsh.github.io/Validator/validator.html) with some tests of email
* I implemented the header fields from RFC 2045
* I attacked the implementation of RFC 2046 (a multipart email)
* I implemented a PPX to inject an IANA database in MrMime project (and I talked about that with Rudy for an integrate of that in Cohttp maybe)

I talked with Richard Mortier and I think I will avoid the implementation of RFC 3798 (to permit a long parameter in a Content-Type field) and move fast to the implementation in a unikernel when I finish the multipart. So I think it is the last last RFC (to much RFC ...).
