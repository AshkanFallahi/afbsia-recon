# afbsia-recon

![Bash Lint](https://github.com/AshkanFallahi/afbsia-recon/actions/workflows/bash-lint.yml/badge.svg)

`afbsia-recon` is a Bash-based automated reconnaissance toolkit for security researchers and penetration testers.

It performs fast and multi-source subdomain enumeration, DNS resolution, probing for live hosts, and delivers results with Telegram integration.

---

## 🚀 Features

- 🔎 Subdomain discovery using **subfinder**, **assetfinder**, **findomain**, **gau**
- 🌐 DNS resolution using **MassDNS**
- 📡 HTTP probing using **httpx-toolkit**
- 🧠 Grouping by HTTP status codes (200s, 400s, etc.)
- 📤 Sends all result files directly to **Telegram**
- ✅ Clean and structured output (`output/` folder)
- 🧩 Modular design for future expansion

---

## 📦 Requirements

Please install the following tools:

```bash
sudo apt install curl git jq -y
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/tomnomnom/assetfinder@latest
go install github.com/Edu4rdSHL/findomain@latest
go install github.com/lc/gau@latest
git clone https://github.com/mellow-io/massdns && cd massdns && make
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
```

Also make sure `$GOPATH/bin` is in your `PATH`.

---

## ⚙️ Usage

```bash
chmod +x afbsia.sh
./afbsia.sh example.com
```

Output will be saved in various `.txt` files and sent via Telegram.

Make sure to set your Telegram `BOT_TOKEN` and `CHAT_ID` inside the script.

---

## 📂 Folder Structure

```
afbsia-recon/
├── afbsia.sh              # Main script
├── config/resolvers.txt   # MassDNS resolvers
├── output/                # Result files go here
├── modules/               # Future bash modules
├── README.md
└── LICENSE
```

---

## 🪪 License

This project is licensed under the [MIT License](LICENSE).

---

## 🙋 Author

**Ashkan Fallahi**  
Pentester | Security Researcher  
GitHub: [@AshkanFallahi](https://github.com/AshkanFallahi)
