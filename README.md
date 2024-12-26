# Windows Batch Files

## Firewall Blocker

- Creates inbound and outbound rules which block all .exe and .dll files in current directory
- Requires admin privileges

## Internet suspend

- Disables internet adapter, launches .exe, re-enables internet
- Use `netsh interface show interface` to list names of available adapters and edit file accordingly
- Change timeout value if required
- Can make shortcut with admin privileges
