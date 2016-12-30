# Aide-watch

Aide-watch is a script that automates running AIDE on remote hosts, capturing the resulting dataset locally, and comparing datasets.
By storing the datasets locally, the risk of dataset tampering is restricted to the host(s) running aide-watch.  A `rebase` option
tells aide-watch to update the symbolic link in the data directory, the link refers to the specific dataset to be used as a reference.
Thus a simple invocation of aide-watch is used to update the reference dataset when the differences are have been reviewed.

Aide-watch emails comparison results after every run, including cases where no changes were found.  This consistency facilitates detection
by administrators when aide-watch fails or if it is disabled, legitimately or otherwise.

A sample cron job may be found in `aide-watch.cron`.

A sample SSH configuration may be found in `ssh_config`.  The examples use a private TLD of `aide` to ensure that configuration
errors in cron jobs or manual invocations do not result incorrect host selection for outbound connections.  This is not mandatory,
simply ensure that the target in the cron job matches an entry in the aide-watch ssh config.

## Sample authorized_hosts Entry

Here AIDE is run as root to allow a full filesystem scan.  Note that distributions sometimes put `aide` in other directories.
The SSH key in this example has been abbreviated.  Sudo will need to be configured to allow running the specified command,
e.g. for the `aidewatch` user if you make an `aidewatch` account and put this entry in the account's `authorized_keys` file.

`no-agent-forwarding,no-X11-forwarding,no-port-forwarding,command="/bin/nice /usr/bin/sudo /usr/sbin/aide -c - --init -B report_url=stderr -B dataset_out=stdout" ssh-rsa AAAAB3NzaC1yc2EAAAABIwA...0suis=`
