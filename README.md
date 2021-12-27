# R-programming

## Pushing your R code to GitHub (this example, is for Mac)

If you have double autentication factor in your GitHib account you should use ssh since hppts may give you trouble. First you have to add these following lines into your .ssh/config. If you do not have a config file just create one.

```
gian-21@Gians-MacBook-Air ~ % cat ~/.ssh/config
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
```
  




