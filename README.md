Issues or pull requests are welcome. Discussions focuses on considerations for changes in the future.

A minimal working version of the thesis is available on Crixet (a free, online LaTeX editor): https://app.crixet.com/?u=b855d32f-4d89-4694-bc89-14f2027baad1&pg=1&m=thesis.tex&d=7  
Note, the first compilation is particularly slow.

The examples in this repository are much larger to showcase more situations, show more ISU requirements, and to differentiate between the Journal and Traditional styles.

Tagging does slow down the compiler. Using the draft option while drafting: ```\documentclass[12pt, draft]{isutaggedthesis}``` disables most of tagging, the loading of figures, and other "expensive tasks," making compilation much faster.

If using latexmk with tagging activated, it probably overdoes the number of re-runs, which is part of the slowness problem.

Things to keep in mind while drafting:
1. If you need landscape tables/figures, subfigures, or algorithms, there are competing packages to do the same thing. Use the examples/packages used in the template.
2. Biblatex is needed in the template. To prevent any potential problems, you could use it from the start (but biblatex has pretty good backwards-compatibility with bibtex and natbib).
3. For whatever reason the tagging thing doesn't like if you do something like ```$x_\someCommand{whatever}$``` instead of ```$x_{\someCommand{whatever}}$```  (even though both work with standard latex).
Something like ```$x_1$``` (single character) is fine.
4. The template uses LuaLatex.
5. Alt-text is added to images using ```\includegraphics[alt={alt text here}]{...}```. If you use a recent version of latex, you should be able to add the alt text to includegraphics without any tagging (it does not do anything without tagging, but it also does not break anything). Tables also require markup, for which you need tagging in your document.


When you begin to use the template: 
1. Don't overload the preamble - the template already implements the basics. If you don't know what a package/command in your draft's preamble does, the template probably already handles it.
2. Don't take any warning about tagging too seriously until you run Biber and recompile a few times. 

Official list of packages compatible with tagging: https://latex3.github.io/tagging-project/tagging-status/
The list is pessimistic - some packages labeled as incompatible have workarounds or cause only less-than-ideal tagging.


# Where to Compile
I would recommend using a local installation of LaTeX. If you don't already have your preferred set-up, there are some suggestions in the folder Setting Up Local LaTeX.
It is essential your version of LaTeX is recently updated.

I suspect it won't work with Overleaf (problems detailed below), but this has not yet been tested (let me know if you have!). 
An up-and-coming (free as of 2025) alternative to Overleaf is Crixet.com.
Similar to Overleaf, Crixet is all in-browser and allows for collaboration. Further, Crixet appears to update far more often than Overleaf and has a different behind-the-scenes infrastructure which prevents timeouts.
To use Crixet, at the very top of thesis.tex, replace
```
%!LW recipe=lualatex-plain
```
with
```
% !TEX program = lualatex
```

Upon testing in Summer 2025, the template compiles on Crixet with tagging, however, it is much slower than installing and running LaTeX on your own computer. Using the draft option often is highly recommended.

There are two main problems with Overleaf:

a) As of Spring of 2025, Overleaf's latest version is TexLive 2024, which was probably frozen around March 2024. This version is too old to support tagging table headers.
Soon-ish (as in probably Summer 2025), Overleaf will likely provide TexLive 2025, which will at least support tagging table headers (although the >1 year lag in updates will probably continue to be difficult to accommodate until tagging is fully matured).

b) The compilation timeout on Overleaf is 4 minutes. My thesis at 150 pages with a few figures and too many fonts takes about 2 minutes on my personal hardware. This seems fine, except Overleaf uses latexmk, which actually does multiple runs every time you run it. While you can adjust the max runs, to have a bibliography without constantly changing the latexmk settings, you would probably have to at least let latexmk do Latex -> Biber -> Latex, which could surpass 4 minutes in a lengthy document with alot going on. Latexmk also throws errors around if you prevent it from doing the re-runs it wants to do, so there would probably be many false flags.


# Checking The PDF is Tagged

You can validate the PDF meets ISO tagging standards by using VeraPDF (either by downloading it or at demo.verapdf.org) and using the profile PDF/UA-2. 
Technically, it complains about the font Libertinus (glyph width blah blah blah) in the example files, but that has nothing to do with tagging. If it bothers you, it can be fixed by switching to another font.
If you actually want to manually inspect the tag structure, you can use ngpdf.com (upload the file, then choose the editor option).
