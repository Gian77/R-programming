# *Create and R package, push it on Github and maintain it*

Inspiring guides at: <br>
<https://www.youtube.com/watch?v=kQ5QkN4Kx4Q&t=138s><br>
<https://kbroman.org/pkg_primer/pages/github.html><br>
<https://pjnewcombe.wordpress.com/2014/05/31/using-rstudio-to-create-and-maintain-an-r-package-on-github/>

From RStudio, create a new project. Among the options, choose R package and include the Git option.

Then, click on **Build > Install and Restart**. Then you package should appear if you search for it among R packages.

From GitHub, create a repo with the same name of the newly created R package, do not add anything to it. Github will give you instructions, follow them!

Open a terminal form RStudio form **Git > Shel** and type:

```
gian-21@Gians-MacBook-Air ~ % git init
gian-21@Gians-MacBook-Air ~ % git add .
gian-21@Gians-MacBook-Air ~ % git commit -m "first commit"
```

With double factor authentication remember to use the *SHH* and not *HPTTS*. GitHub will give you instructions for both.

```
gian-21@Gians-MacBook-Air ~ % git remote add origin git@github.com:Gian77/Misfunk.git
gian-21@Gians-MacBook-Air ~ % git branch -M main
gian-21@Gians-MacBook-Air ~ % git push -u origin main
```

> **_NOTE_** If this error occur :
> ```error: remote origin already exists.```
> then you can remove the origin, there cannot be two local repo with the same origin. remove the git origin in one or the other repo in your computer.
> ```git remote remove origin```

Go to Github and refresh the page and your repo should now list all the files generated in RStudio for your R package.

If you want to make modifications or add functions, documentation, manuals etc. to your package, you can do it form RStudio and then commit and push the new/updates files to GitHub. 

Finally, to test if your package can be installed form GitHub, form RStudio:

```> devtools::install_github("Gian77/Misfunk")```

If everything runs smoothly, congrats, you are done!






