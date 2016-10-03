# cfparser.vim
A port from emacs plugin [gnull/cfparser](https://github.com/gnull/cfparser).

## Installation
- Install `curl`
- Install `cfparser.vim` with your favorite plugin manager. With `vim-plug`:

```
Plug 'gabrielsimoes/cfparser.vim'
```

### Optional setup
You can setup some variables at your .vimrc:
- `g:cf_cookies_file` - File in which `curl` will store cookies (default: `'~/.cf_cookies'`)
- `g:cf_default_language` - Language to be used when it it not recognized from file extension (default: g:cf_pl_gpp - g++). Languages are mapped in `plugin/cfparser.vim`
- `g:cf_test_command` - Shell command to compile and run your solution on sample tests. It must be a string, in which string literals will be replaced by printf. First argument is file name, second argument is file and tests location.For example, the default is:

```
let g:cf_test_command = "g++ %s;
                        \cnt=0;
                        \for i in `ls %s/*.in | sed 's/.in//'`; do
                        \   let cnt++;
                        \   echo \"\nTEST $cnt\";
                        \   ./a.out < $i.in | diff -y - $i.out;
                        \done;
                        \rm a.out;"
```
- `g:cf_locale` - Language to download problem statement. Either `"ru"` or `"en"` (default: `"en"`)

## Usage
- `<leader>cfi` - Log**i**n (calls `CFLogin()`)
- `<leader>cfo` - Log**o**ut (calls `CFLogout()`)
- `<leader>cfw` - **W**ho am I (calls `CFWhoAmI()`)
- `<leader>cfp` - Display **p**roblem statement (calls `CFProblemStatement()`)
- `<leader>cfd` - **D**ownload sample tests to current code folder (0.in, 0.out, 1.in ...) (calls `CFDownloadTests()`)
- `<leader>cft` - Runs code with sample **t**ests (calls `CFTestAll()`)
- `<leader>cfs` - **S**ubmit current open file (calls `CFSubmit()`)
- `<leader>cfl` - **L**ist most recent submissions (calls `CFLastSubmissions()` without arguments - can be called with username as argument, default to logged in user)

Submit, download sample tests and problem statement functions "guess" the contest number, problem index and the programming language by the current file name in one of the following forms:
- `directory/505/A/myfile.cpp`
- `directory/505/a.c`
- `directory/505a.cc`
