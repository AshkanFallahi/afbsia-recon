# afbsia-recon

Automated reconnaissance script written in Bash.  
Performs subdomain enumeration, DNS resolution, probing, and reporting.

## Features
- Subdomain discovery via subfinder, assetfinder, findomain, gau
- DNS resolution via MassDNS
- HTTP probing via httpx
- Telegram bot integration
- Organized output and live detection

## Usage
```bash
chmod +x afbsia.sh
./afbsia.sh example.com
```

## Requirements
- subfinder, assetfinder, findomain, getallurls, massdns, httpx-toolkit, curl

## License
MIT
![Bash Lint](https://github.com/ashkanfallahi/afbsia-recon/actions/workflows/bash-lint.yml/badge.svg)
