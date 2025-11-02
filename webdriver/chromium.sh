xhost +SI:localuser:root
sudo DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY chromium --no-sandbox
