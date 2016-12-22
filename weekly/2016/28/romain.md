* I push my big change to MrMime, so Richard launched a test with ~18 000 emails and all emails are ok (we catch no error).
* We find a performance problem (with the multipart and the quoted-printable encoding) but it's a specific problem (so when I have a time, I will fix this problem)
* But, overall, MrMime is more faster (it's the result of improvement of internal buffer)
* After, I worked on Decompress and I defunctorized the project, I optimized the translation between op-code and character and I avoided some closures allocations, but, with all this point, with Jeremy, we can't notice any imrpovement :disappointed:
* So, I will try a deforestation of Decompress and we will see if we have a good result
* For the hackaton, I worked on Decompress, but, as I said, no big change and just some experimentals modifications.
* For the next week, I will start to fix some bug in ocaml-git as Richard advised me. Voilà!
