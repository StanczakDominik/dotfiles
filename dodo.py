import pathlib
import click
import subprocess
import socket

home = pathlib.Path.home()


def create_symlink(source, target):
    source = pathlib.Path(source)
    target = pathlib.Path(target)
    diff = subprocess.run(
        ["diff", target, source], capture_output="stdout"
    ).stdout.decode()
    if diff or not target.is_file():
        click.echo(diff)
        # if click.confirm(f'Do you want to replace {target} with a symlink to {source}?'):
        if True:
            click.echo("Well done!")
            if target.is_file():
                target.rename(target.with_suffix(".backup"))
            target.symlink_to(source)
    else:
        click.echo(f"{source} and {target} have identical contents.")


def create_symlink2(dependencies, targets):
    for source, target in zip(dependencies, targets):
        create_symlink(source, target)


def task_create_symlinks():
    for source, target in [
        ("vim/.vimrc", home / ".config/nvim/.vimrc"),
        (home / ".config/nvim/.vimrc", home / ".vimrc",),
        ("vim/.config/nvim/init.vim", home / ".config/nvim/init.vim"),
        ("git/.gitignore_global", home / ".gitignore_global"),
        ("conda/.condarc", home / ".condarc"),
        ("bash/.bash_aliases", home / ".bash_aliases"),
        ("bash/.bash_completion", home / ".bash_completion"),
        ("bash/.bash_profile", home / ".bash_profile"),
        ("bash/.bashrc", home / ".bashrc"),
        ("jrnl/.config/jrnl/jrnl.yaml", home / ".config/jrnl/jrnl.yaml"),
        (
            "ipython/profile_default/ipython_config.py",
            home / ".ipython/profile_default/ipython_config.py",
        ),
        (
            "ipython/profile_default/ipython_kernel_config.py",
            home / ".ipython/profile_default/ipython_kernel_config.py",
        ),
        ("zsh/.zshrc", home / ".zshrc"),
        ("zsh/.zshenv", home / ".zshenv"),
        # ("zsh/.zsh/", home / ".zsh/"),   is a directory
        # ("echo "Link ~/.ipython/profile_default/startup manually!" is a directory
        ("pubs/.pubsrc", home / ".pubsrc"),
    ]:
        yield {
            "name": source,
            "file_dep": [pathlib.Path.cwd() / source],
            "targets": [target],
            "actions": [create_symlink2],
        }


def task_create_machine_specific_symlinks():
    hostname = socket.gethostname()
    for dictionary, target in [
        (
            {"dell": "wtfutil/config_home.yml", "opml-28": "wtfutil/config_work.yml"},
            home / ".config/wtf/config.yml",
        ),
        (
            {"dell": "git/.gitconfig", "opml-28": "git/.gitconfig_ifpilm"},
            home / ".gitconfig",
        ),
        (
            {"dell": "bash/.bashrc_local_home", "opml-28": "bash/.bashrc_local_ifpilm"},
            home / ".bashrc_local",
        ),
    ]:
        source = dictionary[hostname]
        yield {
            "name": source,
            "file_dep": [pathlib.Path.cwd() / source],
            "targets": [target],
            "actions": [create_symlink2],
        }

        # link pre-commit/.pre-commit-config.yaml manually
