# E-book (Forecasting: Principles and Practice (3rd ed))

[Visit here](https://otexts.com/fpp3/)


# PPT For Instructors

[Visit here](https://github.com/dsciencelabs/Forcasting/)


# Issues 

When you try to knit the Rmd file, make sure you have installed (updated) the following: 

* https://miktex.org/download
* https://www.texstudio.org/ **(Optional)**
* https://get.adobe.com/reader/
  * uncheck OPTIONAL OFFERS if it's not necessary for you 
  * you can choose either pro version or free (depending on your needs)
* Install tinytex package and install TinyTex distribution.
  * install.packages("tinytex")
  * tinytex::install_tinytex()
* Checked if it was installed.
  * tinytex:::is_tinytex()
* Tryed another option of installation.
  * devtools::install_github('yihui/tinytex')
* Tryed to uninstall and reinstall it some times.
  * tinytex::uninstall_tinytex()
  * remove.packages("tinytex")
* Tryed to fix it since pdflatex.exe could not be found.
  * tinytex:::install_prebuilt()


