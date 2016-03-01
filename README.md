# Ojsubmitter

[![Gem Version](https://badge.fury.io/rb/ojsubmitter.svg)](https://badge.fury.io/rb/ojsubmitter) [![Build Status](https://travis-ci.org/hadrori/ojsubmitter.svg?branch=master)](https://travis-ci.org/hadrori/ojsubmitter) [![Coverage Status](https://coveralls.io/repos/github/hadrori/ojsubmitter/badge.svg?branch=master)](https://coveralls.io/github/hadrori/ojsubmitter?branch=master) [![Dependency Status](https://gemnasium.com/hadrori/ojsubmitter.svg)](https://gemnasium.com/hadrori/ojsubmitter)

This gem helps you submit source code to online judges from command line interface.

## Requirements

- ruby >= 2.0.0

### Enabled Judges
- [AIZU ONLINE JUDGE](http://judge.u-aizu.ac.jp)
- [PKU JudgeOnline](http://poj.org)
- [Sphere online judge](http://www.spoj.com)
- [Codeforces](http://codeforces.com)
- [AtCoder](http://atcoder.jp)

You can also get this list from `ojsubmitter list` command.

## Installation

    $ gem install ojsubmitter

## Configure

Please run below command to create config file to home directory(`~/.ojsconf.yml`).
You can set the default options of ojsubmitter command.

    $ ojsubmitter init


## Usage

#### Submit

    $ ojsubmitter -j [JUDGE_NAME] -u [USER_NAME] -p [PASSWORD] -l [LANGUAGE] -f [SOURCE_FILE] -i [PROBLEM_ID] -c [CONTEST_ID]

This command has too many options, so you can use `.ojsconf.yml` to set default options.
After submitting, this will open the submission status page with web browser. If you don't want to open browser, please use `-n` option.
If you don't specify the problem id, this tool assume the problem id from file name and target judge name.

#### Available judges and options to submit.

| online judge | problem | judge (-j) | problem_id (-i) | file name (-f) | contest_id (-c) |
|:--|:--:|:--:|:--:|:--:|:--:|
| Aizu Online Judge | [0000](http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=0000) | aoj | 0000 | 0000.cpp | |
| PKU Judge Online | [1000](http://poj.org/problem?id=1000) | poj | 1000 | 1000.cpp | |
| Sphere Online Judge | [PRIME1](http://www.spoj.com/problems/PRIME1/) | spoj | PRIME1 | prime1.cpp | |
| Codeforces | [1A](http://codeforces.com/problemset/problem/1/A) | cf, codeforces | 1A | 1A.cpp | |
| AtCoder | [abc001 A](http://abc001.contest.atcoder.jp/tasks/abc001_1) | atcoder | A | a.cpp | abc001 |


When you submit to Codeforces and your file name is like `A.cpp`, this tool assume contest id from your current directory.   For example, if your current directory is `/path/to/cf/1` and file name is `A.cpp`, problem id will be `1A`.  
  
#### Available languages

All languages are case-insensitive.

#### Aizu Online Judge

Version infomation of AOJ is [here](http://judge.u-aizu.ac.jp/onlinejudge/status_note.jsp).

| Language | language option (-l) |
|:--|:--|
| C | C |
| C++ | C++ |
| C++11 | C++11 |
| C++14 | C++14 |
| JAVA | JAVA |
| Scala | Scala |
| Haskell | Haskell |
| OCaml | OCaml |
| C# | C# |
| D | D |
| Ruby | Ruby |
| Python | Python |
| Python3 | Python3 |
| PHP | PHP |
| JavaScript | JavaScript |

#### PKU JudgeOnline

Version infomation of POJ is [here](http://poj.org/page?id=1000).

| Language | language option (-l) |
|:--|:--|
| G++ | G++ |
| GCC | GCC |
| Java | Java |
| Pascal | Pascal |
| C++ | C++ |
| C | C |
| Fortran | Fortran |

#### Sphere Online Judge

Version infomation of SPOJ is [here](http://poj.org/page?id=1000).

| Language | language option (-l) |
|:--|:--|
| ADA 95 (gnat 5.1) | ADA |
| Assembler (nasm 2.11.05) | Assembler |
| Awk (gawk-4.1.1) | Awk |
| Bash (bash-4.3.33) | Bash |
| Brainf**k (bff 1.0.5) | Brainf**k |
| C (gcc 5.1) | C |
| C# (gmcs 4.0.2) | C# |
| C++ (g++ 5.1) | C++ |
| C++14 (g++ 5.1) | C++14 |
| C99 strict (gcc 5.1) | C99 |
| Clips (clips 6.24) | Clips |
| Clojure (clojure 1.7) | Clojure |
| Cobol (opencobol 1.1) | Cobol |
| Common Lisp (clisp 2.49) | CommonLisp |
| D (dmd 2.067.1) | D |
| Elixir (1.1.0) | Elixir |
| Erlang (erl 18) | Erlang |
| F# (fsharp 3.1) | F# |
| Fantom (1.0.67) | Fantom |
| Fortran 95 (gfortran 5.1) | Fortran |
| Go (gc 1.4.2) | Go |
| Groovy (2.4.4) | groovy |
| Haskell (ghc 7.8) | Haskell |
| Icon (iconc 9.4.3) | Icon |
| Intercal (ick 0.28-4) | Intercal |
| JAR (JavaSE 6) | JAR |
| Java (JavaSE 8u51) | Java |
| JavaScript (spidermonkey 24.) | JavaScript |
| Lua (luac 5.2) | Lua |
| Nemerle (ncc 0.9.3) | Nemerle |
| Nice (nicec 0.9.13) | Nice |
| Nim (nim 0.11.2) | Nim |
| ObjC (clang 3.7) | ObjC |
| Ocaml (ocamlopt 4.01.0) | Ocaml |
| Pascal (gpc 20070904) | Pascal |
| Perl (perl 5.20.1) | Perl |
| PHP (php 5.6.9) | PHP |
| PicoLisp (3.1.1) | PicoLisp |
| Pike (pike 7.8) | Pike |
| Prolog (swipl 7.2) | Prolog |
| Python (python 2.7.10) | Python |
| Python (PyPy 2.6) | PyPy |
| Python 3 (python 3.4) | Python3 |
| Ruby (ruby 2.1) | Ruby |
| Rust (1.0.0) | Rust |
| Scala (scala 2.11.7) | Scala |
| Scheme (guile 2.0.11) | Scheme |
| Sed (sed-4.2) | Sed |
| Smalltalk (gst 3.2.4) | Smalltalk |
| Tcl (tclsh 8.6) | Tcl |
| TECS () | TECS |
| Text (plain text) | Text |
| VB.net (vnbc 4.0.2) | VB.net |
| Whitespace (wspace 0.3) | Whitespace |


#### Codeforces

Version infomation of Codeforces is [here](http://codeforces.com/blog/entry/79).


| Language | language option (-l) |
|:--|:--|
| GNU GCC 5.1.0 | GCC |
| GNU G++ 5.1.0 | G++ |
| GNU G++11 5.1.0 | G++11 |
| Microsoft Visual C++ 2010 | MSC++ |
| C# Mono 3.12.1.0 | C# |
| MS C# .NET 4.0.30319 | MSC# |
| D DMD32 v2.069.2 | D |
| Go 1.5.2 | Go |
| Haskell GHC 7.8.3 | Haskell |
| Java 1.7.0_80 | Java7 |
| Java 1.8.0_66 | Java |
| OCaml 4.02.1 | OCaml |
| Delphi 7 | Delphi |
| Free Pascal 2.6.4 | Pascal |
| Perl 5.20.1 | Perl |
| PHP 5.4.42 | PHP |
| Python 2.7.10 | Python |
| Python 3.5.1 | Python3 |
| PyPy 2.7.10 (2.6.1) | PyPy |
| PyPy 3.2.5 (2.4.0) | PyPy3 |
| Ruby 2.0.0p645 | Ruby |
| Scala 2.11.7 | Scala |
| JavaScript V8 4.8.0 | JavaScript |

#### AtCoder

When you use this for submitting to atcoder, this tool will get languages list from atcoder and submit with matched language. If two or more languages are matched, you have to select one.

#### Help

Please read the help command to get more info.

    $ ojsubmitter help

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hadrori/ojsubmitter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

