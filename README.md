# recruitibase


## Synopsis

A tool for extracting data from a simple YAML "database" of recruiters


## Description

Over the years I built up a text file of recruiter info to track job hunting
efforts. Eventually, I adopted a YAML format for this data to facilitate
data extraction. This software does some of that extraction.

The basic idea is you work with the "database" YAML file directly in a text
editor and only use this software to build a list of email addresses or
possibly dump the entire database back out to valid YAML.

Copy the file `recruitibase.yaml` into the default location: `$HOME/.config`.
Then start using it to track recruiters.


## Getting source

Source code is available from github at the [recruitibase](https://github.com/dino-/recruitibase) project page.

Build in the usual way with stack:

    $ stack build
    $ stack exec recruitibase -- [OPTIONS]
    $ stack install
    ...


## Contact

Dino Morelli <dino@ui3.info>
