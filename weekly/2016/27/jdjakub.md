**Tuesday**

Tried installing OPAM and OCaml etc on Windows:

Follow the instructions on https://github.com/protz/ocaml-installer/wiki, up to the final Sanity Check
`Env var OCAMLLIB` exists, so I "clean it up" - removing it, I assume, from my environment. However I can only do so for my current cmd session using SET, and it doesn't show up in systemwide environment variables so I assume it must be part of my user account's environment. Unfortunately I cannot change or access those; "edit environment variables for your account" shows no dialog, nothing (this has been a problem on my machine for a while, but I've never needed the feature till now). So I decide to unset OCAMLLIB in my Cygwin terminal, as it will at least persist for that session. I get to running opam install depext-cygwinports, but I get errors and unfortunately the others are not able to fix.

Later I open Cygwin terminal again. I forget to source .bashrc and run opam install depext-cygwinports and to my surprise it works. I then opam install zarith batteries stdint etc. and it also works, although I have to use the "fake install" steps in the Troubleshooting section. I then look at https://github.com/realworldocaml/book/wiki/Installation-Instructions and opam install core utop, but I get:
  `[ERROR] core is not available because your system doesn't comply with os != "win32" & ocaml-version = "4.02.3"`

I also read at the beginning of the article that Core is unsupported on Windows. So maybe I will have to go through the hassle of installing an Ubuntu VM after all, since my existing one is at home on my external hard drive.

opam install'd core utop on Ubuntu. Initially had some issues with an older version but fixed them.

**Wednesday**

Begin by installing the next list of packages. During the process I get one

 `Building conf-zlib.1:
   pkg-config zlib
 [ERROR] The compilation of conf-zlib.1 failed`

I later end up with detailed error descriptions (as well as one for cohttp) giving "Out of space" errors - I'd given it the default size of 8GB, and I'd used a fixed-size virtual disk so it can't just be resized!

After wasting time grappling with VirtualBox to accept my new 512GB dynamic vdi, I now need to expand the partition or something. But I know nothing about it, and it involves boot-level munging of irreversible operations and I am seriously not interested in reinstalling the VM along with all the OCaml/OPAM stuff that took absolutely ages yesterday (and will probably take even longer, given my new VDI is dynamic). Instead I resolve to see what I can do in OCaml without zlib or cohttp installed in OPAM.

Not a great deal, it seems. For when I type in utop to my terminal (now using the old 8GB disk) all I get is
Fatal error: unknown C primitive `unix_has_symlink`

I would be surprised if this had anything to do with the lack of zlib or cohttp, since they were opam packages presumably for development. I google a bit, find similar looking errors, and do eval `opam config env`, try again and this time I'm finally in.

And it only took two whole days!

Later, we get to Docker, where I continue getting through Real World OCaml and receive a licence key for Windows 10 Professional - thanks Dr. Titmus.

**Thursday**

I begin the day by attempting the Windows 10 Pro upgrade three times in a row, using the official channels. Frustratingly, each time, after the restart, it appears as if nothing has happened. I'm still on Home. Maybe it would be better after all to just get a computer at Docker and the CL.

I talk to Graham Titmus and download the Win10 Multiple Editions ISO from DreamSpark. It tells me I'll need to burn it to a boot disk, so I go back to Titmus' office to ask - he isn't there, so after a while I go back and e-mail him, continuing with R.W.O in the meantime.

The time comes to run corebuild on my VM. I do so, and I get the "out of memory" error, because I'm still using the 8GB disk. I thought I could get away with it.

Titmus arrives and gives me a disk. I burn the ISO to the disk. I go through the setup process and, after many loooong waits eventually come to the final setup screen. "You have chosen to: install Windows Home" nope, I never chose anything like that, or even had any options. Google told me that the Multiple Editions version contained both Home AND Professional - and that it would ask me which one I would like.

 `C:\WINDOWS\system32>dism /Get-WimInfo /WimFile:D:\sources\install.wim
  Deployment Image Servicing and Management tool
  Version: 10.0.10586.0`

 `Details for image : D:\sources\install.wim`

 `Index : 1
  Name : Windows 10 Pro
  Description : Windows 10 Pro
  Size : 14,516,205,352 bytes`

 `Index : 2
  Name : Windows 10 Home
  Description : Windows 10 Home
  Size : 14,431,121,717 bytes`

The operation completed successfully.

So it does contain Pro. Why didn't it acknowledge this? Perhaps I need to boot from the disc instead.

I can't seem to boot from it. Instead I enter in the new code to System > Activation. This time it takes a LOT longer ... but ultimately ends up just like the other attempts.

I give up. I'll use my VM.

Increased primary partition, shouldn't have any (of the same) problems now.

 `$ eval `opam config env`
  $ opam install -y async yojson core_extended core_bench cohttp async_graphics cryptokit menhir merlin`

 `...`

```
 `#=== ERROR while installing conf-zlib.1 =======================================#
  # opam-version 1.2.0
  # os           linux
  # command      pkg-config zlib
  # path         /home/jdj27/.opam/4.03.0/build/conf-zlib.1
  # compiler     4.03.0
  # exit-code    1
  # env-file     /home/jdj27/.opam/4.03.0/build/conf-zlib.1/conf-zlib-5816-d2c37b.env
  # stdout-file  /home/jdj27/.opam/4.03.0/build/conf-zlib.1/conf-zlib-5816-d2c37b.out
  # stderr-file  /home/jdj27/.opam/4.03.0/build/conf-zlib.1/conf-zlib-5816-d2c37b.err`
```

Googled, performed some magic, got it to work.

Continuing with RWO, this time much faster and more productively since I now have something to type into.

**Friday**

Just did RWO today, finally, was nice - got through several chapters, now up to chapter 8 (Imperative programming).
