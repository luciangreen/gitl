# GitL

* GitL is a decentralised Git that lets you commit and view diffs of the version control system in your local folder.

# Getting Started

Please read the following instructions on installing the project on your computer for controlling versions.

# Prerequisites

* Use a search engine to find the Homebrew (or other) Terminal install command for your platform and install it, and search for the Terminal command to install swipl using Homebrew and install it or download and install SWI-Prolog for your machine at <a href="https://www.swi-prolog.org/build/">SWI-Prolog</a>.

# Mac, Linux and Windows (with Linux commands installed): Prepare to run swipl

* In Terminal settings (Mac), make Bash the default shell:

```
/bin/bash
```

* In Terminal, edit the text file `~/.bashrc` using the text editor Nano:

```
nano ~/.bashrc
```

* Add the following to the file `~/.bashrc`:

```
export PATH="$PATH:/opt/homebrew/bin/"
```

* Check if `usr/local/bin` exists

```
ls -ld /usr/local/bin
```

* Create the directory if missing

```
sudo mkdir -p /usr/local/bin
```

* Link to swipl in Terminal

```
sudo ln -s /opt/homebrew/bin/swipl /usr/local/bin/swipl
```

# 1. Install manually

* Download:
* <a href="https://github.com/luciangreen/gitl">this repository</a> and its dependencies
* <a href="https://github.com/luciangreen/listprologinterpreter">List Prolog Interpreter</a>
* <a href="https://github.com/luciangreen/luciancicd">Lucian CI/CD</a>

# 2. Or Install from List Prolog Package Manager (LPPM)

* Download the <a href="https://github.com/luciangreen/List-Prolog-Package-Manager">LPPM Repository</a>:

```
mkdir GitHub
cd GitHub/
git clone https://github.com/luciangreen/List-Prolog-Package-Manager.git
cd List-Prolog-Package-Manager
swipl
['lppm'].
lppm_install("luciangreen","gitl").
../
halt.
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

* <a href="https://dev.to/luciangreen/introducing-gitl-a-decentralised-git-server-1a34">Dev.to article about GitL</a>

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

* Prepare the script to run luciancicd and commit `chmod +x ./run_luciancicd_for_repo.sh`
* Run this script: `./run_luciancicd_for_repo.sh my_repo_name "Description of changes."`

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the <a href="LICENSE">LICENSE.md</a> file for details

