#!/usr/bin/env python
# coding: utf-8
import git
import click

@click.command()
@click.argument('repos', nargs=-1, type=click.Path(exists=True))
def push(repos):
    for directory in repos:
        r = git.Repo(directory)
        for pushinfo in r.remote().push():
            click.echo(f"{directory}: {pushinfo.summary}".strip())

if __name__ == "__main__":
    push()
