
# to execute commands against git and git annex repos

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
        out_log_file.write('\n')

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
        try:
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
        except Exception as e:
            print(e)
    #
    recur(Path(from_dir))
    # add the remotes, is_annex, and other info
    for repo in all_git_repos:
        repo['abs_root'] = str(repo['git_root'])
        repo['git_dir'] = repo['abs_root'] if repo['is_bare'] else os.path.join(repo['abs_root'], '.git')
        # assume is git annex repo is there is '.git/annex' directory, or 'repo.git/annex' directory for bare repo
        repo['is_annex'] = os.path.isdir(os.path.join(repo['git_dir'], 'annex'))
        #repo['remotes'] = get_git_remotes(repo['abs_root'])
    return all_git_repos

def print_repo_infos(repos):
    for repo in repos:
        log_msg(f"repo: {repo['abs_root']}")
        log_msg(f"  is_bare: {repo['is_bare']}\tis_annex: {repo['is_annex']}")
        #log_msg(f"  remotes: {repo['remotes']}")

def exe_cmd_log(args, **kwargs):
    kwargs['capture_output'] = True
    r = subprocess.run(args, **kwargs)
    msg_out = r.stdout.decode('utf-8')
    if r.returncode != 0:
        msg_err = r.stderr.decode('utf-8')
        log_msg(f"    FAIL: \n{msg_out}\n\n{msg_err}\n!!!\n\n")
    else:
        log_msg(f"    ok:\n{msg_out}\n")
    return r

def exec_for_all(from_dir, only_annex, cmds_to_exec, repos = None):
    if repos is None:
        log_msg(f"== find git repos under {from_dir}")
        repos = find_git_repos(from_dir)
        if only_annex:
            repos = [z for z in repos if z['is_annex']]
        log_msg(f"== to execute for these repos:")
        print_repo_infos(repos)
        log_msg(f"\n== start")
        flush_log()
    for repo in repos:
        log_msg(f"=== for repo: {repo['abs_root']}")
        exe_cmd_log(cmds_to_exec, cwd = repo['abs_root'])
        log_msg('\n')
        flush_log()

def main(
        from_dir,
        only_annex,
        cmds_to_exec,
        repos = None,
        log_file_name = None):
    import time
    # setup the log file first
    global out_log_file
    cur_time = time.ctime()
    
    if log_file_name is None:
        log_file_name = time.strftime('log_with_gits_%Y_%m_%d_%Z.log')
    print(f"Append to logfile: {log_file_name}")
    with open(log_file_name, 'at') as log_file:
        out_log_file = log_file
        try:
            log_msg(f"====== with git repos: {cur_time}")
            log_msg(f"  from_dir: '{from_dir}'")
            log_msg(f"  only_annex: '{only_annex}'")
            log_msg(f"  cmds_to_exec: '{cmds_to_exec}'")
            log_msg(f"  log_file_name: '{log_file_name}'")
            #
            flush_log()

            exec_for_all(
                from_dir = from_dir,
                only_annex = only_annex,
                cmds_to_exec = cmds_to_exec,
                repos = repos
            )
            
            log_msg(f"== All done.")
        except Exception as e:
            log_msg(e)
            out_log_file = None

#########

if __name__ == "__main__":
    import argparse
    p = argparse.ArgumentParser(
        prog = 'with_gits',
        description='To run commands against git repos in subdirectories.')

    p.add_argument('--from_dir',
                   default = '.',
                   help = 'The source directory to find git repos, including itself and its subdirectories. Default is current directory.')

    p.add_argument('--annex',
                   default = False, action = argparse.BooleanOptionalAction,
                   help = """Whether to restrict to git annex repos.""")

    p.add_argument('--log_file_name',
                   default = None,
                   help = """Name of the log_file to append to.
    If not provided, will use 'log_with_gits_%Y_%M_%d_%Z.log' in the current directory.""")

    p.add_argument('rest', nargs=argparse.REMAINDER)

    args = p.parse_args()
    # convert paths to absolute paths
    from_dir = str(Path(args.from_dir).absolute())
    only_annex = args.annex
    log_file_name = args.log_file_name
    rest_args = args.rest
    main(from_dir, only_annex, rest_args, log_file_name)
