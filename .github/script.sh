#/bin/bash
sudo apt-get install cowsay -y
cowsay -f dragon "Beware! The dragon has awoken!" >> dragon.txt
grep -i "dragon" dragon.txt
cat dragon.txt
ls -ltra