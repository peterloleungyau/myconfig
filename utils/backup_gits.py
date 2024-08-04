
# to backup git and git annex repos

import subprocess
import shutil
import os
from pathlib import Path

git_cmd = shutil.which('git')

out_log_file = None

def log_msg(msg):
    print(msg)
    if out_log_file:
        out_log_file.write(msg)

def flush_log():
    if out_log_file:
        out_log_file.flush()

def get_git_remotes(git_path):
    res = subprocess.run([git_cmd, 'remote'], capture_output = True, cwd = git_path, text = True)
    if res.returncode != 0:
        return []
    return [r for r in res.stdout.split('\n') if len(r) > 0]

def find_git_repos(from_dir):
    all_git_repos = []
    def recur(p):
        if not p.is_dir():
            return
        if p.name.endswith('.git'):
            # bare git repo, need not recurse
            # NOTE: non-bare git is handled below
            all_git_repos.append({'git_root': p.absolute(), 'is_bare': True})
            return
        for cp in p.iterdir():
            if not cp.is_dir():
                continue
            if cp.name == '.git':
                # the path is the git root
                all_git_repos.append({'git_root': p.absolute(), 'is_bare': False})
            elif cp.name.endswith('.git'):
                # bare
                all_git_repos.append({'git_root': cp.absolute(), 'is_bare': True})
            else:
                recur(cp)
    #
    recur(Path(from_dir))
    # add the remotes, is_annex, and other info
    for repo in all_git_repos:
        repo['abs_root'] = str(repo['git_root'])
        repo['git_dir'] = repo['abs_root'] if repo['is_bare'] else os.path.join(repo['abs_root'], '.git')
        # assume is git annex repo is there is '.git/annex' directory, or 'repo.git/annex' directory for bare repo
        repo['is_annex'] = os.path.isdir(os.path.join(repo['git_dir'], 'annex'))
        repo['remotes'] = get_git_remotes(repo['abs_root'])
    return all_git_repos

def print_repo_infos(repos):
    for repo in repos:
        log_msg(f"repo: {repo['abs_root']}")
        log_msg(f"  is_bare: {repo['is_bare']}\tis_annex: {repo['is_annex']}")
        log_msg(f"  remotes: {repo['remotes']}")

def exe_cmd_log(args, **kwargs):
    kwargs['capture_output'] = True
    r = subprocess.run(args, **kwargs)
    if r.returncode != 0:
        log_msg(f"  FAIL: \n{r.stdout}\n")
    return r

def replace_from_to_dir(abs_root, from_dir, to_dir):
    # normalize, ensure no trailing '/' in to_dir and from_dir, need to replace one with another
    if to_dir[-1] in ['/', '\\']:
        to_dir = to_dir[:-1]
    if from_dir[-1] in ['/', '\\']:
        from_dir = from_dir[:-1]
    log_msg(f"  replace '{from_dir}' to '{to_dir}'")
    if not abs_root.startswith(from_dir):
        err_msg = f"Error: Repo path '{abs_root}' not start with from_dir '{from_dir}'"
        log_msg(err_msg)
        raise ValueError(err_msg)
    # replace from_dir as to_dir
    to_root = to_dir + abs_root[len(from_dir):]
    return to_root

def create_repo(repo, to_remote, to_dir, from_dir, from_remote):
    log_msg(f"==== create repo: {repo['abs_root']}")
    # git clone will complain if the dir already exists,
    # so we instead use git init
    to_root = replace_from_to_dir(repo['abs_root'], from_dir, to_dir)
    to_git_parent_dir = str(Path(to_root).parent.absolute())
    log_msg(f"  to_root: {to_root}")
    # to remote: mkdir -p
    log_msg(f"  parent dir: {to_git_parent_dir}")
    os.makedirs(to_root, mode = 0o755, exist_ok = True)
    # to remote: git clone
    #   we keep going even if git clone fails, e.g. the destination may already have the repo, but the source does not have the remote
    #   if the fail is serious, the subsequent steps should also fail, so not much harm
    if repo['is_bare']:
        log_msg(f"  at to_root: git init --bare")
        exe_cmd_log([git_cmd, 'init', '--bare'],
                    cwd = to_root)
    else:
        log_msg(f"  at to_root: git init")
        exe_cmd_log([git_cmd, 'init'], cwd = to_root)
        # git by default refuse to accept push for non-bare repo
        log_msg(f"  at to_root, to allow push at non-bare repo: git config receive.denyCurrentBranch warn")
        exe_cmd_log([git_cmd, 'config', 'receive.denyCurrentBranch', 'warn'],
                    cwd = to_root)
    log_msg(f"  at to_root: git remote add {from_remote} {repo['abs_root']}")
    exe_cmd_log([git_cmd, 'remote', 'add', from_remote, repo['abs_root']],
                cwd = to_root)
    # to remote: git annex sync
    if repo['is_annex']:
        log_msg(f"  at to_root: git annex init {to_remote}")
        exe_cmd_log([git_cmd, 'annex', 'init', to_remote],
                    cwd = to_root)
        # sync a few times, until there is no error, to sync the metadata
        log_msg("  git annex repo, sync metadata at to_root first")
        for i in range(3):
            r = subprocess.run([git_cmd, 'annex', 'sync'],
                               cwd = to_root)
            if r.returncode == 0:
                break
    # from remote: add to remote
    # can allow error, which most likely is the remote somehow already exists, but unlikely
    log_msg(f"  at source repo: git remote add {to_remote} {to_root}")
    exe_cmd_log([git_cmd, 'remote', 'add', to_remote, to_root],
                cwd = repo['abs_root'])

def backup_repo(repo, to_remote, to_dir, from_dir, from_remote, create_if_not_exists = False):
    if to_remote not in repo['remotes']:
        if create_if_not_exists:
            create_repo(repo, to_remote, to_dir, from_dir, from_remote)
        else:
            return
    log_msg(f"=== for repo to [{to_remote}]: {repo['abs_root']}")
    if repo['is_annex']:
        log_msg(f"  git annex copy --to={to_remote}")
        res = subprocess.run([git_cmd, 'annex', 'copy', f'--to={to_remote}'],
                             cwd = repo['abs_root'])
        log_msg('  FAIL' if res.returncode != 0 else '  ok')
    else:
        log_msg(f"  git push --all {to_remote}")
        res = subprocess.run([git_cmd, 'push', '--all', to_remote],
                             cwd = repo['abs_root'])
        log_msg('  FAIL' if res.returncode != 0 else '  ok')
        if not repo['is_bare']:
            log_msg('  NOTE: if to_root non-bare, may need to manually checkout branches.')

y_c_s_choices = {
    'yes': ['yes', 'y'],
    'cancel': ['cancel', 'c'],
    'skip': ['skip', 's'],
}

def choices_to_str(choices):
    out = []
    for choice, shown_strs in choices.items():
        ss = "' or '".join(shown_strs)
        out.append(f"'{ss}' for '{choice}'; ")
    return ''.join(out)

y_c_s_choices_as_str = choices_to_str(y_c_s_choices)

def ask_choices(prompt, choices_str, choices):
    prompt_with_choices = f"{prompt} [{choices_str}] "
    while True:
        r = input(prompt_with_choices)
        r = r.lower().strip()
        for choice, shown_strs in choices.items():
            if r in shown_strs:
                return choice
        # not matched any
        print(f"Please type {choices_str}")

def backup_all_repos(from_dir, from_remote, to_dir, to_remotes,
                     repos = None,
                     confirm_remote = True, create_if_not_exists = False):
    if repos is None:
        log_msg(f"== find git repos under {from_dir}")
        repos = find_git_repos(from_dir)
        log_msg(f"== to backup these repos:")
        print_repo_infos(repos)
        log_msg(f"== start backup")
        flush_log()

    for to_remote in to_remotes:
        # put to_remotes at outer loop, so that we may pause inbetween, e.g. to allow plugging in another usb drive.
        log_msg(f"== to_remote: {to_remote}")
        if confirm_remote:
            r = ask_choices(f"Remote '{to_remote}' ready?", y_c_s_choices_as_str, y_c_s_choices)
            if r == 'skip':
                log_msg(f"  skipped for {to_remote}.")
                continue
            if r == 'cancel':
                log_msg(f"  canceled for {to_remote}")
                break
            # else if 'yes', process it
        for repo in repos:
            backup_repo(repo, to_remote, to_dir, from_dir, from_remote, create_if_not_exists)
            flush_log()

def backup_main(
        from_dir, from_remote, to_dir, to_remotes,
        repos = None,
        confirm_remote = True, create_if_not_exists = False,
        log_file_name = None):
    import time
    # setup the log file first
    global out_log_file
    cur_time = time.ctime()
    
    if log_file_name is None:
        log_file_name = time.strftime('backup_gits_%Y_%M_%d_%Z.log')
    print(f"Append to logfile: {log_file_name}")
    with open(log_file_name, 'at') as log_file:
        out_log_file = log_file
        try:
            log_msg(f"====== Backup git: {cur_time}")
            log_msg(f"  from_dir: '{from_dir}'")
            log_msg(f"  from_remote: '{from_remote}'")
            log_msg(f"  to_dir: '{to_dir}'")
            log_msg(f"  to_remotes: '{to_remotes}'")
            log_msg(f"  confirm ready for to_remote: {confirm_remote}")
            log_msg(f"  create remote repo if not exists: {create_if_not_exists}")
            flush_log()

            backup_all_repos(from_dir, from_remote, to_dir, to_remotes,
                             repos = repos,
                             confirm_remote = confirm_remote,
                             create_if_not_exists = create_if_not_exists)
            log_msg(f"== All done.")
        except Exception as e:
            log_msg(e)
            out_log_file = None

#########

if __name__ == "__main__":
    import argparse
    p = argparse.ArgumentParser(
        prog = 'backup_gits',
        description='To backup git repos in subdirectories to remotes.')
    p.add_argument('--from_dir',
                   help = 'The source directory to find git repos, including itself and its subdirectories.')
    p.add_argument('--to_dir',
                   default = None,
                   help = """The destination directory to backup, only needed if create_if_not_exists is True.
    The dest repo will be created in the same relative from 'from_dir' replace with 'to_dir'.""")
    p.add_argument('--from_remote',
                   default = None,
                   help = """Name of from remote, only needed if create_if_not_exists is True.
    The created repo will have the source repo as remote with this name.""")
    p.add_argument('--to_remotes', required = True,
                   help = """The remotes to backup to, as comma separated names.
    If create_if_not_exists is False, for each remote in to_remotes, only backup to the remote if the repo has it.""")
    p.add_argument('--confirm_remote',
                   default = True, action = argparse.BooleanOptionalAction,
                   help = """Whether to confirm a remote is ready, before starting the backup of each remote.
    For each remote, will loop through the repos found.""")
    p.add_argument('--create_if_not_exists',
                   default = False,
                   help = """If True, if a to_remote is not in a repo, will create a repo at 'to_dir', mirroring the sub-dirs of 'from_dir'.
    The created dest repo will have a remote named 'from_remote' to the source repo.
    Also, if create dest repo, the source repo will have a remote named 'to_remote' to the dest repo.""")
    p.add_argument('--log_file_name',
                   default = None,
                   help = """Name of the log_file to append to.
    If not provided, will use 'backup_gits_%Y_%M_%d_%Z.log' in the current directory.""")

    args = p.parse_args()
    # convert paths to absolute paths
    from_dir = str(Path(args.from_dir).absolute())
    to_dir = args.to_dir
    to_dir = str(Path(to_dir).absolute()) if to_dir else None
    from_remote = args.from_remote
    to_remotes = args.to_remotes.split(',')
    confirm_remote = args.confirm_remote
    create_if_not_exists = args.create_if_not_exists
    log_file_name = args.log_file_name
    backup_main(
        from_dir = from_dir,
        to_dir = to_dir,
        from_remote = from_remote,
        to_remotes = to_remotes,
        confirm_remote = confirm_remote,
        create_if_not_exists = create_if_not_exists,
        log_file_name = log_file_name
    )
