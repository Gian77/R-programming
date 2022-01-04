# R-programming

## Pushing your R code to GitHub

A good guide for this task can be found here: 
<https://happygitwithr.com/rstudio-git-github.html>

If you have double authentication factor in your GitHib account you should use *ssh* since *hppts* may give you trouble. 

Have a look at these links:
<https://happygitwithr.com/ssh-keys.html>
<https://gist.github.com/aprilmintacpineda/f101bf5fd34f1e6664497cf4b9b9345f>

First, you need to create key pairs, and enter a passphrase. On Mac you can do:

```
ssh-add --apple-use-keychain ~/.ssh/id_rsa.pub
ssh-add --apple-use-keychain ~/.ssh/id_rsa
```

Then, ob MacOS Sierra o Higher, you have to add these following lines into your `.ssh/config`. If you do not have a config file just create one.

```
gian-21@Gians-MacBook-Air ~ % cat ~/.ssh/config
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
```

Finally you should add your new SSH key `cat ~/.ssh/id_rsa.pub ` into the Github web page and you should be able to commit ans push updates of your code to GitHub, directly form Rstudio.




