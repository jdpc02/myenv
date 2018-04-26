# myenv
Needed to get my repo up and running

Generate a new SSH key for a new machine
ssh-keygen -t rsa -b 4096 -C "identified here"

Quickly add new SSH key to keys
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/yourkeyhere

Add new SSH key to github profile

