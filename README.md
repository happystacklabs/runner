<img src=".github/happystack.png" alt="Happystack" width="150" height="150" />

# Happystack Runner
![Version](https://img.shields.io/badge/Version-0.2.0-green.svg?style=flat)
![license](https://img.shields.io/github/license/mashape/apistatus.svg)

#### 🏃🏼 Runner is a task runner used at Happystack for automating various tasks and deployment.

## 🔧 Installation
```bash
curl -fsSL https://raw.githubusercontent.com/happystacklabs/runner/master/install.sh | sudo sh
```

## 🕹 Usage

#### Commands & Options
```

   /\═════════\™
  /__\‸_____/__\‸
 │    │         │   HAPPYSTACK
 │    │  \___/  │   🏃🏼Runner
 ╰────┴─────────╯
╭─────────────────────────────────────────────────╮
│                                                 │
│  usage:  runner COMMANDS [OPTIONS] [help]       │
│                                                 │
│    COMMANDS:                                    │
│       init              generate tasks file     │
│       ----                                      │
│       tasks file        (ex: ./tasks.sh)        │
│       version           (ex: 2.0.0)             │
│                                                 │
╰─────────────────────────────────────────────────╯

```
#### Getting Started
Runner needs a bash file with all the tasks to run. It comes with a sample file
that we can generate with the init command.

``` bash
runner init
```

## 📄 Licenses
* Source code is licensed under [MIT](https://opensource.org/licenses/MIT)

## 💡 Feedback
[Create an issue or feature request](https://github.com/happystacklabs/runner/issues/new).
