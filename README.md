# GitL

* Decentralised Git that lets you commit and view diffs of version control system in your local folder.

# Getting Started

Please read the following instructions on how to install the project on your computer for controlling versions.

# Prerequisites

* Please download and install SWI-Prolog for your machine at `https://www.swi-prolog.org/build/`.

# 1. Install manually

* Download:
* <a href="https://github.com/luciangreen/gitl">this repository</a> and its dependencies
* <a href="https://github.com/luciangreen/listprologinterpreter">List Prolog Interpreter</a>
* <a href="https://github.com/luciangreen/luciancicd">Lucian CI/CD</a>

# 2. Or Install from List Prolog Package Manager (LPPM)

* Download <a href="https://github.com/luciangreen/gitl">GitL</a>:

```
git clone https://github.com/luciangreen/List-Prolog-Package-Manager.git
cd List-Prolog-Package-Manager
swipl
['lppm'].
lppm_install("luciangreen","gitl").
halt
```

# Running

* In Shell:
`cd gitl`
`swipl`

* To load the algorithm, enter:
```
['gitl.pl'].
```

# Instructions

* In the folder `gitl_test` at the same level as `gitl`, store your repositories, e.g. `b`.
* In the folder `gitl_data` at the same level as `gitl`, GitL stores the version control system and diffs between versions.

* `commit("b").` - Commits repository `b` to the version control system and creates an HTML file with the differences between versions.

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the <a href="LICENSE">LICENSE.md</a> file for details

