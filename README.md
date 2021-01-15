# The cnto-additions repository

This is a place for miscellaneous Arma 3 tweaks - Configs, SQF code, etc.
to be distributed and used by the Carpe Noctem Tactical Operations gaming
community. Others are free to use them (per the license terms) too!

# How to contribute

If you're a CNTO member, see
[this related forum thread](https://www.carpenoctem.co/forums/m/26081621/viewthread/33385072-git-workflow-for-contributors/post/139340463),
otherwise please follow general github contribution practices - create a fork,
make and commit a change, create a pull request against the `dev` branch.

# How to build

## The PBO Manager method

[PBO Manager](https://www.armaholic.com/page.php?id=16369) is an older tool,
but still in heavy use by CNTO. To use it, simply

1. Enter the `addons` folder
1. For each subfolder there,
   1. right-click on it
   1. PBO Manager --> Pack into "something.pbo"
   1. (optionally, delete the folder, only the `.pbo` is used by the game)

## The armake / armake2 method

[Armake](https://github.com/KoffeinFlummi/armake) is/was a community-made tool
to replaced old Mikero's tools and BI's Addon Builder. Later,
[Armake2](https://github.com/KoffeinFlummi/armake2) was created as a rewrite
of Armake(1) from C to Rust, but the tools have very similar/identical
functionality. One advantage of the older Armake(1) are binary builds available
for [download](https://github.com/KoffeinFlummi/armake/releases/download/v0.6.3/armake_v0.6.3.zip)
whereas you have to compile Armake2 from source code yourself.

Armake is meant to be used from batch scripts or manually on a command line
(ie. `cmd.exe`). See its `--help`:

    armake binarize [-f] [-w <wname>] [-i <includefolder>] <source> [<target>]
    armake build [-f] [-p] [-w <wname>] [-i <includefolder>] [-x <xlist>] [-k <privatekey>] [-s <signature>] [-e <headerextension>] <folder> <pbo>
    armake inspect <pbo>
    armake unpack [-f] [-i <includepattern>] [-x <excludepattern>] <pbo> <folder>
    armake cat <pbo> <name>
    armake derapify [-f] [-d <indentation>] [<source> [<target>]]
    armake keygen [-f] <keyname>
    armake sign [-f] [-s <signature>] <privatekey> <pbo>
    armake paa2img [-f] <source> <target>
    armake img2paa [-f] [-z] [-t <paatype>] <source> <target>

Specifically, to build cnto-additions, call this for every folder (called ie.
`something`) in `addons`:

    armake build -p something something.pbo

# Coding style

Please take a look at other `addons` to get a general idea for the coding
style that should be maintained. Code is art and there are no hard rules
like "80 characters per line" here, but, in general, your code should be

1. **Consistent** - if you're using `or` and `and`, don't mix it with `||`
   and `&&`, if you're using CamelCase for variables, don't use snake_case for
   other variables elsewhere, if you're spacing out `{ ... }`, don't use `{...}`
   elsewhere, etc.
   1. If editing an existing addon, follow its code style as close as possible
1. **Clean** - don't leave extra spaces at the end of lines, end files with
   a newline, don't mix tabs and spaces for indent, etc.
1. **Performant** - don't waste resources unless you have to, Pull Request
   reviewers will hopefully suggest improvements
1. **Tolerant** - don't use global variables unless really needed, prefix any
   global identifiers with `cnto_`, followed by your addon name, at least

Don't let this put you off - it's here so that others can maintain your code
in case you disappear, and to set some common language. The above describes
an ideal situation, "ugly" code that works well is still good code.

Pull Request reviews will hopefully have some feedback.

# License / copying

Please see each subfolder inside `addons` for `COPYING`, `LICENSE` and
similar files, with or without a `.txt` file extension - if present, these
dictate the license for that specific addon. If you wish to use and/or
distribute this collection of addons, you need to remove addons which license
doesn't allow you to do so from your distributed copy.

If a `COPYING` or `LICENSE`, with or without a `.txt` extension, doesn't
exist for a particular addon, the global `COPYING.txt` file in the root of
this repository applies.
