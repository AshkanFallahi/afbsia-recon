#!/bin/bash

# ───────────────────────────────────────
# Subdomain Enumeration & Reporting Script
# Author: Ashkan
# Telegram Bot Integration
# ───────────────────────────────────────

target=$1
BOT_TOKEN="yourBOT_TOKEN"
CHAT_ID="-CHAT_ID"

# ───────────────────────────────────────
# Step 1: Basic Subdomain Enumeration
# ───────────────────────────────────────

echo -e "\n🔍 Enumerating subdomains for: $target"
echo "➤ Using subfinder..."
subfinder -d "$target" -silent -all > doms.txt

echo "➤ Using assetfinder..."
assetfinder --subs-only "$target" >> doms.txt

echo "➤ Using findomain..."
findomain -t "$target" -q >> doms.txt

echo "➤ Extracting from archived URLs (gau)..."
getallurls -subs "$target" > subs.txt
cut -d '/' -f 3 subs.txt | sort -u >> doms.txt
rm -f subs.txt

# ───────────────────────────────────────
# Step 2: Sorting and Deduplication
# ───────────────────────────────────────

echo -e "\n🔃 Sorting and removing duplicates..."
sort -u doms.txt > subdomains.txt
rm -f doms.txt

# ───────────────────────────────────────
# Step 3: DNS Resolution with MassDNS
# ───────────────────────────────────────

echo -e "\n🌐 Resolving domains using MassDNS..."
massdns -q -r ~/massdns/lists/resolvers.txt -t A subdomains.txt -o S -w res.txt

# Extract resolved subdomains and IPs
awk '{print $1}' res.txt | sed 's/\.$//' | sort -u > subs_ip.txt
grep -v CNAME res.txt | awk '{print $3}' | sort -u > ips.txt

# ───────────────────────────────────────
# Step 4: Probing for Live Hosts (HTTP/S)
# ───────────────────────────────────────

echo -e "\n📡 Checking live IPs..."
cat ips.txt | httpx-toolkit -status-code -follow-redirects -p 80,443,8080,8443 -silent | sort -u > live.txt

echo "📡 Checking live subdomains..."
cat subs_ip.txt | httpx-toolkit -status-code -follow-redirects -silent -p 80,443,8443,8080 -t 250 | sort -u > live-doms.txt

# ───────────────────────────────────────
# Step 5: Grouping by HTTP Status Code
# ───────────────────────────────────────

echo -e "\n🗂️ Grouping based on status codes..."
grep " 20" live-doms.txt | awk '{print $1}' | sort -u > ext-doms.txt
grep " 40" live-doms.txt | awk '{print $1}' | sort -u > int-doms.txt

# ───────────────────────────────────────
# Step 6: Send Results to Telegram
# ───────────────────────────────────────

echo -e "\n🚀 Sending results to Telegram..."

for file in *.txt; do
  if [[ -s "$file" ]]; then
    echo "📤 Sending $file ..."
    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendDocument" \
      -F chat_id="$CHAT_ID" \
      -F document=@"$file" \
      -F caption="📄 File: *$file* for domain: *$target*" \
      > /dev/null
  fi
done

echo -e "\n✅ Done."
























