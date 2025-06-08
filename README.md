# project-launcher

A project launcher.

## About

This is a small tool for quickly finding and launching project specific startup scripts. Configure some paths in a text file and run `project-launcher` to interactively search for and launch a script.

This tool is useful when:
- you have a selection of active projects you switch between
- they all require their own unique startup steps (terminal tabs, editor, etc.)

### Usage

This is the output from `.\project-launcher.bat --help`
```
project-launcher

ABOUT

project-launcher searches through a list of scripts and launches one of them.
It uses an interactive prompt to browse results and select the script to launch.
The configuration file format is a text file with one path per line. By default,
a global configuration is loaded from $HOME\.project-launcher\settings.txt.

USAGE

Output help:
project-launcher --help
project-launcher -h

Launch with global configuration:
project-launcher

Launch with specified configuration:
project-launcher --settings .\some\path\to\settings.txt

INTERACTIVE MODE

Controls:
Escape - cancel the search and exit
Up/Down arrows - change selection
Enter - launch the current selection

Type to filter the results.
```

## Development

There are some sample projects, configurations and test scripts under `test\`. If you update the projects under `test\projects`, make sure to generate new test configurations with `.\tools\generate-test-configs.ps1`.
