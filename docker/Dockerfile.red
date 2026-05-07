FROM archlinux:latest

LABEL org.opencontainers.image.title="Syndra Red Team"
LABEL org.opencontainers.image.description="Isolated Red Team security toolkit for Syndra"

RUN pacman -Syu --noconfirm \
    && pacman -S --needed --noconfirm \
        python python-pip git wget curl base-devel nodejs npm go rust \
        nmap masscan wireshark-cli tcpdump \
        hashcat john aircrack-ng hydra sqlmap nikto metasploit \
        burpsuite zaproxy gobuster ffuf wfuzz dirb exploitdb \
        binwalk foremost steghide exiftool radare2 gdb ghidra \
    && pacman -Scc --noconfirm

RUN pip install --no-cache-dir \
    impacket crackmapexec bloodhound pwntools scapy paramiko requests beautifulsoup4 lxml

RUN useradd -m -s /bin/bash syndra
USER syndra
WORKDIR /workspace

CMD ["bash"]
