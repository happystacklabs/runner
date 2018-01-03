<img src=".github/happystack.png" alt="Happystack" width="150" height="150" />

# Happystack 🏃🏼Runner
![Version](https://img.shields.io/badge/Version-0.3.0-green.svg?style=flat)
![license](https://img.shields.io/github/license/mashape/apistatus.svg)

#### 🏃🏼 Runner is a task runner used at Happystack for automating various tasks and deployment.

## 🔧 Installation
```bash
curl -fsSL https://raw.githubusercontent.com/happystacklabs/runner/master/install.sh | sudo sh
```

You can also uninstall like this:
```bash
runner uninstall
```

## 🕹 Usage

### Commands & Options
```

   /\═════════\™
  /__\‸_____/__\‸
 │    │         │   HAPPYSTACK
 │    │  \___/  │   🏃🏼 Runner
 ╰────┴─────────╯
╭─────────────────────────────────────────────────────────────╮
│                                                             │
│  usage:  runner COMMANDS [OPTIONS] [help]                   │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│    COMMANDS:                                                │
│                                                             │
│       <init>                        generate tasks file     │
│                                                             │
│       <tasks file> <version>        ex: ./tasks.sh 0.0.0    │
│                                                             │
│       <update>                      to latest version       │
│                                                             │
│       <uninstall>                   remove runner           │
│                                                             │
╰─────────────────────────────────────────────────────────────╯

```

### Getting Started

Runner needs a bash file with all the tasks to run. It comes with a sample file
that we can generate with the init command.

``` bash
runner init
```

The tasks file looks like this:
``` bash

################################################################################
# Task 1
################################################################################
tasks[0]='Task one'
tasksCommand[0]='sleep 2.0'

################################################################################
# Task 2
################################################################################
tasks[1]='Task two'
tasksCommand[1]='sleep 5.0'

...

```

To add a new task, add the task title and the command.

``` bash
################################################################################
# Task N
################################################################################

tasks[n]='Task title'
tasksCommand[n]='the bash command'

# where 'n' is the index of the task
```

Now run this and it will complete all the tasks in your file!
``` bash
runner tasks[sample].sh 0.0.0
```


## 📄 Licenses
* Source code is licensed under [MIT](https://opensource.org/licenses/MIT)

## 💡 Feedback
[Create an issue or feature request](https://github.com/happystacklabs/runner/issues/new).
