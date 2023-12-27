# GitL

* GitL is a decentralised Git that lets you commit and view diffs of version control system in your local folder.

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

* `commit("b","Description of changes.").` - Commits repository `b` to the version control system and creates an HTML file with the differences between versions and the description of changes.

# GitL Web Service

* To see a list of repositories with changes and commit some of the changed ones, load with:
```
gitl_server(8000).
```

* Go to `http://localhost:8000/gitl`.

* Remember to edit the password in `../Philosophy/web-editor-pw.pl` before running.

* To view and change repositories, load with:
```
['web_editor_gitl_test.pl'].
web_editor_server(8000).
```

* Go to `http://localhost:8000/webeditor`.

# Integrate with Lucian CI/CD

* So far, to commit changes from <a href="https://github.com/luciangreen/luciancicd">Lucian CI/CD</a>, run:
`scp -pr ../../GitHub2/ ../gitl_test/` before committing.

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the <a href="LICENSE">LICENSE.md</a> file for details

